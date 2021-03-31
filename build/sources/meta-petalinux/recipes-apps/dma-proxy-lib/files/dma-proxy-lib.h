#ifndef __DMA_PROXY_LIB__
#define __DMA_PROXY_LIB__

#include <stdint.h>
#include <linux/ioctl.h>

#ifdef __cplusplus
extern "C" {
#endif

#define REG_SPACE_BASE_ADDR 	0xA0000000
#define REG_SPACE_SIZE			0x30000			// 64 KB

/**
 * 
 */ 
uint32_t reg_read32(uint32_t offset);

/**
 * 
 */ 
int reg_write32(uint32_t offset, uint32_t value);




#ifdef __cplusplus
}  // End of extern "C"
#endif

#endif
