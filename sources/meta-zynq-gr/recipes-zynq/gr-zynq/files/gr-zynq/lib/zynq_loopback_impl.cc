/* -*- c++ -*- */
/*
 * Copyright 2021 BlackLynx, Inc..
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#include "zynq_loopback_impl.h"
#include <gnuradio/io_signature.h>


namespace gr {
namespace zynq {

using input_type = uint64_t;
using output_type = uint64_t;


zynq_loopback::sptr zynq_loopback::make(int batch_size, int load)
{
    return gnuradio::make_block_sptr<zynq_loopback_impl>(batch_size, load);
}


/*
 * The private constructor
 */
zynq_loopback_impl::zynq_loopback_impl(int batch_size, int load)
    : gr::block("cuda_loopback",
                gr::io_signature::make(1 /* min inputs */, 1 /* max inputs */, 
                                       sizeof(input_type), zynq_buffer::type),
                gr::io_signature::make(1 /* min outputs */, 1 /*max outputs */, 
                                       sizeof(output_type), zynq_buffer::type)),
      d_device_index(0),
      d_batch_size(batch_size),
      d_load(load)
{
    set_output_multiple(d_batch_size);
}

/*
 * Our virtual destructor.
 */
zynq_loopback_impl::~zynq_loopback_impl() {}

void zynq_loopback_impl::forecast(int noutput_items, gr_vector_int& ninput_items_required)
{
    ninput_items_required[0] = noutput_items;
}

int zynq_loopback_impl::general_work(int noutput_items,
                                     gr_vector_int& ninput_items,
                                     gr_vector_const_void_star& input_items,
                                     gr_vector_void_star& output_items)
{
    std::cout << "BUCKY BALLS" << std::endl;
    
    auto in = reinterpret_cast<const input_type*>(input_items[0]);
    auto out = reinterpret_cast<output_type*>(output_items[0]);
    
    auto num_iters = noutput_items / d_batch_size;
    for (uint32_t iter_idx = 0; iter_idx < num_iters; ++iter_idx)
    {
        // Kick off the read operation
        int rc = dmap_read_nb(d_device_index, 
                              (void*)(in + (iter_idx * d_batch_size)), 
                              d_batch_size);
        if (rc)
        {
            std::cerr << "DMA read failed: " << rc << std::endl;
        }
        
        // Write/transmit the data
        rc = dmap_write(d_device_index, 
                        (void*)(out + (iter_idx * d_batch_size)), 
                        d_batch_size);
        if (rc)
        {
            std::cerr << "DMA write failed: " << rc << std::endl;
        }
        
        // Wait for the read operation to complete
        rc = dmap_read_complete(d_device_index, (void*)in);
        if (rc)
        {
            std::cerr << "DMA read complete failed: " << rc << std::endl;
        }
    }
    
    // Tell runtime system how many input items we consumed on
    // each input stream.
    consume_each(num_iters * d_batch_size);

    // Tell runtime system how many output items we produced.
    return (num_iters * d_batch_size);
}

} /* namespace zynq */
} /* namespace gr */
