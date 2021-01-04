//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
//Date        : Thu May 28 06:07:27 2020
//Host        : xcosswbld09 running 64-bit Red Hat Enterprise Linux Workstation release 7.4 (Maipo)
//Command     : generate_target project_1_wrapper.bd
//Design      : project_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module project_1_wrapper
   (
    mig_sys_clk_n,
    mig_sys_clk_p,
    si570_user_clk_n,
    si570_user_clk_p);
  
  input [0:0]mig_sys_clk_n;
  input [0:0]mig_sys_clk_p;
  input si570_user_clk_n;
  input si570_user_clk_p;

 
  wire [0:0]mig_sys_clk_n;
  wire [0:0]mig_sys_clk_p;
  wire si570_user_clk_n;
  wire si570_user_clk_p;

  project_1 project_1_i
       (
        .mig_sys_clk_n(mig_sys_clk_n),
        .mig_sys_clk_p(mig_sys_clk_p),
        .si570_user_clk_n(si570_user_clk_n),
        .si570_user_clk_p(si570_user_clk_p));
endmodule
