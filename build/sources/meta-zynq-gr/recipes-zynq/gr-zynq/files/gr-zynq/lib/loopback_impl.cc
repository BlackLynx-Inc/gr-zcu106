/* -*- c++ -*- */
/*
 * Copyright 2021 BlackLynx Inc..
 *
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <cstdint>
#include <cstring>
#include <fstream>
#include <iostream>
#include <sstream>
#include <stdexcept>

#include <gnuradio/io_signature.h>
#include "loopback_impl.h"

#include <dma-proxy-lib.h>

namespace gr {
namespace zynq {

    loopback::sptr
    loopback::make()
    {
        return gnuradio::get_initial_sptr(new loopback_impl());
    }


    /*
     * The private constructor
     */
    loopback_impl::loopback_impl()
      : gr::block("loopback",
                  gr::io_signature::make(1, 1, sizeof(int)),
                  gr::io_signature::make(1, 1, sizeof(int))),
        d_dma_write_buffer(nullptr),
        d_dma_read_buffer(nullptr),
        d_max_noutput_items(1048576)
    {
        // Chicken and egg problem... set buffer size up front
        set_max_noutput_items(d_max_noutput_items);
        uint32_t bufsize = max_noutput_items() * sizeof(int);
        
        // Allocate DMA buffers
        d_dma_write_buffer = dmap_alloc_buffer(bufsize);
        if (d_dma_write_buffer == NULL)
        {
            throw std::runtime_error("Unable to allocate DMA buffer");
        }
        
        d_dma_read_buffer = dmap_alloc_buffer(bufsize);
        if (d_dma_read_buffer == NULL)
        {
            throw std::runtime_error("Unable to allocate DMA buffer");
        }
    }

    /*
     * Our virtual destructor.
     */
    loopback_impl::~loopback_impl()
    {
    }
    
    bool loopback_impl::start()
    {
        return true;
    }
    
    bool loopback_impl::stop()
    {
        // Free the DMA buffers
        dmap_free_buffer(d_dma_write_buffer);
        dmap_free_buffer(d_dma_read_buffer);
        
        d_dma_write_buffer = nullptr;
        d_dma_read_buffer = nullptr;
        
        return true;
    }

    void loopback_impl::forecast(int noutput_items, 
                                 gr_vector_int &ninput_items_required)
    {
        /* <+forecast+> e.g. ninput_items_required[0] = noutput_items */
        ninput_items_required[0] = noutput_items;
    }

    int loopback_impl::general_work(int noutput_items,
                                    gr_vector_int& ninput_items,
                                    gr_vector_const_void_star& input_items,
                                    gr_vector_void_star& output_items)
    {
        const int* in = (const int*) input_items[0];
        int* out = (int*) output_items[0];
        uint32_t xfer_len = noutput_items * sizeof(int);

        // Copy data into input (write) DMA buffer
        std::memcpy(d_dma_write_buffer, in, xfer_len);
        
        // Kick off the read operation
        int rc = dmap_read_nb(d_dma_read_buffer, xfer_len);
        if (rc)
        {
            std::ostringstream msg;
            msg << "DMA read failed: " << rc;
            throw std::runtime_error(msg.str());
        }

        // Write/transmit the data
        rc = dmap_write(d_dma_write_buffer, xfer_len);
        if (rc)
        {
            std::ostringstream msg;
            msg << "DMA write failed: " << rc;
            throw std::runtime_error(msg.str());
        }
        
        // Wait for the read operation to complete
        rc = dmap_read_complete(d_dma_read_buffer);
        if (rc)
        {
            std::ostringstream msg;
            msg << "Complete DMA read failed: " << rc;
            throw std::runtime_error(msg.str());
        }

        // Copy data out of output (read) DMA buffer
        std::memcpy(out, d_dma_read_buffer, xfer_len);

        // Tell runtime system how many input items we consumed on
        // each input stream.
        consume_each(noutput_items);

        // Tell runtime system how many output items we produced.
        return noutput_items;
    }

} /* namespace zynq */
} /* namespace gr */
