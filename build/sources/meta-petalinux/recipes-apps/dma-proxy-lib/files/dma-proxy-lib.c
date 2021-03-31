#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>


#include "dma-proxy-lib.h"

static int __dma_proxy_reg_space_fd;
static void *__dma_proxy_reg_space_ptr;


// Make init and fini functions as constructor and destructor
void dma_proxy_lib_init() __attribute__((constructor));
void dma_proxy_lib_fini() __attribute__((destructor));


/**
 * DMA proxy userspace library "constructor"
 */
void dma_proxy_lib_init()
{
	// Initialize the register space FD and pointer
	__dma_proxy_reg_space_fd = 0;
	__dma_proxy_reg_space_ptr = NULL;
}

/**
 * DMA proxy userspace library "destructor"
 */ 
void dma_proxy_lib_fini()
{
	// If the register address space was mapped, unmap it and clean up
	if (__dma_proxy_reg_space_ptr != NULL)
	{
		munmap(__dma_proxy_reg_space_ptr, REG_SPACE_SIZE);
		__dma_proxy_reg_space_ptr = NULL;
		close(__dma_proxy_reg_space_fd);
		__dma_proxy_reg_space_ptr = 0;
	}
}

static int _map_reg_space()
{
	__dma_proxy_reg_space_fd = open("/dev/mem", O_RDWR);
	if (__dma_proxy_reg_space_fd < 1) 
	{
		return -1;
	}
	
	__dma_proxy_reg_space_ptr = mmap(NULL, REG_SPACE_SIZE, PROT_READ | PROT_WRITE,
	                                 MAP_SHARED, __dma_proxy_reg_space_fd, 
	                                 REG_SPACE_BASE_ADDR);
	if (__dma_proxy_reg_space_ptr == MAP_FAILED) 
	{
		return -2;
	}
	
	return 0;
}

uint32_t reg_read32(uint32_t offset)
{
	uint32_t value = 0xDEADDEAD;
	
	// Make sure the offset doesn't exceed the size of the mapped space
	if (offset > REG_SPACE_SIZE)
	{
		return value;
	}
	
	// Map the register space if it is not already mapped
	if (__dma_proxy_reg_space_ptr == NULL)
	{
		if (_map_reg_space() != 0)
		{
			return value;
		}
	}
	
	value = *(uint32_t*)(__dma_proxy_reg_space_ptr + offset);
	return value;
}

int reg_write32(uint32_t offset, uint32_t value)
{
	// Make sure the offset doesn't exceed the size of the mapped space
	if (offset > REG_SPACE_SIZE)
	{
		return -1;
	}
	
	// Map the register space if it is not already mapped
	if (__dma_proxy_reg_space_ptr == NULL)
	{
		_map_reg_space();
	}
	
	*(uint32_t*)(__dma_proxy_reg_space_ptr + offset) = value;
	
	return 0;
}
