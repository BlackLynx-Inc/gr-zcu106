
set ::PS_INST PS_0 
set PS_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e PS_0 ] 


apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells PS_0] 


set_property -dict [ list \
            CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__CAN1__PERIPHERAL__IO {MIO 24 .. 25} \
CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA  {0} \
CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED  {1} \
CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {16} \
CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {4} \
CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {1} \
CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {71} \
CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA  {0.2871} \
CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED  {1} \
CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {29} \
CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__AMS_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR0 {4} \
CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__CSU_PLL_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {0} \
CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {45} \
CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__NAND_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {4} \
CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {5} \
CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__PL2_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__PL3_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {70} \
CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA  {0.779} \
CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {3} \
CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {8} \
CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {8} \
CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {8} \
CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR1 {0} \
CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {5} \
CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {15} \
CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
CONFIG.PSU__DDRC__AL {0} \
CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \
CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
CONFIG.PSU__DDRC__CL {15} \
CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
CONFIG.PSU__DDRC__CWL {14} \
CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \
CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \
CONFIG.PSU__DDRC__ECC {Disabled} \
CONFIG.PSU__DDRC__ENABLE {1} \
CONFIG.PSU__DDRC__FGRM {1X} \
CONFIG.PSU__DDRC__FREQ_MHZ {1066.50} \
CONFIG.PSU__DDRC__LP_ASR {manual normal} \
CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \
CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
CONFIG.PSU__DDRC__T_FAW {21.0} \
CONFIG.PSU__DDRC__T_RAS_MIN {33} \
CONFIG.PSU__DDRC__T_RC {46.5} \
CONFIG.PSU__DDRC__T_RCD {15} \
CONFIG.PSU__DDRC__T_RP {15} \
CONFIG.PSU__DDRC__VREF {1} \
CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
CONFIG.PSU__DP__REF_CLK_FREQ {27} \
CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \
CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
CONFIG.PSU__FPGA_PL0_ENABLE {1} \
CONFIG.PSU__FPGA_PL1_ENABLE {1} \
CONFIG.PSU__FPGA_PL2_ENABLE {1} \
CONFIG.PSU__FPGA_PL3_ENABLE {1} \
CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__GPIO_EMIO__PERIPHERAL__IO {92} \
CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
CONFIG.PSU__NUM_FABRIC_RESETS {4} \
CONFIG.PSU__OVERRIDE__BASIC_CLOCK {1} \
CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
CONFIG.PSU__PMU__GPI0__ENABLE {0} \
CONFIG.PSU__PMU__GPI1__ENABLE {0} \
CONFIG.PSU__PMU__GPI2__ENABLE {0} \
CONFIG.PSU__PMU__GPI3__ENABLE {0} \
CONFIG.PSU__PMU__GPI4__ENABLE {0} \
CONFIG.PSU__PMU__GPI5__ENABLE {0} \
CONFIG.PSU__PMU__GPO0__ENABLE {1} \
CONFIG.PSU__PMU__GPO1__ENABLE {1} \
CONFIG.PSU__PMU__GPO2__ENABLE {1} \
CONFIG.PSU__PMU__GPO3__ENABLE {1} \
CONFIG.PSU__PMU__GPO4__ENABLE {1} \
CONFIG.PSU__PMU__GPO5__ENABLE {1} \
CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
CONFIG.PSU__SATA__LANE1__ENABLE {1} \
CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \
CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \
CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC0__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC1__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC2__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__TTC3__PERIPHERAL__IO {EMIO} \
CONFIG.PSU__UART0__BAUD_RATE {115200} \
CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
CONFIG.PSU__UART1__BAUD_RATE {115200} \
CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \
CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
CONFIG.PSU__USE__IRQ0 {1} \
CONFIG.PSU__USE__M_AXI_GP0  {1} \
CONFIG.PSU__USE__M_AXI_GP1  {1} \
CONFIG.PSU__USE__M_AXI_GP2  {0} \
CONFIG.PSU__USE__S_AXI_ACE  {0} \
CONFIG.PSU__USE__S_AXI_ACP  {0} \
CONFIG.PSU__USE__S_AXI_GP0  {1} \
CONFIG.PSU__USE__S_AXI_GP1  {0} \
CONFIG.PSU__USE__S_AXI_GP2  {0} \
CONFIG.PSU__USE__S_AXI_GP3  {1} \
CONFIG.PSU__USE__S_AXI_GP4  {1} \
CONFIG.PSU__USE__S_AXI_GP5  {1} \
CONFIG.PSU__USE__S_AXI_GP6  {0} \
] $PS_0 

