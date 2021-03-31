#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include <dma-proxy-lib.h>

int main(int argc, char** argv)
{
    printf("DMA Proxy Reg Util\n\n");
    
    if (argc > 1)
    {
        uint32_t offset = strtoul(argv[1], NULL, 0);
        printf("Offset: 0x%08X -- 0x%08X\n", offset, reg_read32(offset));
    }
    
    return 0;
}
