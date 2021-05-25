-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.1.1 (lin64) Build 2960000 Wed Aug  5 22:57:21 MDT 2020
-- Date        : Mon May 24 22:44:21 2021
-- Host        : buildserver8 running 64-bit Ubuntu 16.04.7 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /ryftone/chintan/darpa/github/dev/gr-zcu106/hardware/gnuradio-zcu106-2020.1/xilinx-zcu106-2020.1.srcs/sources_1/bd/project_1/ip/project_1_system_ila_0_0/project_1_system_ila_0_0_stub.vhdl
-- Design      : project_1_system_ila_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu7ev-ffvc1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_1_system_ila_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    SLOT_0_AXIS_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_0_AXIS_tkeep : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_0_AXIS_tlast : in STD_LOGIC;
    SLOT_0_AXIS_tvalid : in STD_LOGIC;
    SLOT_0_AXIS_tready : in STD_LOGIC;
    SLOT_1_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_1_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_1_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_1_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_1_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_1_AXI_awvalid : in STD_LOGIC;
    SLOT_1_AXI_awready : in STD_LOGIC;
    SLOT_1_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_1_AXI_wlast : in STD_LOGIC;
    SLOT_1_AXI_wvalid : in STD_LOGIC;
    SLOT_1_AXI_wready : in STD_LOGIC;
    SLOT_1_AXI_bvalid : in STD_LOGIC;
    SLOT_1_AXI_bready : in STD_LOGIC;
    SLOT_1_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_1_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_1_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_1_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_1_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_1_AXI_arvalid : in STD_LOGIC;
    SLOT_1_AXI_arready : in STD_LOGIC;
    SLOT_1_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_1_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SLOT_1_AXI_rlast : in STD_LOGIC;
    SLOT_1_AXI_rvalid : in STD_LOGIC;
    SLOT_1_AXI_rready : in STD_LOGIC;
    SLOT_2_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_2_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_2_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_2_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_2_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_2_AXI_awvalid : in STD_LOGIC;
    SLOT_2_AXI_awready : in STD_LOGIC;
    SLOT_2_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_2_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_2_AXI_wlast : in STD_LOGIC;
    SLOT_2_AXI_wvalid : in STD_LOGIC;
    SLOT_2_AXI_wready : in STD_LOGIC;
    SLOT_2_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SLOT_2_AXI_bvalid : in STD_LOGIC;
    SLOT_2_AXI_bready : in STD_LOGIC;
    SLOT_2_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_2_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_2_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_2_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_2_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_2_AXI_arvalid : in STD_LOGIC;
    SLOT_2_AXI_arready : in STD_LOGIC;
    SLOT_2_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_2_AXI_rlast : in STD_LOGIC;
    SLOT_2_AXI_rvalid : in STD_LOGIC;
    SLOT_2_AXI_rready : in STD_LOGIC;
    SLOT_3_AXI_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_3_AXI_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_3_AXI_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_3_AXI_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_3_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_3_AXI_awvalid : in STD_LOGIC;
    SLOT_3_AXI_awready : in STD_LOGIC;
    SLOT_3_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_3_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_3_AXI_wlast : in STD_LOGIC;
    SLOT_3_AXI_wvalid : in STD_LOGIC;
    SLOT_3_AXI_wready : in STD_LOGIC;
    SLOT_3_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SLOT_3_AXI_bvalid : in STD_LOGIC;
    SLOT_3_AXI_bready : in STD_LOGIC;
    SLOT_3_AXI_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_3_AXI_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    SLOT_3_AXI_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_3_AXI_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    SLOT_3_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    SLOT_3_AXI_arvalid : in STD_LOGIC;
    SLOT_3_AXI_arready : in STD_LOGIC;
    SLOT_3_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    SLOT_3_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    SLOT_3_AXI_rlast : in STD_LOGIC;
    SLOT_3_AXI_rvalid : in STD_LOGIC;
    SLOT_3_AXI_rready : in STD_LOGIC;
    resetn : in STD_LOGIC
  );

