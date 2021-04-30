/* -*- c++ -*- */

#define ZYNQ_API

%include "gnuradio.i"           // the common stuff

//load generated python docstrings
%include "zynq_swig_doc.i"

%{
#include "zynq/loopback.h"
%}

%include "zynq/loopback.h"
GR_SWIG_BLOCK_MAGIC2(zynq, loopback);
