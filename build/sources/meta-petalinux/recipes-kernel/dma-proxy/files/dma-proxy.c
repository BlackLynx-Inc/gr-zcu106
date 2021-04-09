/*  dma-proxy.c - The simplest kernel module.
*
* Copyright (C) 2013 - 2016 Xilinx, Inc
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 2 of the License, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License along
*   with this program. If not, see <http://www.gnu.org/licenses/>.
*   
*   DMA Proxy
*
*   This module is designed to be a small example of a DMA device driver that is
*   a client to the DMA Engine using the AXI DMA driver. It serves as a proxy for
*   kernel space DMA control to a user space application.
*
*   A zero copy scheme is provided by allowing user space to mmap a kernel allocated
*   memory region into user space, referred to as a proxy channel interface. The
*   ioctl function is provided to start a DMA transfer which then blocks until the
*   transfer is complete. No input arguments are being used in the ioctl function.
*
*   There is an associated user space application, dma_proxy_test.c, and dma_proxy.h
*   that works with this device driver.
*
*   The hardware design was tested with an AXI DMA without scatter gather and
*   with the transmit channel looped back to the receive channel.
*
*   This driver is character driver which creates 2 devices that user space can
*   access for each DMA channel, /dev/dma_proxy_rx and /dev/dma_proxy_tx.

*   An internal test mode is provided to allow it to be self testing without the 
*   need for a user space application and this mode is good for making bigger
*   changes to this driver.
*
*   This driver is designed to be simple to help users get familiar with how to 
*   use the DMA driver provided by Xilinx which uses the Linux DMA Engine. The 
*   performance of this example is not expected to be high without more work.
*
*   To use this driver a node must be added into the device tree.  Add the 
*   following node while adjusting the dmas property to match the name of 
*   the AXI DMA node.
* 
*   dma_proxy_test_0: dma_proxy@0 {
*   	compatible ="xlnx,dma_proxy";
*		dmas = <&axi_dma_0 0
*				&axi_dma_0 1>;
*		dma-names = "dma_proxy_tx", "dma_proxy_rx";
*	};
*
*/

#include <linux/kernel.h>
#include <linux/dmaengine.h>
#include <linux/module.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/dma-mapping.h>
#include <linux/slab.h>
#include <linux/cdev.h>
#include <linux/device.h>
#include <linux/fs.h>
#include <linux/workqueue.h>
#include <linux/platform_device.h>
#include <linux/of_dma.h>

#include "dma-proxy.h"

#undef INTERNAL_TEST

MODULE_LICENSE("GPL");

#define DRIVER_NAME 		"dma_proxy"
#define CHANNEL_COUNT 		2
#define TX_CHANNEL			0
#define RX_CHANNEL			1
#define ERROR 			   -1
#define NOT_LAST_CHANNEL 	0

/* 
 * The following module parameter controls if the internal test runs when the module is inserted.
 */
static unsigned internal_test = 0;
module_param(internal_test, int, S_IRUGO);


/* 
 * The following data structure represents a single channel of DMA, transmit or receive in the case
 * when using AXI DMA.  It contains all the data to be maintained for the channel.
 */
struct dma_proxy_channel {
	struct xilinx_dma_t* parent;		/* pointer back to parent */

	struct dma_chan *channel_p;			/* dma support */
	struct completion cmp;
	dma_cookie_t cookie;
	//~ dma_addr_t dma_handle;
	u32 direction;						/* DMA_MEM_TO_DEV or DMA_DEV_TO_MEM */
	struct scatterlist sglist;
};

struct xilinx_dma_t {
	struct device *proxy_device_p;		/* character device support */
	struct device *dma_device_p;
	dev_t dev_node;
	struct cdev cdev;
	struct class *class_p;
	
	struct dma_proxy_channel tx_channel;
	struct dma_proxy_channel rx_channel;
};

enum proxy_status { PROXY_NO_ERROR = 0, PROXY_BUSY = 1, PROXY_TIMEOUT = 2, PROXY_ERROR = 3 };

struct dma_proxy_file_t {
	struct xilinx_dma_t* proxy_dev;	/* owning device for this buffer */
	dma_addr_t phys_addr;			/* bus address of DMA buffer */
	void *virt_address;     		/* kernel virtual address of the DMA buffer */
	size_t size;          			/* buffer size in bytes */
	enum proxy_status status;		/* status of the proxy channel */
};


