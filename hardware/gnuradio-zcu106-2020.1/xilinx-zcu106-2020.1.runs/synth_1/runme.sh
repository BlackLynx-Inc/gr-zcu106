#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/ryftone/opt/Xilinx/Vitis/2020.1/bin:/ryftone/opt/Xilinx/Vivado/2020.1/ids_lite/ISE/bin/lin64:/ryftone/opt/Xilinx/Vivado/2020.1/bin
else
  PATH=/ryftone/opt/Xilinx/Vitis/2020.1/bin:/ryftone/opt/Xilinx/Vivado/2020.1/ids_lite/ISE/bin/lin64:/ryftone/opt/Xilinx/Vivado/2020.1/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/ryftone/chintan/darpa/vivado/hardware/gnuradio-zcu106-2020.1/xilinx-zcu106-2020.1.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log project_1_wrapper.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source project_1_wrapper.tcl
