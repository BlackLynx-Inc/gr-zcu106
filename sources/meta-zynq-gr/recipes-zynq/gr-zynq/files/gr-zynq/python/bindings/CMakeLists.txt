# Copyright 2020 Free Software Foundation, Inc.
#
# This file is part of GNU Radio
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

########################################################################
# Check if there is C++ code at all
########################################################################
if(NOT zynq_sources)
    MESSAGE(STATUS "No C++ sources... skipping python bindings")
    return()
endif(NOT zynq_sources)

########################################################################
# Check for pygccxml
########################################################################
GR_PYTHON_CHECK_MODULE_RAW(
    "pygccxml"
    "import pygccxml"
    PYGCCXML_FOUND
    )

include(GrPybind)

########################################################################
# Python Bindings
########################################################################

list(APPEND zynq_python_files
    zynq_loopback_python.cc
    zynq_loopback_legacy_python.cc
    python_bindings.cc)

GR_PYBIND_MAKE_OOT(zynq 
   ../..
   gr::zynq
   "${zynq_python_files}")

install(TARGETS zynq_python DESTINATION ${GR_PYTHON_DIR}/zynq COMPONENT pythonapi)