/* Handle a callback and indicate the DMA transfer is complete to another
 * thread of control
 */
static void sync_callback(void *completion)
{
	/* Indicate the DMA transaction completed to allow the other
	 * thread of control to finish processing
	 */
	complete(completion);
}

/* 
 * Prepare a DMA buffer to be used in a DMA transaction, submit it to the DMA engine
 * to be queued and return a cookie that can be used to track that status of the
 * transaction
 */
static int start_transfer(struct dma_proxy_channel* pchannel_p, 
						  struct dma_proxy_file_t* proxy_file,
						  struct dma_proxy_rw_info* rw_info)
{
	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
	struct dma_async_tx_descriptor *chan_desc;
	struct dma_device *dma_device = pchannel_p->channel_p->device;
	
	/* 
	 * For now use a single entry in a scatter gather list just for future
	 * flexibility for scatter gather.
	 */
	sg_init_table(&pchannel_p->sglist, 1);
	sg_dma_address(&pchannel_p->sglist) = proxy_file->phys_addr;
	sg_dma_len(&pchannel_p->sglist) = rw_info->length;

	chan_desc = dma_device->device_prep_slave_sg(pchannel_p->channel_p, 
												 &pchannel_p->sglist, 1, 
												 pchannel_p->direction, flags, 
												 NULL);

	/*
	 *  Make sure the operation was completed successfully
	 */
	if (! chan_desc) 
	{
		pr_err("dmaengine_prep*() error\n");
		return -1;
	} 
	else 
	{
		chan_desc->callback = sync_callback;
		chan_desc->callback_param = &pchannel_p->cmp;

		/* 
		 * Initialize the completion for the transfer and before using it
		 * then submit the transaction to the DMA engine so that it's queued
		 * up to be processed later and get a cookie to track it's status
		 */
		init_completion(&pchannel_p->cmp);
		
		pchannel_p->cookie = dmaengine_submit(chan_desc);
		if (dma_submit_error(pchannel_p->cookie)) 
		{
			pr_err("Submit error\n");
	 		return -2;
		}
		
		/* 
		 * Start the DMA transaction which was previously queued up in the DMA engine
		 */
		dma_async_issue_pending(pchannel_p->channel_p);
	}

	return 0;
}

/* Wait for a DMA transfer that was previously submitted to the DMA engine
 */
static void wait_for_transfer(struct dma_proxy_channel *pchannel_p,
							  struct dma_proxy_file_t* proxy_file)
{
	unsigned long timeout = msecs_to_jiffies(3000);
	enum dma_status status;

	proxy_file->status = PROXY_BUSY;
	
	/* 
	 * Wait for the transaction to complete, or timeout, or get an error
	 */
	timeout = wait_for_completion_timeout(&pchannel_p->cmp, timeout);
	dma_cookie_t last_completed;
	dma_cookie_t last_issued;
	
	status = dma_async_is_tx_complete(pchannel_p->channel_p, pchannel_p->cookie, 
									  &last_completed, &last_issued);
	
	if (timeout == 0)  
	{
		proxy_file->status = PROXY_TIMEOUT;
		pr_err("DMA timed out\n");
	} 
	else if (status != DMA_COMPLETE) 
	{
		proxy_file->status = PROXY_ERROR;
		pr_err("DMA returned completion callback status of: %s\n",
			   status == DMA_ERROR ? "error" : "in progress");
	} 
	else
	{
		proxy_file->status = PROXY_NO_ERROR;
	}
}

static void test(void)
{
#if 0
	int i;
	struct work_struct work;
	
	pr_alert("Starting internal test\n");

	/* Initialize the buffers for the test
	 */
	for (i = 0; i < TEST_SIZE; i++) {
		channels[TX_CHANNEL].interface_p->buffer[i] = i;
		channels[RX_CHANNEL].interface_p->buffer[i] = 0;
	}

	/* Since the transfer function is blocking the transmit channel is started from a worker
	 * thread
	 */
	INIT_WORK(&work, tx_test);
	schedule_work(&work);

	/* Receive the data that was just sent and looped back
	 */
	channels[1].interface_p->length = TEST_SIZE;
	transfer(&channels[1]);

	/* Verify the receiver buffer matches the transmit buffer to
	 * verify the transfer was good
	 */
	for (i = 0; i < TEST_SIZE; i++)
		if (channels[TX_CHANNEL].interface_p->buffer[i] !=
			channels[RX_CHANNEL].interface_p->buffer[i]) {
			printk("buffers not equal, first index = %d\n", i);
			break;
		}

	pr_alert("Internal test complete\n");
#endif
}

