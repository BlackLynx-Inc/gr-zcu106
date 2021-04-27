#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <pthread.h>

#include <dma-proxy-lib.h>

struct write_thread_args 
{
    char* dma_buffer;
    size_t buffer_size;
    uint32_t offset;
    uint32_t xfer_len;
};

void* write_thread(struct write_thread_args* args)
{
    printf("[WRT] Write thread running...\n");
    
    // Write unique pattern to transmit buffer
    memset(args->dma_buffer, 0xC3, args->buffer_size);
    printf("[WRT] WROTE THE BUFFER!\n");

#if 1
    // Write/transmit the data
    int rc = dmap_write((void*)args->dma_buffer + args->offset, args->xfer_len);
    if (rc)
    {
        fprintf(stderr, "[WRT] DMA write failed: %d\n", rc);
    }
    
    printf("[WRT] complete\n");
#endif
    
    return NULL;
}

int main(int argc, char** argv)
{
    printf("DMA Proxy Util\n\n");
    
    // Set default arguments and override with command line arguments as needed
    size_t buf_size = 1024 * 1024;
    uint32_t offset = 0;
    uint32_t xfer_len = buf_size;
    if (argc == 1)
    {
        ;
    }
    else if (argc == 2)
    {
        buf_size = strtol(argv[1], NULL, 0);
        xfer_len = buf_size;
    }
    else if (argc == 3)
    {
        fprintf(stderr, "ERROR: please specify offset and length: "
                "./dma-proxy-util [buffer size] [buffer offset] [xfer length]\n");
        return -1;
    }
    else if (argc == 4)
    {
        buf_size = strtol(argv[1], NULL, 0);
        offset = strtol(argv[2], NULL, 0);
        xfer_len = strtol(argv[3], NULL, 0);
        printf("Setting buffer size to: %u; offset: 0x%08X; xfer len: %u\n", 
               buf_size, offset, xfer_len);
    }
    else
    {
        fprintf(stderr, "ERROR: too many arguments specified: "
                "./dma-proxy-util [buffer size] [buffer offset] [xfer length]\n");
        return -1;
    }
    
    printf("Buffer size: %u\n", buf_size);
    printf("Buffer offset: %u\n", offset);
    printf("Xfer length: %u\n", xfer_len);
    fflush(stdout);
    
    // Allocate transmit buffer
    char* tx_dma_buffer = (char*)dmap_alloc_buffer(buf_size);
    if (tx_dma_buffer == NULL)
    {
        fprintf(stderr, "[WRT] DMA buffer allocation failed\n");
        return;
    }
    
    // Allocate receive buffer
    char* rx_dma_buffer = (char*)dmap_alloc_buffer(buf_size);
    if (rx_dma_buffer == NULL)
    {
        fprintf(stderr, "DMA buffer allocation failed\n");
        return -1;
    }
    
    // Write a pattern to the recieve buffer 
    memset(rx_dma_buffer, 0x5A, buf_size);
    
    struct write_thread_args args;
    args.dma_buffer = tx_dma_buffer;
    args.buffer_size = buf_size;
    args.offset = offset;
    args.xfer_len = xfer_len;

    // Spawn the write thread
    pthread_t tid;
    pthread_create(&tid, NULL, write_thread, &args);

    printf("Buffer contents BEFORE: 0x%08X\n", *(uint32_t*)rx_dma_buffer);

    // Read the transmitted data back
    int rc = dmap_read((void*)rx_dma_buffer + offset, xfer_len);
    if (rc)
    {
        fprintf(stderr, "[WRT] DMA read failed: %d\n", rc);
    }
    
    // Join the write thread
    pthread_join(tid, NULL);
    
    printf("Buffer contents AFTER:  0x%08X\n", *(uint32_t*)rx_dma_buffer);
    
    // Validate the read/receive buffer data if there were not transfer errors;
    // NOTE: this can be pretty slow for large buffer sizes
    if (! rc)
    {
        bool miscompares = false;
        uint64_t* tx_data = (uint64_t*)tx_dma_buffer;
        uint64_t* rx_data = (uint64_t*)rx_dma_buffer; 
        for (uint32_t idx = 0; idx < (buf_size / sizeof(uint64_t)); ++idx)
        {
            if (tx_data[idx] != rx_data[idx])
            {
                fprintf(stderr, "MISCOMPARE: 0x%08X -- 0x%016llX -- 0x%016llX\n", 
                        (idx * sizeof(uint64_t)), tx_data[idx], rx_data[idx]);
                miscompares = true;
            }
#if 0
            else
            {
                fprintf(stderr, "            0x%08X -- 0x%016llX -- 0x%016llX\n", 
                        (idx * sizeof(uint64_t)), tx_data[idx], rx_data[idx]);
            }
#endif
        }
        
        if (miscompares)
        {
            printf("\nCompare UNSUCCESSFUL\n\n");
        }
        else
        {
            printf("\nCompare SUCCESSFUL\n\n");
        }
    }
    
    // Free the buffers
    dmap_free_buffer(tx_dma_buffer);
    dmap_free_buffer(rx_dma_buffer);
    
    printf("[FIN]\n");
    
    return 0;
}
