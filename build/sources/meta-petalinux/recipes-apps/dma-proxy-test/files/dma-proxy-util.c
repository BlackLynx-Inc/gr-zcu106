#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/ioctl.h>

#include <dma-proxy-lib.h>

int main(int argc, char** argv)
{
    printf("DMA Proxy Util\n\n");
    
    // Set default buffer size and override with command line argument as needed
    size_t buf_size = 1024 * 1024;
    if (argc > 1)
    {
        buf_size = atoi(argv[1]);
        printf("Setting buffer size to: %u\n", buf_size);
    }
    
    // Allocate the buffer
    char* dma_buffer = (char*)dmap_alloc_buffer(buf_size);
    if (dma_buffer == NULL)
    {
        printf("DMA buffer allocation failed\n");
        return -1;
    }
    
    //~ char* dma_buffer2 = (char*)dmap_alloc_buffer(67108864);
    //~ if (dma_buffer2 == NULL)
    //~ {
        //~ printf("DMA buffer allocation failed\n");
        //~ return -1;
    //~ }
    
    printf("GOT THE BUFFER!\n");
    
#if 1
    memset(dma_buffer, 0x5A, buf_size);
    printf("WROTE THE BUFFER!\n");
#endif

    printf("[WR] BEFORE: 0x%08X\n", *(uint32_t*)dma_buffer);

    int rc = dmap_write((void*)dma_buffer, 0x0, buf_size);
    printf("DMA WRITE: %d\n", rc);
    
    printf("[WR] AFTER: 0x%08X\n", *(uint32_t*)dma_buffer);
    
    // Free the buffer
    dmap_free_buffer(dma_buffer);
    //~ dmap_free_buffer(dma_buffer2);
    
    printf("[FIN]\n");
    
    return 0;
}