/**
 * Empty placeholder function for a required function
 */
static void dma_proxy_vma_open(struct vm_area_struct *vma)
{
}

/**
 * Free all of the DMA buffers that were allocated in the mmap call. This
 * function gets called after the munmap syscall returns success.
 */
static void dma_proxy_vma_close(struct vm_area_struct *vma)
{
	struct file *file = vma->vm_file;
	struct dma_proxy_file_t* proxy_file = (struct dma_proxy_file_t*)file->private_data;
	struct xilinx_dma_t* xilinx_dma = proxy_file->proxy_dev;
	
	// Free the DMA buffer that was allocated in the mmap call
	dma_free_coherent(xilinx_dma->dma_device_p, proxy_file->size, 
					  proxy_file->virt_address, proxy_file->phys_addr);
	
	// Reset values just in case
	proxy_file->size = 0; 
	proxy_file->virt_address = NULL;
	proxy_file->phys_addr = 0;
}

static struct vm_operations_struct dma_proxy_vm_ops = {
    .open  = dma_proxy_vma_open,
    .close = dma_proxy_vma_close,
};

/** 
 * Map buffer memory.
 */
static int mmap(struct file *file, struct vm_area_struct *vma)
{
	struct dma_proxy_file_t* proxy_file = (struct dma_proxy_file_t*)file->private_data;
	struct xilinx_dma_t* xilinx_dma = proxy_file->proxy_dev;

	// Determine the size that userspace is attempting to mmap
    size_t size = vma->vm_end - vma->vm_start;
	proxy_file->size = size;

	// Allocate the DMA buffer
	proxy_file->virt_address = dma_alloc_coherent(xilinx_dma->dma_device_p, 
												  size, 
											   	  &proxy_file->phys_addr, 
											   	  GFP_KERNEL);
											   	  
	if (proxy_file->virt_address == NULL)
	{
		pr_err("dma_alloc_coherent() -- FAILED\n");
		return -ENOMEM;
	}

	// Install custom VM operations
    vma->vm_ops = &dma_proxy_vm_ops;

	// Map the DMA buffer into the VMA
	return dma_mmap_coherent(xilinx_dma->dma_device_p, vma,
			    			 proxy_file->virt_address, proxy_file->phys_addr,
						     size);
}

/** 
 * Open the device file, allocate per file structure, and set up the data pointer 
 * such that the ioctl function can access the data structure later.
 */
static int local_open(struct inode *ino, struct file *file)
{
	// Grab pointer to the proxy device structure
	struct xilinx_dma_t* xilinx_dma = container_of(ino->i_cdev, struct xilinx_dma_t, cdev);
	 
	// Allocate per file (i.e. buffer) structure
	struct dma_proxy_file_t* proxy_file = kzalloc(sizeof(struct dma_proxy_file_t), GFP_KERNEL);
	if (proxy_file == NULL) {
		return -ENOMEM;
	}
	
	// Store pointer to parent device and stash in file
	proxy_file->proxy_dev = xilinx_dma;
	file->private_data = proxy_file;
	
	return 0;
}

/** 
 * Close the file and free the per file data structure
 */
static int release(struct inode *ino, struct file *file)
{
	struct dma_proxy_file_t* proxy_file = (struct dma_proxy_file_t*)file->private_data;
	
	// Check status and wait if busy?
	
	// Free file struct
    kfree(proxy_file);
	
	return 0;
}

/* Perform I/O control to start a DMA transfer.
 */
