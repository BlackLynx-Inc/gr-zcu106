/* -*- c++ -*- */
/*
 * Copyright 2021 BlackLynx Inc..
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#ifndef INCLUDED_ZYNQ_BUFFER_H
#define INCLUDED_ZYNQ_BUFFER_H

#include <gnuradio/buffer_single_mapped.h>
#include <gnuradio/buffer_type.h>
#include <cstddef>

#include <dma-proxy-lib.h>

namespace gr {
namespace zynq {


class zynq_buffer : public buffer_single_mapped
{
public:
    static void* device_memcpy(void* dest, const void* src, std::size_t count);
    static void* device_memmove(void* dest, const void* src, std::size_t count);

    static buffer_type type;

    virtual ~zynq_buffer();

    /*!
     * \brief Handles post-general_work() cleanup and data transfer
     *
     * Called directly after call to general_work() completes and
     * is used for data transfer (and perhaps other administrative
     * activities)
     *
     * \param nitems is the number of items produced by the general_work() function.
     */
    void post_work(int nitems);

    /*!
     * \brief Do actual buffer allocation. Inherited from buffer_single_mapped.
     */
    bool do_allocate_buffer(size_t final_nitems, size_t sizeof_item);

    /*!
     * \brief Return a pointer to the write buffer depending on the context
     */
    virtual void* write_pointer();

    /*!
     * \brief return pointer to read buffer depending on the context
     *
     * The return value points to at least items_available() items.
     */
    virtual const void* _read_pointer(unsigned int read_index);

    /*!
     * \brief Callback function that the scheduler will call when it determines
     * that the input is blocked. Override this function if needed.
     */
    virtual bool
    input_blocked_callback(int items_required, int items_avail, unsigned read_index);

    /*!
     * \brief Callback function that the scheduler will call when it determines
     * that the output is blocked
     */
    virtual bool output_blocked_callback(int output_multiple, bool force);

    /*!
     * \brief Creates a new zynq_buffer object
     *
     * \param nitems
     * \param sizeof_item
     * \param downstream_lcm_nitems
     * \param link
     * \param buf_owner
     *
     * \return pointer to buffer base class
     */
    static buffer_sptr make_zynq_buffer(int nitems,
                                        std::size_t sizeof_item,
                                        uint64_t downstream_lcm_nitems,
                                        block_sptr link,
                                        block_sptr buf_owner);

private:
    char* d_buffer;

    /*!
     * \brief constructor is private.  Use the static make_zynq_buffer function
     * to create instances.
     *
     * Allocate a buffer that holds at least \p nitems of size \p sizeof_item.
     *
     * \param nitems is the minimum number of items the buffer will hold.
     * \param sizeof_item is the size of an item in bytes.
     * \param downstream_lcm_nitems is the least common multiple of the items to
     *                              read by downstream blocks
     * \param link is the block that writes to this buffer.
     * \param buf_owner if the block that owns the buffer which may or may not
     *                  be the same as the block that writes to this buffer
     *
     * The total size of the buffer will be rounded up to a system
     * dependent boundary.  This is typically the system page size, but
     * under MS windows is 64KB.
     */
    zynq_buffer(int nitems,
                size_t sizeof_item,
                uint64_t downstream_lcm_nitems,
                block_sptr link,
                block_sptr buf_owner);
};

MAKE_CUSTOM_BUFFER_TYPE(ZYNQ, &zynq_buffer::make_zynq_buffer)
    
} // namespace zynq
} // namespace gr


#endif /* INCLUDED_ZYNQ_BUFFER_H */
