#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <unistd.h>

#include "dma-proxy-lib.h"

#define PAGE_SIZE   sysconf(_SC_PAGESIZE)

typedef struct proxy_buffer_info {
    int fd;
    size_t size;
    void* buffer;   
} proxy_buffer_info_t;

pthread_mutex_t master_mutex;   // used to make buffer list thread safe
static uint32_t buffer_list_inc = 10;   // increment size by this amount
static proxy_buffer_info_t* buffer_list = NULL;
static uint32_t buffer_list_size = 0;
static uint32_t buffer_list_idx = 0;


static int __dma_proxy_reg_space_fd;
static void *__dma_proxy_reg_space_ptr;


// Make init and fini functions as constructor and destructor
void dma_proxy_lib_init() __attribute__((constructor));
void dma_proxy_lib_fini() __attribute__((destructor));

// Buffer list function
static inline int _resize_buffer_list();
static inline void* _alloc_proxy_buffer(proxy_buffer_info_t* proxy_buffer, size_t size);
static inline int _free_proxy_buffer(proxy_buffer_info_t* proxy_buffer);

/**
 * DMA proxy userspace library "constructor"
 */
void dma_proxy_lib_init()
{
    // Initialize the register space FD and pointer
    __dma_proxy_reg_space_fd = 0;
    __dma_proxy_reg_space_ptr = NULL;
    
    // Allocate initial buffer list
    pthread_mutex_lock(&master_mutex);
    _resize_buffer_list();
    pthread_mutex_unlock(&master_mutex);
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
    
    // Clean up any remaining buffers
    pthread_mutex_lock(&master_mutex);
    for (uint32_t idx = 0; idx < buffer_list_size; ++idx)
    {
        if (buffer_list[idx].fd > 0)
        {
            _free_proxy_buffer(&buffer_list[idx]);
        } 
    }
    free(buffer_list);
    pthread_mutex_unlock(&master_mutex);
}

/**
 * Helper function to round the specified size up to the nearest page size
 */ 
static inline size_t _roundup_nearest_pagesize(size_t size)
{
    // NOTE: integer math used here
    return ((size + PAGE_SIZE - 1) / PAGE_SIZE) * PAGE_SIZE;
}

static inline int _resize_buffer_list()
{
    if (buffer_list_size == 0)
    {
        // Buffer list was empty, so create it
        buffer_list = calloc(buffer_list_inc, sizeof(proxy_buffer_info_t));
        if (buffer_list == NULL)
        {
            return -1;
        }
        buffer_list_size = buffer_list_inc;
    }
    else
    {
        // Buffer list not empty, resize it
        size_t new_size = sizeof(proxy_buffer_info_t) * 
                          (buffer_list_size + buffer_list_inc);
        buffer_list = realloc(buffer_list, new_size);
        if (buffer_list == NULL)
        {
            return -1;
        }
        buffer_list_size += buffer_list_inc;
    }
    
    return 0;
}

static inline void* _alloc_proxy_buffer(proxy_buffer_info_t* proxy_buffer, size_t size)
{
    if (proxy_buffer == NULL)
    {
        return NULL;
    }
    
    // Open the proxy device
    int fd = open(DMA_PROXY_DEVICE, O_RDWR);
    if (fd < 1) 
    {
        return NULL;
    }
    
    // Round up the user specified size to the nearest page multiple size
    size_t buffer_size = _roundup_nearest_pagesize(size);
    
    // Map the buffer
    proxy_buffer->buffer = mmap(NULL, buffer_size, PROT_READ | PROT_WRITE, 
                                MAP_SHARED, fd, 0);
    if (proxy_buffer->buffer == MAP_FAILED)
    {
        return NULL;
    }
    
    proxy_buffer->size = buffer_size;
    proxy_buffer->fd = fd;
    
    return proxy_buffer->buffer;
}

static inline int _free_proxy_buffer(proxy_buffer_info_t* proxy_buffer)
{
    if (proxy_buffer == NULL)
    {
        return -1;
    }
    
    if (proxy_buffer->fd <= 2)
    {
        return -2;
    }
    
    munmap(proxy_buffer->buffer, proxy_buffer->size);
    close(proxy_buffer->fd);
    
    // Mark that this buffer is no longer active
    proxy_buffer->fd = 0;
    
    return 0;
}

