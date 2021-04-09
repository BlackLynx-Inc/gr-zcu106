#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>

#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <pthread.h>

#include <dma-proxy-lib.h>

void* write_thread(size_t buffer_size)
{
    printf("[WRT] Write thread running...\n");
    
    // Allocate transmit buffer
    char* dma_buffer = (char*)dmap_alloc_buffer(buffer_size);
    if (dma_buffer == NULL)
    {
        fprintf(stderr, "[WRT] DMA buffer allocation failed\n");
        return;
    }
    
    // Write unique pattern to transmit buffer
    memset(dma_buffer, 0xC3, buffer_size);
    printf("[WRT] WROTE THE BUFFER!\n");
    
    // Write/transmit the data
    int rc = dmap_write((void*)dma_buffer, 0x0, buffer_size);
    if (rc)
    {
        fprintf(stderr, "[WRT] DMA write failed: %d\n", rc);
    }
    
    dmap_free_buffer(dma_buffer);
    
    printf("[WRT] complete\n");
}

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
        fprintf(stderr, "DMA buffer allocation failed\n");
        return -1;
    }
    
    // Write a pattern to the recieve buffer 
    memset(dma_buffer, 0x5A, buf_size);

    // Spawn the write thread
    pthread_t tid;
    pthread_create(&tid, NULL, write_thread, buf_size);

    printf("Buffer contents BEFORE: 0x%08X\n", *(uint32_t*)dma_buffer);

    // Read the transmitted data back
    int rc = dmap_read((void*)dma_buffer, 0x0, buf_size);
    if (rc)
    {
        fprintf(stderr, "[WRT] DMA read failed: %d\n", rc);
    }
    
    // Join the write thread
    pthread_join(tid, NULL);
    
    printf("Buffer contents AFTER: 0x%08X\n", *(uint32_t*)dma_buffer);
    
    // Free the buffer
    dmap_free_buffer(dma_buffer);
    
    printf("[FIN]\n");
    
    return 0;
}