end project_1_system_ila_0_0;

architecture stub of project_1_system_ila_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,SLOT_0_AXIS_tdata[31:0],SLOT_0_AXIS_tkeep[3:0],SLOT_0_AXIS_tlast,SLOT_0_AXIS_tvalid,SLOT_0_AXIS_tready,SLOT_1_AXI_awaddr[31:0],SLOT_1_AXI_awlen[7:0],SLOT_1_AXI_awsize[2:0],SLOT_1_AXI_awcache[3:0],SLOT_1_AXI_awprot[2:0],SLOT_1_AXI_awvalid,SLOT_1_AXI_awready,SLOT_1_AXI_wdata[31:0],SLOT_1_AXI_wlast,SLOT_1_AXI_wvalid,SLOT_1_AXI_wready,SLOT_1_AXI_bvalid,SLOT_1_AXI_bready,SLOT_1_AXI_araddr[31:0],SLOT_1_AXI_arlen[7:0],SLOT_1_AXI_arsize[2:0],SLOT_1_AXI_arcache[3:0],SLOT_1_AXI_arprot[2:0],SLOT_1_AXI_arvalid,SLOT_1_AXI_arready,SLOT_1_AXI_rdata[31:0],SLOT_1_AXI_rresp[1:0],SLOT_1_AXI_rlast,SLOT_1_AXI_rvalid,SLOT_1_AXI_rready,SLOT_2_AXI_awaddr[31:0],SLOT_2_AXI_awlen[7:0],SLOT_2_AXI_awsize[2:0],SLOT_2_AXI_awcache[3:0],SLOT_2_AXI_awprot[2:0],SLOT_2_AXI_awvalid,SLOT_2_AXI_awready,SLOT_2_AXI_wdata[31:0],SLOT_2_AXI_wstrb[3:0],SLOT_2_AXI_wlast,SLOT_2_AXI_wvalid,SLOT_2_AXI_wready,SLOT_2_AXI_bresp[1:0],SLOT_2_AXI_bvalid,SLOT_2_AXI_bready,SLOT_2_AXI_araddr[31:0],SLOT_2_AXI_arlen[7:0],SLOT_2_AXI_arsize[2:0],SLOT_2_AXI_arcache[3:0],SLOT_2_AXI_arprot[2:0],SLOT_2_AXI_arvalid,SLOT_2_AXI_arready,SLOT_2_AXI_rdata[31:0],SLOT_2_AXI_rlast,SLOT_2_AXI_rvalid,SLOT_2_AXI_rready,SLOT_3_AXI_awaddr[31:0],SLOT_3_AXI_awlen[7:0],SLOT_3_AXI_awsize[2:0],SLOT_3_AXI_awcache[3:0],SLOT_3_AXI_awprot[2:0],SLOT_3_AXI_awvalid,SLOT_3_AXI_awready,SLOT_3_AXI_wdata[31:0],SLOT_3_AXI_wstrb[3:0],SLOT_3_AXI_wlast,SLOT_3_AXI_wvalid,SLOT_3_AXI_wready,SLOT_3_AXI_bresp[1:0],SLOT_3_AXI_bvalid,SLOT_3_AXI_bready,SLOT_3_AXI_araddr[31:0],SLOT_3_AXI_arlen[7:0],SLOT_3_AXI_arsize[2:0],SLOT_3_AXI_arcache[3:0],SLOT_3_AXI_arprot[2:0],SLOT_3_AXI_arvalid,SLOT_3_AXI_arready,SLOT_3_AXI_rdata[31:0],SLOT_3_AXI_rresp[1:0],SLOT_3_AXI_rlast,SLOT_3_AXI_rvalid,SLOT_3_AXI_rready,resetn";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "bd_cc6b,Vivado 2020.1.1";
begin
end;