static long ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	struct dma_proxy_file_t* proxy_file = (struct dma_proxy_file_t*)file->private_data;
	struct xilinx_dma_t* xilinx_dma = proxy_file->proxy_dev;
	
	long ret = 0;
	int rc = 0;
	struct dma_proxy_rw_info rw_info;

	// Decode the IOCTL
    switch (cmd) {
		
		case DMA_PROXY_IOC_READ:
			// Copy the R/W info struct in from userspace
            ret = copy_from_user(&rw_info, (void *)arg, sizeof(struct dma_proxy_rw_info));
            if (ret) 
            {
                break;
            }
            
            // Do the transfer
            rc = start_transfer(&xilinx_dma->rx_channel, proxy_file, &rw_info);
            if (rc)
            {
				return -1;
			}
            
            wait_for_transfer(&xilinx_dma->rx_channel, proxy_file);
			break;
		
		case DMA_PROXY_IOC_WRITE:
			// Copy the R/W info struct in from userspace
            ret = copy_from_user(&rw_info, (void *)arg, sizeof(struct dma_proxy_rw_info));
            if (ret) 
            {
                break;
            }
            
            // Do the transfer
            rc = start_transfer(&xilinx_dma->tx_channel, proxy_file, &rw_info);
            if (rc)
            {
				return -1;
			}
            
            wait_for_transfer(&xilinx_dma->tx_channel, proxy_file);
			break;
		
		default:
            ret = -ENOTTY;
            break;
	}

	return ret;
}

static struct file_operations dm_fops = {
	.owner    = THIS_MODULE,
	.open     = local_open,
	.release  = release,
	.unlocked_ioctl = ioctl,
	.mmap	= mmap
};

/** 
 * Initialize the driver to be a character device such that is responds to
 * file operations.
 */
static int cdevice_init(struct xilinx_dma_t *xilinx_dma_p, char *name)
{
	int rc;
	char device_name[32] = "xilinx_dma_proxy";

	/* 
	 * Allocate a character device from the kernel for this driver.
	 */
	rc = alloc_chrdev_region(&xilinx_dma_p->dev_node, 0, 1, device_name);
	if (rc) {
		dev_err(xilinx_dma_p->dma_device_p, "unable to get a char device number\n");
		return rc;
	}

	/* 
	 * Initialize the device data structure before registering the character 
	 * device with the kernel.
	 */
	cdev_init(&xilinx_dma_p->cdev, &dm_fops);
	xilinx_dma_p->cdev.owner = THIS_MODULE;
	rc = cdev_add(&xilinx_dma_p->cdev, xilinx_dma_p->dev_node, 1);
	if (rc) {
		dev_err(xilinx_dma_p->dma_device_p, "unable to add char device\n");
		goto init_error1;
	}

	/* 
	 * Create sysfs class to create the device in sysfs which will allow the 
	 * device node in /dev to be created
	 */
	xilinx_dma_p->class_p = class_create(THIS_MODULE, DRIVER_NAME);
	if (IS_ERR(xilinx_dma_p->dma_device_p->class)) {
		dev_err(xilinx_dma_p->dma_device_p, "unable to create class\n");
		rc = ERROR;
		goto init_error2;
	}

	/* 
	 * Create the device node in /dev so the device is accessible as a 
	 * character device
	 */
	strcat(device_name, name);
	xilinx_dma_p->proxy_device_p = device_create(xilinx_dma_p->class_p, NULL,
												 xilinx_dma_p->dev_node, NULL, 
												 name);
	if (IS_ERR(xilinx_dma_p->proxy_device_p)) {
		dev_err(xilinx_dma_p->dma_device_p, "unable to create the device\n");
		goto init_error3;
	}

	return 0;

init_error3:
	class_destroy(xilinx_dma_p->class_p);

init_error2:
	cdev_del(&xilinx_dma_p->cdev);

init_error1:
	unregister_chrdev_region(xilinx_dma_p->dev_node, 1);
	return rc;
}

/* 
 * Exit the character device by freeing up the resources that it created and
 * disconnecting itself from the kernel.
 */
static void cdevice_exit(struct xilinx_dma_t *xilinx_dma_p)
{
	/* 
	 * Take everything down in the reverse order from how it was created for 
	 * the char device
	 */
	device_destroy(xilinx_dma_p->class_p, xilinx_dma_p->dev_node);
	class_destroy(xilinx_dma_p->class_p);
	cdev_del(&xilinx_dma_p->cdev);
	unregister_chrdev_region(xilinx_dma_p->dev_node, 1);
}

/**
 * Create a DMA channel by getting a DMA channel from the DMA Engine and then 
 * setting up the channel as a character device to allow user space control.
 */
