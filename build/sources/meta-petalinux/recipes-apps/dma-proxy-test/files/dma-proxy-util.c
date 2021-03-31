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
    
    int fd = open("/dev/xilinx_dma_proxy", O_RDWR);
	if (fd < 1) 
	{
		printf("Unable to open DMA proxy device file");
		return -1;
	}
    
    size_t buf_size = 4096;
    if (argc > 1)
    {
        buf_size = atoi(argv[1]);
        printf("Setting buffer size to: %u\n", buf_size);
    }
    
    char* buffer= mmap(NULL, buf_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    if (buffer == MAP_FAILED)
    {
        printf("Buffer mapping failed\n");
        return -1;
    }
    
    printf("GOT THE BUFFER!\n");
    
    for (uint32_t idx = 0; idx < 20; ++idx)
    {
        buffer[idx] = idx;
    }
    
#if 1
    memset(buffer, 0x5A, buf_size);
    printf("WROTE THE BUFFER!\n");
#endif
    
    munmap(buffer, buf_size);
    close(fd);
    
    printf("[FIN]\n");
    
    return 0;
}