# import_files -fileset constrs_1 {../xdc/vcu_uc2_pll.xdc }

# set_property ip_repo_paths ../ip [current_project]
# update_ip_catalog

# Hierarchical cell: mpsoc_ss
proc create_hier_cell_mpsoc_ss { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_mpsoc_ss() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [group_bd_cells $nameHier [get_bd_cells ${::PS_INST}]]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI_0
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP1_FPD_0
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP2_FPD
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HP3_FPD
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HPC0_FPD_0

  # Create pins
  create_bd_pin -dir O -from 0 -to 0 Dout
  create_bd_pin -dir O -from 0 -to 0 Dout2
  create_bd_pin -dir O -from 0 -to 0 Dout3
  create_bd_pin -dir I -type rst M00_ARESETN
  create_bd_pin -dir I -type clk M01_ACLK_0
  create_bd_pin -dir O -type clk clk_100M
  create_bd_pin -dir I -type clk maxihpm1_fpd_aclk
  create_bd_pin -dir I -from 2 -to 0 -type intr pl_ps_irq0
  create_bd_pin -dir O -type rst pl_resetn0_0
  create_bd_pin -dir I -type rst reset_333
  create_bd_pin -dir I -type clk s_axi_hpc0_fpd_aclk

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
 ] $axi_interconnect_2

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: proc_sys_reset_0 ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice: xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {0} \
   CONFIG.DIN_TO {0} \
   CONFIG.DIN_WIDTH {95} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice: xlslice_1 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice: xlslice_2 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {2} \
   CONFIG.DIN_TO {2} \
   CONFIG.DIN_WIDTH {95} \
   CONFIG.DOUT_WIDTH {1} \
 ] $xlslice_2