static int create_channel(struct platform_device *pdev, struct dma_proxy_channel *pchannel_p, 
							char *name, u32 direction)
{
	int rc;

	/* 
	 * Request the DMA channel from the DMA engine and then use the device from
	 * the channel for the proxy channel also.
	 */
	pchannel_p->channel_p = dma_request_slave_channel(&pdev->dev, name);
	if (!pchannel_p->channel_p) 
	{
		dev_err(pchannel_p->parent->dma_device_p, "DMA channel request error\n");
		return ERROR;
	}
	
	pchannel_p->direction = direction;
	
	return 0;
}

/** 
 * Initialize the dma proxy device driver module.
 */
static int dma_proxy_probe(struct platform_device *pdev)
{
	int rc;

	pr_info("BLNX - dma_proxy module initialized\n");

	/*
	 * Allocate private data for the platform device and stash
	 */ 
	struct xilinx_dma_t* xilinx_dma = kzalloc(sizeof(struct xilinx_dma_t), GFP_KERNEL);
	if (xilinx_dma == NULL) {
		return -EIO;
	}
	platform_set_drvdata(pdev, xilinx_dma);
	
	/*
	 * First, attempt to create TX and RX DMA channels
	 */ 
	xilinx_dma->dma_device_p = &pdev->dev; 
	xilinx_dma->tx_channel.parent = xilinx_dma;
	xilinx_dma->rx_channel.parent = xilinx_dma;
	 
	rc = create_channel(pdev, &xilinx_dma->tx_channel, "dma_proxy_tx", DMA_MEM_TO_DEV);
	if (rc) {
		pr_err("unable to create TX channel");
		return rc;
	}
	
	rc = create_channel(pdev, &xilinx_dma->rx_channel, "dma_proxy_rx", DMA_DEV_TO_MEM);
	if (rc) {
		pr_err("unable to create RX channel");
		return rc;
	}
	
	/* 
	 * Now initialize the character device 
	 */
	rc = cdevice_init(xilinx_dma, "xilinx_dma_proxy");
	if (rc) {
		return rc;
	}
	
	return 0;
}
 
/** 
 * Exit the dma proxy device driver module.
 */
static int dma_proxy_remove(struct platform_device *pdev)
{
	int i = 0;

	pr_info("BLNX - dma_proxy module exited\n");
	
	/*
	 * Retrieve the xilinx_dma_t
	 */ 
	struct xilinx_dma_t* xilinx_dma = platform_get_drvdata(pdev);

	/* 
	 * Take care of the DMA channels and the any buffers allocated for the DMA 
	 * transfers. The DMA buffers are using managed memory such that it's 
	 * automatically done.
	 */
	struct dma_chan *tx_channel = xilinx_dma->tx_channel.channel_p;	 
	tx_channel->device->device_terminate_all(tx_channel);
	dma_release_channel(tx_channel);
	
	struct dma_chan *rx_channel = xilinx_dma->rx_channel.channel_p;	 
	rx_channel->device->device_terminate_all(rx_channel);
	dma_release_channel(rx_channel);

	/*
	 * Teardown character device
	 */ 
	cdevice_exit(xilinx_dma);
	kfree(xilinx_dma);

	return 0;
}

static const struct of_device_id dma_proxy_of_ids[] = {
	{ .compatible = "xlnx,dma_proxy",},
	{}
};

static struct platform_driver dma_proxy_driver = {
	.driver = {
		.name = "dma_proxy_driver",
		.owner = THIS_MODULE,
		.of_match_table = dma_proxy_of_ids,
	},
	.probe = dma_proxy_probe,
	.remove = dma_proxy_remove,
};

static int __init dma_proxy_init(void)
{
	pr_info("BLNX --  LOADING DMA PROXY\n");
	
	return platform_driver_register(&dma_proxy_driver);

}

static void __exit dma_proxy_exit(void)
{
	platform_driver_unregister(&dma_proxy_driver);
	
	pr_info("BLNX --  REMOVING DMA PROXY\n");
}

module_init(dma_proxy_init)
module_exit(dma_proxy_exit)

MODULE_AUTHOR("Xilinx, Inc.; BlackLynx Inc.");
MODULE_DESCRIPTION("DMA Proxy Prototype");
MODULE_LICENSE("GPL v2");
