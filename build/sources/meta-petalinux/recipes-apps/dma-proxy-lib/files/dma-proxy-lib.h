#ifndef __DMA_PROXY_LIB__
#define __DMA_PROXY_LIB__

#include <stdint.h>
#include <linux/ioctl.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DMA_PROXY_DEVICE		"/dev/xilinx_dma_proxy"
#define MAX_DEVICE_MEMORY		0x80000000L

#define REG_SPACE_BASE_ADDR 	0xA0000000
#define REG_SPACE_SIZE			0x30000			// 64 KB

// NOTE: this is currently duplicated, even though it really shouldn't be
#define DMA_PROXY_IOCTL_MAGIC  'b'
#define DMA_PROXY_IOC_READ	_IOW(DMA_PROXY_IOCTL_MAGIC,  0, int)  //!< IOCTL: read from device RAM
#define DMA_PROXY_IOC_WRITE	_IOW(DMA_PROXY_IOCTL_MAGIC,  1, int)  //!< IOCTL: write to device RAM

/**
 * Read 32 bit value from the specified offset in the register space.
 */ 
uint32_t dmap_reg_read32(uint32_t offset);

/**
 * Write 32 bit specified value to the specified offset in the register space.
 */ 
int dmap_reg_write32(uint32_t offset, uint32_t value);

/**
 * Allocate a DMA buffer of the specified size.
 */ 
void* dmap_alloc_buffer(size_t size);

/**
 * Free a previously allocated DMA buffer.
 */ 
void dmap_free_buffer(void* buffer);



#ifdef __cplusplus
}  // End of extern "C"
#endif

#endif