#   # Create instance: ${::PS_INST}, and set properties
#   set_property -dict [ list \
#    CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
#    CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
#    CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
#    CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
#    CONFIG.PSU__GPIO_EMIO__PERIPHERAL__ENABLE {1} \
#    CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
#    CONFIG.PSU__USE__FABRIC__RST {1} \
#    CONFIG.PSU__USE__IRQ0 {1} \
#    CONFIG.PSU__USE__M_AXI_GP0 {1} \
#    CONFIG.PSU__USE__M_AXI_GP1 {1} \
#    CONFIG.PSU__USE__M_AXI_GP2 {0} \
#    CONFIG.PSU__USE__S_AXI_GP0 {1} \
#    CONFIG.PSU__USE__S_AXI_GP2 {0} \
#    CONFIG.PSU__USE__S_AXI_GP3 {1} \
#    CONFIG.PSU__USE__S_AXI_GP4 {1} \
#    CONFIG.PSU__USE__S_AXI_GP5 {1} \
# ] [get_bd_cells ${::PS_INST}]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins S_AXI_HP1_FPD_0] [get_bd_intf_pins ${::PS_INST}/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins S_AXI_HPC0_FPD_0] [get_bd_intf_pins ${::PS_INST}/S_AXI_HPC0_FPD]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXI_HP2_FPD] [get_bd_intf_pins ${::PS_INST}/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net Conn19 [get_bd_intf_pins M00_AXI_0] [get_bd_intf_pins axi_interconnect_2/M00_AXI]
  connect_bd_intf_net -intf_net Conn24 [get_bd_intf_pins S_AXI_HP3_FPD] [get_bd_intf_pins ${::PS_INST}/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins axi_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net ${::PS_INST}_M_AXI_HPM0_FPD [get_bd_intf_pins axi_interconnect/S00_AXI] [get_bd_intf_pins ${::PS_INST}/M_AXI_HPM0_FPD]
  connect_bd_intf_net -intf_net ${::PS_INST}_M_AXI_HPM1_FPD [get_bd_intf_pins axi_interconnect_2/S00_AXI] [get_bd_intf_pins ${::PS_INST}/M_AXI_HPM1_FPD]

  # Create port connections
  connect_bd_net -net ARESETN_1 [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net M00_ACLK_1 [get_bd_pins M01_ACLK_0] [get_bd_pins axi_interconnect_2/M00_ACLK]
  connect_bd_net -net M00_ARESETN_1 [get_bd_pins M00_ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN]
  connect_bd_net -net M17_ARESETN_1 [get_bd_pins reset_333] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN]
  connect_bd_net -net maxihpm1_fpd_aclk_1 [get_bd_pins maxihpm1_fpd_aclk] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/M02_ACLK] [get_bd_pins ${::PS_INST}/maxihpm1_fpd_aclk]
  connect_bd_net -net net_clk_wiz_clk_out1 [get_bd_pins clk_100M] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins ${::PS_INST}/maxihpm0_fpd_aclk] [get_bd_pins ${::PS_INST}/pl_clk0]
  connect_bd_net -net net_rst_processor_1_100M_peripheral_aresetn [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net pl_ps_irq0_1 [get_bd_pins pl_ps_irq0] [get_bd_pins ${::PS_INST}/pl_ps_irq0]
  connect_bd_net -net saxihp2_fpd_aclk_0_1 [get_bd_pins s_axi_hpc0_fpd_aclk] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins ${::PS_INST}/saxihp1_fpd_aclk] [get_bd_pins ${::PS_INST}/saxihp2_fpd_aclk] [get_bd_pins ${::PS_INST}/saxihp3_fpd_aclk] [get_bd_pins ${::PS_INST}/saxihpc0_fpd_aclk]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins Dout] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins Dout2] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_pins Dout3] [get_bd_pins xlslice_2/Dout]
  connect_bd_net -net ${::PS_INST}_emio_gpio_o [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din] [get_bd_pins ${::PS_INST}/emio_gpio_o]
  connect_bd_net -net ${::PS_INST}_pl_resetn0 [get_bd_pins pl_resetn0_0] [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins ${::PS_INST}/pl_resetn0]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set C0_DDR4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 C0_DDR4 ]
  set mig_sys [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 mig_sys ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125000000} \
  ] $mig_sys
  set si570_user [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 si570_user ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
  ] $si570_user

  # Create ports

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
   CONFIG.S02_HAS_REGSLICE {4} \
   CONFIG.S03_HAS_REGSLICE {4} \
   CONFIG.S04_HAS_REGSLICE {4} \
   CONFIG.S05_HAS_REGSLICE {4} \
   CONFIG.S06_HAS_REGSLICE {4} \
   CONFIG.S07_HAS_REGSLICE {4} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {3} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_2

  # Create instance: axi_interconnect_3, and set properties
  set axi_interconnect_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_3 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_3

  # Create instance: axi_interconnect_5, and set properties
  set axi_interconnect_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_5 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_5

  # Create instance: axi_interconnect_6, and set properties
  set axi_interconnect_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_6 ]
  set_property -dict [ list \
   CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_6

  # Create instance: axi_interconnect_7, and set properties
  set axi_interconnect_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect: axi_interconnect_7 ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {1} \
   CONFIG.S00_HAS_REGSLICE {4} \
   CONFIG.S01_HAS_REGSLICE {4} \
 ] $axi_interconnect_7

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz: clk_wiz_1 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {100.000} \
   CONFIG.CLKIN1_UI_JITTER {100.000} \
   CONFIG.CLKIN2_JITTER_PS {100.000} \
   CONFIG.CLKIN2_UI_JITTER {100.000} \
   CONFIG.CLKOUT1_JITTER {139.927} \
   CONFIG.CLKOUT1_PHASE_ERROR {81.700} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {33.33} \
   CONFIG.CLKOUT2_JITTER {90.657} \
   CONFIG.CLKOUT2_PHASE_ERROR {81.700} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {331} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {90.370} \
   CONFIG.CLKOUT3_PHASE_ERROR {77.836} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {100.000} \
   CONFIG.CLKOUT3_USED {false} \
   CONFIG.ENABLE_CLOCK_MONITOR {false} \
   CONFIG.JITTER_OPTIONS {PS} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {13.250} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.333} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {39.750} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {1} \
   CONFIG.MMCM_DIVCLK_DIVIDE {3} \
   CONFIG.MMCM_REF_JITTER1 {0.030} \
   CONFIG.MMCM_REF_JITTER2 {0.010} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIMITIVE {MMCM} \
   CONFIG.PRIM_IN_FREQ {300.000} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.SECONDARY_SOURCE {Single_ended_clock_capable_pin} \
   CONFIG.USE_INCLK_SWITCHOVER {false} \
   CONFIG.USE_PHASE_ALIGNMENT {true} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_1

  # Create instance: interrupts, and set properties
  set interrupts [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat: interrupts ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {3} \
 ] $interrupts

  # Create instance: mpsoc_ss
  create_hier_cell_mpsoc_ss [current_bd_instance .] mpsoc_ss

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: proc_sys_reset_1 ]

  # Create instance: proc_sys_reset_2, and set properties
  set proc_sys_reset_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset: proc_sys_reset_2 ]

  # Create instance: v_frmbuf_rd_0, and set properties
  set v_frmbuf_rd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_rd: v_frmbuf_rd_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {64} \
   CONFIG.HAS_RGB8 {0} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_Y_UV10 {1} \
   CONFIG.HAS_Y_UV10_420 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {10} \
   CONFIG.MAX_NR_PLANES {2} \
 ] $v_frmbuf_rd_0

  # Create instance: v_frmbuf_wr_0, and set properties
  set v_frmbuf_wr_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_frmbuf_wr: v_frmbuf_wr_0 ]
  set_property -dict [ list \
   CONFIG.AXIMM_ADDR_WIDTH {32} \
   CONFIG.HAS_RGB8 {0} \
   CONFIG.HAS_Y8 {1} \
   CONFIG.HAS_Y10 {1} \
   CONFIG.HAS_Y_UV8 {1} \
   CONFIG.HAS_Y_UV10 {1} \
   CONFIG.HAS_Y_UV10_420 {1} \
   CONFIG.HAS_Y_UV8_420 {1} \
   CONFIG.MAX_DATA_WIDTH {10} \
   CONFIG.MAX_NR_PLANES {2} \
 ] $v_frmbuf_wr_0

  # Create instance: vcu_0, and set properties
  set vcu_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vcu: vcu_0 ]
  set_property -dict [ list \
   CONFIG.NO_OF_STREAMS {1} \
   CONFIG.ENC_VIDEO_STANDARD {0} \
   CONFIG.ENC_FRAME_SIZE {4} \
   CONFIG.ENC_FPS {3} \
   CONFIG.ENC_CODING_TYPE {1} \
   CONFIG.ENC_COLOR_FORMAT {1} \
   CONFIG.ENC_COLOR_DEPTH {1} \
   CONFIG.ENC_BUFFER_B_FRAME {1} \
   CONFIG.ENC_BUFFER_EN {true} \
   CONFIG.ENC_BUFFER_MOTION_VEC_RANGE {1} \
   CONFIG.DEC_VIDEO_STANDARD {0} \
   CONFIG.DEC_FRAME_SIZE {4} \
   CONFIG.DEC_FPS {3} \
   CONFIG.DEC_CODING_TYPE {1} \
   CONFIG.DEC_COLOR_FORMAT {1} \
   CONFIG.DEC_COLOR_DEPTH {1} \
   CONFIG.ENC_BUFFER_SIZE {2140} \
   CONFIG.ENC_BUFFER_SIZE_ACTUAL {2408} \
   CONFIG.ENC_MEM_URAM_USED {2408} \
   CONFIG.TABLE_NO {1} \
 ] $vcu_0

  # Create instance: vcu_ddr4_controller_0, and set properties
  set vcu_ddr4_controller_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vcu_ddr4_controller: vcu_ddr4_controller_0 ]
  set_property -dict [ list \
   CONFIG.REF_CLK {125} \
   CONFIG.DRAM_WIDTH {1} \
   CONFIG.DRAM_SPEED_BIN {0} \
   CONFIG.DIMM_TYPE {1} \
   CONFIG.BG_WIDTH {0} \
   CONFIG.CLKOUT0_DIVIDE_MMCM {5} \
   CONFIG.CLKOUT1_DIVIDE_MMCM {5} \
   CONFIG.DIVCLK_DIVIDE_MMCM {1} \
   CONFIG.tCK {833} \
   CONFIG.CASLatency {17} \
   CONFIG.NoDataCmdSlot {1} \
   CONFIG.CWLatency {12} \
   CONFIG.tRPA {14333} \
   CONFIG.nFAW {10} \
   CONFIG.nRTR {14} \
   CONFIG.nWTW {18} \
   CONFIG.CompBits {10010} \
   CONFIG.BankWidth {3} \
   CONFIG.BankGroupWidth {1} \
   CONFIG.ClkfboutMultMmcm {12} \
   CONFIG.ClkinPeriodMmcm {7998} \
   CONFIG.AddrWidth {27} \
   CONFIG.c_AddrWidth {25} \
   CONFIG.MAddrWidth {25} \
   CONFIG.mc_BG {7} \
   CONFIG.c_NbBank {8} \
   CONFIG.c_NbFifo {8} \
   CONFIG.c_nRRD_S {1} \
 ] $vcu_ddr4_controller_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant: xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN1_D_0_2 [get_bd_intf_ports si570_user] [get_bd_intf_pins clk_wiz_1/CLK_IN1_D]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins axi_interconnect_3/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_MCU]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_5/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC1]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins vcu_ddr4_controller_0/S_AXI_PORT4]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins vcu_ddr4_controller_0/S_AXI_PORT1]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_interconnect_1/M01_AXI] [get_bd_intf_pins axi_interconnect_2/S02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net axi_interconnect_3_M00_AXI [get_bd_intf_pins axi_interconnect_3/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HPC0_FPD_0]
  connect_bd_intf_net -intf_net axi_interconnect_3_M01_AXI [get_bd_intf_pins axi_interconnect_3/M01_AXI] [get_bd_intf_pins vcu_ddr4_controller_0/S_AXI_PORT2]
  connect_bd_intf_net -intf_net axi_interconnect_5_M00_AXI [get_bd_intf_pins axi_interconnect_5/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP1_FPD_0]
  connect_bd_intf_net -intf_net axi_interconnect_6_M00_AXI [get_bd_intf_pins axi_interconnect_6/M00_AXI] [get_bd_intf_pins vcu_ddr4_controller_0/S_AXI_PORT0]
  connect_bd_intf_net -intf_net axi_interconnect_6_M01_AXI [get_bd_intf_pins axi_interconnect_2/S01_AXI] [get_bd_intf_pins axi_interconnect_6/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_7_M00_AXI [get_bd_intf_pins axi_interconnect_7/M00_AXI] [get_bd_intf_pins mpsoc_ss/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net c0_sys_0_1 [get_bd_intf_ports mig_sys] [get_bd_intf_pins vcu_ddr4_controller_0/c0_sys]
  connect_bd_intf_net -intf_net mpsoc_ss_M00_AXI [get_bd_intf_pins mpsoc_ss/M00_AXI] [get_bd_intf_pins vcu_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net mpsoc_ss_M00_AXI_0 [get_bd_intf_pins mpsoc_ss/M00_AXI_0] [get_bd_intf_pins vcu_ddr4_controller_0/S_AXI_PORT3]
  connect_bd_intf_net -intf_net mpsoc_ss_M01_AXI [get_bd_intf_pins mpsoc_ss/M01_AXI] [get_bd_intf_pins v_frmbuf_rd_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net mpsoc_ss_M02_AXI [get_bd_intf_pins mpsoc_ss/M02_AXI] [get_bd_intf_pins v_frmbuf_wr_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axi_mm_video [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins v_frmbuf_rd_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net v_frmbuf_rd_0_m_axis_video [get_bd_intf_pins v_frmbuf_rd_0/m_axis_video] [get_bd_intf_pins v_frmbuf_wr_0/s_axis_video]
  connect_bd_intf_net -intf_net v_frmbuf_wr_0_m_axi_mm_video [get_bd_intf_pins axi_interconnect_2/S00_AXI] [get_bd_intf_pins v_frmbuf_wr_0/m_axi_mm_video]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_DEC0 [get_bd_intf_pins axi_interconnect_6/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC0]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_DEC1 [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_DEC1]
  connect_bd_intf_net -intf_net vcu_0_M_AXI_ENC0 [get_bd_intf_pins axi_interconnect_7/S00_AXI] [get_bd_intf_pins vcu_0/M_AXI_ENC0]
  connect_bd_intf_net -intf_net vcu_ddr4_controller_0_C0_DDR4 [get_bd_intf_ports C0_DDR4] [get_bd_intf_pins vcu_ddr4_controller_0/C0_DDR4]

  # Create port connections
  connect_bd_net -net M01_ACLK_0_1 [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_3/M01_ACLK] [get_bd_pins axi_interconnect_6/M00_ACLK] [get_bd_pins mpsoc_ss/M01_ACLK_0] [get_bd_pins proc_sys_reset_2/slowest_sync_clk] [get_bd_pins vcu_ddr4_controller_0/S_Axi_Clk] [get_bd_pins vcu_ddr4_controller_0/phy_Clk]
  connect_bd_net -net Net [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins axi_interconnect_2/S01_ACLK] [get_bd_pins axi_interconnect_2/S02_ACLK] [get_bd_pins axi_interconnect_3/ACLK] [get_bd_pins axi_interconnect_3/M00_ACLK] [get_bd_pins axi_interconnect_3/S00_ACLK] [get_bd_pins axi_interconnect_5/ACLK] [get_bd_pins axi_interconnect_5/M00_ACLK] [get_bd_pins axi_interconnect_5/S00_ACLK] [get_bd_pins axi_interconnect_6/ACLK] [get_bd_pins axi_interconnect_6/M01_ACLK] [get_bd_pins axi_interconnect_6/S00_ACLK] [get_bd_pins axi_interconnect_7/ACLK] [get_bd_pins axi_interconnect_7/M00_ACLK] [get_bd_pins axi_interconnect_7/S00_ACLK] [get_bd_pins clk_wiz_1/clk_out2] [get_bd_pins mpsoc_ss/maxihpm1_fpd_aclk] [get_bd_pins mpsoc_ss/s_axi_hpc0_fpd_aclk] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins v_frmbuf_rd_0/ap_clk] [get_bd_pins v_frmbuf_wr_0/ap_clk] [get_bd_pins vcu_0/m_axi_dec_aclk] [get_bd_pins vcu_0/m_axi_enc_aclk] [get_bd_pins vcu_0/m_axi_mcu_aclk]
  connect_bd_net -net clk_100M [get_bd_pins mpsoc_ss/clk_100M] [get_bd_pins vcu_0/s_axi_lite_aclk]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins clk_wiz_1/clk_out1] [get_bd_pins vcu_0/pll_ref_clk]
  connect_bd_net -net clk_wiz_1_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net mpsoc_ss_Dout [get_bd_pins mpsoc_ss/Dout] [get_bd_pins vcu_0/vcu_resetn]
  connect_bd_net -net mpsoc_ss_Dout2 [get_bd_pins mpsoc_ss/Dout2] [get_bd_pins v_frmbuf_rd_0/ap_rst_n]
  connect_bd_net -net mpsoc_ss_Dout3 [get_bd_pins mpsoc_ss/Dout3] [get_bd_pins v_frmbuf_wr_0/ap_rst_n]
  connect_bd_net -net mpsoc_ss_pl_resetn0_0 [get_bd_pins mpsoc_ss/pl_resetn0_0] [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins proc_sys_reset_2/ext_reset_in]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins axi_interconnect_2/S01_ARESETN] [get_bd_pins axi_interconnect_2/S02_ARESETN] [get_bd_pins axi_interconnect_3/ARESETN] [get_bd_pins axi_interconnect_3/M00_ARESETN] [get_bd_pins axi_interconnect_3/S00_ARESETN] [get_bd_pins axi_interconnect_5/ARESETN] [get_bd_pins axi_interconnect_5/M00_ARESETN] [get_bd_pins axi_interconnect_5/S00_ARESETN] [get_bd_pins axi_interconnect_6/ARESETN] [get_bd_pins axi_interconnect_6/M01_ARESETN] [get_bd_pins axi_interconnect_6/S00_ARESETN] [get_bd_pins axi_interconnect_7/ARESETN] [get_bd_pins axi_interconnect_7/M00_ARESETN] [get_bd_pins axi_interconnect_7/S00_ARESETN] [get_bd_pins mpsoc_ss/reset_333] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
  connect_bd_net -net proc_sys_reset_2_interconnect_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_3/M01_ARESETN] [get_bd_pins axi_interconnect_6/M00_ARESETN] [get_bd_pins mpsoc_ss/M00_ARESETN] [get_bd_pins proc_sys_reset_2/interconnect_aresetn]
  connect_bd_net -net v_frmbuf_rd_0_interrupt [get_bd_pins interrupts/In1] [get_bd_pins v_frmbuf_rd_0/interrupt]
  connect_bd_net -net v_frmbuf_wr_0_interrupt [get_bd_pins interrupts/In2] [get_bd_pins v_frmbuf_wr_0/interrupt]
  connect_bd_net -net vcu_0_vcu_host_interrupt [get_bd_pins interrupts/In0] [get_bd_pins vcu_0/vcu_host_interrupt]
  connect_bd_net -net vcu_ddr4_controller_0_sRst_o [get_bd_pins vcu_ddr4_controller_0/S_Axi_Rst] [get_bd_pins vcu_ddr4_controller_0/phy_sRst]
  connect_bd_net -net xlconcat_dout [get_bd_pins interrupts/dout] [get_bd_pins mpsoc_ss/pl_ps_irq0]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins vcu_ddr4_controller_0/sys_rst] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x80000000 -offset 0x004800000000 [get_bd_addr_spaces v_frmbuf_rd_0/Data_m_axi_mm_video] [get_bd_addr_segs vcu_ddr4_controller_0/S_AXI_PORT4/Reg] SEG_vcu_ddr4_controller_0_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_DDR_LOW] SEG_${::PS_INST}_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_LPS_OCM] SEG_${::PS_INST}_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces v_frmbuf_wr_0/Data_m_axi_mm_video] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_QSPI] SEG_${::PS_INST}_HP3_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x004800000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs vcu_ddr4_controller_0/S_AXI_PORT0/Reg] SEG_vcu_ddr4_controller_0_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x004800000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs vcu_ddr4_controller_0/S_AXI_PORT1/Reg] SEG_vcu_ddr4_controller_0_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x004800000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs vcu_ddr4_controller_0/S_AXI_PORT2/Reg] SEG_vcu_ddr4_controller_0_Reg
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP3/HP1_DDR_HIGH] SEG_${::PS_INST}_HP1_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP3/HP1_DDR_LOW] SEG_${::PS_INST}_HP1_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP3/HP1_LPS_OCM] SEG_${::PS_INST}_HP1_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP3/HP1_QSPI] SEG_${::PS_INST}_HP1_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP4/HP2_DDR_HIGH] SEG_${::PS_INST}_HP2_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP4/HP2_DDR_LOW] SEG_${::PS_INST}_HP2_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP4/HP2_LPS_OCM] SEG_${::PS_INST}_HP2_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/EncData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP4/HP2_QSPI] SEG_${::PS_INST}_HP2_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_DDR_HIGH] SEG_${::PS_INST}_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_DDR_HIGH] SEG_${::PS_INST}_HP3_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_DDR_LOW] SEG_${::PS_INST}_HP3_DDR_LOW
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_DDR_LOW] SEG_${::PS_INST}_HP3_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_LPS_OCM] SEG_${::PS_INST}_HP3_LPS_OCM
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_LPS_OCM] SEG_${::PS_INST}_HP3_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData1] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_QSPI] SEG_${::PS_INST}_HP3_QSPI
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/DecData0] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP5/HP3_QSPI] SEG_${::PS_INST}_HP3_QSPI
  create_bd_addr_seg -range 0x000800000000 -offset 0x000800000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP0/HPC0_DDR_HIGH] SEG_${::PS_INST}_HPC0_DDR_HIGH
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP0/HPC0_DDR_LOW] SEG_${::PS_INST}_HPC0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP0/HPC0_LPS_OCM] SEG_${::PS_INST}_HPC0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces vcu_0/Code] [get_bd_addr_segs mpsoc_ss/${::PS_INST}/SAXIGP0/HPC0_QSPI] SEG_${::PS_INST}_HPC0_QSPI
  create_bd_addr_seg -range 0x00010000 -offset 0xA00F0000 [get_bd_addr_spaces mpsoc_ss/${::PS_INST}/Data] [get_bd_addr_segs v_frmbuf_rd_0/s_axi_CTRL/Reg] SEG_v_frmbuf_rd_0_Reg13
  create_bd_addr_seg -range 0x00010000 -offset 0xA0200000 [get_bd_addr_spaces mpsoc_ss/${::PS_INST}/Data] [get_bd_addr_segs v_frmbuf_wr_0/s_axi_CTRL/Reg] SEG_v_frmbuf_wr_0_Reg15
  create_bd_addr_seg -range 0x00100000 -offset 0xA0100000 [get_bd_addr_spaces mpsoc_ss/${::PS_INST}/Data] [get_bd_addr_segs vcu_0/S_AXI_LITE/Reg] SEG_vcu_0_Reg
  create_bd_addr_seg -range 0x80000000 -offset 0x004800000000 [get_bd_addr_spaces mpsoc_ss/${::PS_INST}/Data] [get_bd_addr_segs vcu_ddr4_controller_0/S_AXI_PORT3/Reg] SEG_vcu_ddr4_controller_0_Reg1


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""
