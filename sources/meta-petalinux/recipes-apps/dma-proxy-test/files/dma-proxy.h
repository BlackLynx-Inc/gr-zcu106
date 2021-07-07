/*  dma-proxy.h - The simplest kernel module.
*
* Copyright (C) 2013 - 2016 Xilinx, Inc
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU General Public License as published by
*   the Free Software Foundation; either version 2 of the License, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details.
*
*   You should have received a copy of the GNU General Public License along
*   with this program. If not, see <http://www.gnu.org/licenses/>.
*   
*   This header file is shared between the DMA Proxy test application and the DMA Proxy device driver. It defines the
*   shared interface to allow DMA transfers to be done from user space.
*
*   Note: the buffer in the data structure should be 1st in the channel interface so that the buffer is cached aligned,
*   otherwise there may be issues when using cached memory. The issues were typically the 1st 32 bytes of the buffer
*   not working in the driver test.
*/

#define TEST_SIZE (3 * 1024 * 1024)

struct dma_proxy_channel_interface {
	unsigned char buffer[TEST_SIZE];
	enum proxy_status { PROXY_NO_ERROR = 0, PROXY_BUSY = 1, PROXY_TIMEOUT = 2, PROXY_ERROR = 3 } status;
	unsigned int length;
};