static int _map_reg_space()
{
    // Open the /dev/mem device and mmap the register space
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

uint32_t dmap_reg_read32(uint32_t offset)
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

int dmap_reg_write32(uint32_t offset, uint32_t value)
{
    // Make sure the offset doesn't exceed the size of the mapped space
    if (offset > REG_SPACE_SIZE)
    {
        return DMAP_INVALID_REG_OFFSET;
    }
    
    // Map the register space if it is not already mapped
    if (__dma_proxy_reg_space_ptr == NULL)
    {
        _map_reg_space();
    }
    
    *(uint32_t*)(__dma_proxy_reg_space_ptr + offset) = value;
    
    return 0;
}

void* dmap_alloc_buffer(size_t size)
{
    void* ret = NULL;
    
    // Make sure buffer size does not exceed amount of device memory
    if (size > MAX_DEVICE_MEMORY)
    {
        return ret;
    }
    
    pthread_mutex_lock(&master_mutex);
    
    // Perform linear scan looking for first empty slot in the buffer list
    uint32_t idx = 0;
    for (; idx < buffer_list_size; ++idx)
    {
        if (buffer_list[idx].fd == 0)
        {
            break;
        } 
    }
    if (idx == buffer_list_size)
    {
        // Attempt to resize the buffer list
        if (_resize_buffer_list())
        {
            pthread_mutex_unlock(&master_mutex);
            return ret;
        }
    }
    
    ret = _alloc_proxy_buffer(&buffer_list[idx], size);
    pthread_mutex_unlock(&master_mutex);
    return ret;
}

void dmap_free_buffer(void* buffer)
{
    if (buffer == NULL)
    {
        return;
    }
    
    pthread_mutex_lock(&master_mutex);
    
    // Find the proxy_buffer_info_t that is active who's value matches the 
    // passed buffer pointer, if found free the entry
    for (uint32_t idx = 0; idx < buffer_list_size; ++idx)
    {
        if (buffer_list[idx].buffer == buffer && buffer_list[idx].fd > 0)
        {
            _free_proxy_buffer(&buffer_list[idx]);
            break;
        }
    }
    
    pthread_mutex_unlock(&master_mutex);
    
    return;
}

int dmap_read(void* buffer, uint32_t device_address, uint32_t length)
{
    if (buffer == NULL)
    {
        return DMAP_INVALID_BUF_PTR;
    }
    
    int rc = 0;
    struct proxy_buffer_info selected;
    
    pthread_mutex_lock(&master_mutex);
    
    // Find the proxy_buffer_info_t that is active who's value matches the 
    // passed buffer pointer
    uint32_t idx = 0;
    for (; idx < buffer_list_size; ++idx)
    {
        if (buffer && buffer_list[idx].fd > 0 && buffer_list[idx].buffer == buffer)
        {
            // Copy the selected element as a realloc might happen at any time
            // the mutex is not locked
            memcpy(&selected, &buffer_list[idx], sizeof(struct proxy_buffer_info));
            break;
        }
    }
    
    // The buffer was not found
    if (idx == buffer_list_size)
    {
        rc = DMAP_INVALID_BUF_PTR;
    }
    
    pthread_mutex_unlock(&master_mutex);
    
    // TODO: validate that device_address and length fall in bounds
    // TODO: handle offset within DMA buffer (store in struct?)
    if (rc == 0)
    {
        struct dma_proxy_rw_info rw_info;
        rw_info.address = device_address;
        rw_info.length = length;
    
        rc = ioctl(selected.fd, DMA_PROXY_IOC_READ, (unsigned long)&rw_info);
    }
    
    return rc;
}

int dmap_write(void* buffer, uint32_t device_address, uint32_t length)
{
    if (buffer == NULL)
    {
        return DMAP_INVALID_BUF_PTR;
    }
    
    int rc = 0;
    struct proxy_buffer_info selected;
    
    pthread_mutex_lock(&master_mutex);
    
    // Find the proxy_buffer_info_t that is active who's value matches the 
    // passed buffer pointer
    uint32_t idx = 0;
    for (; idx < buffer_list_size; ++idx)
    {
        if (buffer && buffer_list[idx].fd > 0 && buffer_list[idx].buffer == buffer)
        {
            // Copy the selected element as a realloc might happen at any time
            // the mutex is not locked
            memcpy(&selected, &buffer_list[idx], sizeof(struct proxy_buffer_info));
            break;
        }
    }
    
    // The buffer was not found
    if (idx == buffer_list_size)
    {
        rc = DMAP_INVALID_BUF_PTR;
    }
    
    pthread_mutex_unlock(&master_mutex);
    
    // TODO: validate that device_address and length fall in bounds
    // TODO: handle offset within DMA buffer (store in struct?)
    if (rc == 0)
    {
        struct dma_proxy_rw_info rw_info;
        rw_info.address = device_address;
        rw_info.length = length;
        
        rc = ioctl(buffer_list[idx].fd, DMA_PROXY_IOC_WRITE, (unsigned long)&rw_info);
    }
    
    return rc;
}