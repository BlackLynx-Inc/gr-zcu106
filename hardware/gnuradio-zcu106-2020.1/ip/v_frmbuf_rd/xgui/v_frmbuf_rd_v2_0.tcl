# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set SAMPLES_PER_CLOCK [ipgui::add_param $IPINST -name "SAMPLES_PER_CLOCK" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Specifies the number of pixels processed per clock cycle} ${SAMPLES_PER_CLOCK}
  set MAX_COLS [ipgui::add_param $IPINST -name "MAX_COLS" -parent ${Page_0}]
  set_property tooltip {Specifies the maximum video columns/pixels} ${MAX_COLS}
  set MAX_ROWS [ipgui::add_param $IPINST -name "MAX_ROWS" -parent ${Page_0}]
  set_property tooltip {Specifies the maximum video rows/lines} ${MAX_ROWS}
  set MAX_DATA_WIDTH [ipgui::add_param $IPINST -name "MAX_DATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Specifies the number of bits in each pixel component} ${MAX_DATA_WIDTH}
  set AXIMM_ADDR_WIDTH [ipgui::add_param $IPINST -name "AXIMM_ADDR_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Specifies the number of address bits on the memory mapped AXI4 interface} ${AXIMM_ADDR_WIDTH}
  set HAS_ALPHA [ipgui::add_param $IPINST -name "HAS_ALPHA" -parent ${Page_0} -widget checkBox]
  set_property tooltip {Support for Video Formats with per pixel alpha} ${HAS_ALPHA}
  #Adding Group
  set AlphaFormats [ipgui::add_group $IPINST -name "Alpha Formats" -parent ${Page_0} -display_name {Video Formats with per pixel Alpha} -layout horizontal]
  set HAS_RGBA8      [ipgui::add_param $IPINST -name "HAS_RGBA8" -parent ${AlphaFormats} -widget checkBox]
  set_property tooltip {Packed RGB with alpha with 8 bits per component} ${HAS_RGBA8}
  set HAS_BGRA8      [ipgui::add_param $IPINST -name "HAS_BGRA8" -parent ${AlphaFormats} -widget checkBox]
  set_property tooltip {Packed RGB with alpha with 8 bits per component} ${HAS_BGRA8}
  ipgui::add_row -parent ${AlphaFormats}  $IPINST
  set HAS_YUVA8      [ipgui::add_param $IPINST -name "HAS_YUVA8" -parent ${AlphaFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:4:4 with alpha with 8 bits per component} ${HAS_YUVA8}
  set 8BitFormats [ipgui::add_group $IPINST -name "8BitFormats" -parent ${Page_0} -display_name {8 Bit Video Formats} -layout horizontal]
  set HAS_RGBX8      [ipgui::add_param $IPINST -name "HAS_RGBX8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed RGB with 8 bits per component} ${HAS_RGBX8}
  set HAS_RGB8       [ipgui::add_param $IPINST -name "HAS_RGB8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed RGB with 8 bits per component} ${HAS_RGB8}
  set HAS_BGRX8      [ipgui::add_param $IPINST -name "HAS_BGRX8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed RGB with 8 bits per component} ${HAS_BGRX8}
  ipgui::add_row -parent ${8BitFormats}  $IPINST
  set HAS_YUVX8      [ipgui::add_param $IPINST -name "HAS_YUVX8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:4:4 with 8 bits per component} ${HAS_YUVX8}
  set HAS_YUV8       [ipgui::add_param $IPINST -name "HAS_YUV8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:4:4 with 8 bits per component} ${HAS_YUV8}
  ipgui::add_row -parent ${8BitFormats}  $IPINST
  set HAS_YUYV8      [ipgui::add_param $IPINST -name "HAS_YUYV8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:2:2 with 8 bits per component} ${HAS_YUYV8}
  set HAS_UYVY8      [ipgui::add_param $IPINST -name "HAS_UYVY8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:2:2 with 8 bits per component} ${HAS_UYVY8}
  set HAS_Y_UV8      [ipgui::add_param $IPINST -name "HAS_Y_UV8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Semi-planar YUV 4:2:2 with 8 bits per component} ${HAS_Y_UV8}
  ipgui::add_row -parent ${8BitFormats}  $IPINST
  set HAS_Y_UV8_420  [ipgui::add_param $IPINST -name "HAS_Y_UV8_420" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Semi-planar YUV 4:2:0 with 8 bits per component} ${HAS_Y_UV8_420}
  ipgui::add_row -parent ${8BitFormats}  $IPINST
  set HAS_Y8         [ipgui::add_param $IPINST -name "HAS_Y8" -parent ${8BitFormats} -widget checkBox]
  set_property tooltip {Packed Luma-Only with 8 bits per component} ${HAS_Y8}
  set 10BitFormats [ipgui::add_group $IPINST -name "10BitFormats" -parent ${Page_0} -display_name {10 Bit Video Formats} -layout horizontal]
  set HAS_RGBX10     [ipgui::add_param $IPINST -name "HAS_RGBX10" -parent ${10BitFormats} -widget checkBox]
  set_property tooltip {Packed RGB with 10 bits per component} ${HAS_RGBX10}
  ipgui::add_row -parent ${10BitFormats}  $IPINST
  set HAS_YUVX10     [ipgui::add_param $IPINST -name "HAS_YUVX10" -parent ${10BitFormats} -widget checkBox]
  set_property tooltip {Packed YUV 4:4:4 with 10 bits per component} ${HAS_YUVX10}
  ipgui::add_row -parent ${10BitFormats}  $IPINST
  set HAS_Y_UV10     [ipgui::add_param $IPINST -name "HAS_Y_UV10" -parent ${10BitFormats} -widget checkBox]
  set_property tooltip {Semi-planar YUV 4:2:2 with 10 bits per component} ${HAS_Y_UV10}
  ipgui::add_row -parent ${10BitFormats}  $IPINST
  set HAS_Y_UV10_420 [ipgui::add_param $IPINST -name "HAS_Y_UV10_420" -parent ${10BitFormats} -widget checkBox]
  set_property tooltip {Semi-planar YUV 4:2:0 with 10 bits per component} ${HAS_Y_UV10_420}
  ipgui::add_row -parent ${10BitFormats}  $IPINST
  set HAS_Y10    [ipgui::add_param $IPINST -name "HAS_Y10" -parent ${10BitFormats} -widget checkBox]
  set_property tooltip {Packed Luma-Only with 10 bits per component} ${HAS_Y10}
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS { PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS } {
    # Procedure called to update C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS { PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_ENABLE_ID_PORTS
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_ID_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH PARAM_VALUE.AXIMM_DATA_WIDTH} {
    # Procedure called to update C_M_AXI_MM_VIDEO_DATA_WIDTH when any of the dependent parameters in the arguments change
    set_property value [get_property value ${PARAM_VALUE.AXIMM_DATA_WIDTH}] ${PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH}
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_DATA_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS { PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS } {
    # Procedure called to update C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS { PARAM_VALUE.C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_ENABLE_USER_PORTS
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_AWUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_AWUSER_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_WUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_WUSER_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_BUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_BUSER_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_ARUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_ARUSER_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH } {
    # Procedure called to update C_M_AXI_MM_VIDEO_RUSER_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH { PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_RUSER_WIDTH
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE } {
    # Procedure called to update C_M_AXI_MM_VIDEO_USER_VALUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_USER_VALUE
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE } {
    # Procedure called to update C_M_AXI_MM_VIDEO_PROT_VALUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_PROT_VALUE
    return true
}

proc update_PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE } {
    # Procedure called to update C_M_AXI_MM_VIDEO_CACHE_VALUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE { PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE } {
    # Procedure called to validate C_M_AXI_MM_VIDEO_CACHE_VALUE
    return true
}

proc update_PARAM_VALUE.NUM_VIDEO_COMPONENTS { PARAM_VALUE.NUM_VIDEO_COMPONENTS PARAM_VALUE.HAS_BGRA8 PARAM_VALUE.HAS_RGBA8 PARAM_VALUE.HAS_YUVA8 } {
    # Procedure called to update NUM_VIDEO_COMPONENTS when any of the dependent parameters in the arguments change
    set val 3
    if { [get_property value ${PARAM_VALUE.HAS_RGBA8}]==1 || [get_property value ${PARAM_VALUE.HAS_BGRA8}]==1 || [get_property value ${PARAM_VALUE.HAS_YUVA8}]==1 } {
        set val 4
    }
        set_property value $val ${PARAM_VALUE.NUM_VIDEO_COMPONENTS}
}


proc validate_PARAM_VALUE.NUM_VIDEO_COMPONENTS { PARAM_VALUE.NUM_VIDEO_COMPONENTS } {
    # Procedure called to validate NUM_VIDEO_COMPONENTS
    return true
}

proc update_PARAM_VALUE.SAMPLES_PER_CLOCK { PARAM_VALUE.SAMPLES_PER_CLOCK } {
    # Procedure called to update SAMPLES_PER_CLOCK when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SAMPLES_PER_CLOCK { PARAM_VALUE.SAMPLES_PER_CLOCK } {
    # Procedure called to validate SAMPLES_PER_CLOCK
    return true
}

proc update_PARAM_VALUE.MAX_COLS { PARAM_VALUE.MAX_COLS } {
    # Procedure called to update MAX_COLS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_COLS { PARAM_VALUE.MAX_COLS } {
    # Procedure called to validate MAX_COLS
    return true
}

proc update_PARAM_VALUE.MAX_ROWS { PARAM_VALUE.MAX_ROWS } {
    # Procedure called to update MAX_ROWS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_ROWS { PARAM_VALUE.MAX_ROWS } {
    # Procedure called to validate MAX_ROWS
    return true
}

proc update_PARAM_VALUE.MAX_DATA_WIDTH { PARAM_VALUE.MAX_DATA_WIDTH } {
    # Procedure called to update MAX_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MAX_DATA_WIDTH { PARAM_VALUE.MAX_DATA_WIDTH } {
    # Procedure called to validate MAX_DATA_WIDTH
    return true
}

proc update_PARAM_VALUE.AXIMM_DATA_WIDTH { PARAM_VALUE.SAMPLES_PER_CLOCK PARAM_VALUE.AXIMM_DATA_WIDTH } {
    # Procedure called to update AXIMM_DATA_WIDTH when any of the dependent parameters in the arguments change
    set samples_per_clock_value [get_property value ${PARAM_VALUE.SAMPLES_PER_CLOCK}]
    set aximm_data_width_value [ expr $samples_per_clock_value*32*2 ]
    set_property value $aximm_data_width_value ${PARAM_VALUE.AXIMM_DATA_WIDTH}
}

proc validate_PARAM_VALUE.AXIMM_DATA_WIDTH { PARAM_VALUE.AXIMM_DATA_WIDTH } {
    # Procedure called to validate AXIMM_DATA_WIDTH
    return true
}

proc update_PARAM_VALUE.AXIMM_NUM_OUTSTANDING { PARAM_VALUE.AXIMM_NUM_OUTSTANDING } {
    # Procedure called to update AXIMM_NUM_OUTSTANDING when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXIMM_NUM_OUTSTANDING { PARAM_VALUE.AXIMM_NUM_OUTSTANDING } {
    # Procedure called to validate AXIMM_NUM_OUTSTANDING
    return true
}

proc update_PARAM_VALUE.AXIMM_BURST_LENGTH { PARAM_VALUE.AXIMM_BURST_LENGTH } {
    # Procedure called to update AXIMM_BURST_LENGTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXIMM_BURST_LENGTH { PARAM_VALUE.AXIMM_BURST_LENGTH } {
    # Procedure called to validate AXIMM_BURST_LENGTH
    return true
}

proc update_PARAM_VALUE.HAS_ALPHA { PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_ALPHA when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HAS_ALPHA { PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to validate HAS_ALPHA
    return true
}

proc update_PARAM_VALUE.HAS_RGBX8 { PARAM_VALUE.HAS_RGBX8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_RGBX8 when any of the dependent parameters in the arguments change
    set has_rgbx8 ${PARAM_VALUE.HAS_RGBX8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_rgbx8
        set_property value 0 $has_rgbx8
    } else {
        set_property enabled true $has_rgbx8
    }
}

proc validate_PARAM_VALUE.HAS_RGBX8 { PARAM_VALUE.HAS_RGBX8 } {
    # Procedure called to validate HAS_RGBX8
    return true
}

proc update_PARAM_VALUE.HAS_YUVX8 { PARAM_VALUE.HAS_YUVX8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_YUVX8 when any of the dependent parameters in the arguments change
    set has_yuvx8 ${PARAM_VALUE.HAS_YUVX8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_yuvx8
        set_property value 0 $has_yuvx8
    } else {
        set_property enabled true $has_yuvx8
    }
}

proc validate_PARAM_VALUE.HAS_YUVX8 { PARAM_VALUE.HAS_YUVX8 } {
    # Procedure called to validate HAS_YUVX8
    return true
}

proc update_PARAM_VALUE.HAS_YUYV8 { PARAM_VALUE.HAS_YUYV8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_YUYV8 when any of the dependent parameters in the arguments change
    set has_yuyv8 ${PARAM_VALUE.HAS_YUYV8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_yuyv8
        set_property value 0 $has_yuyv8
    } else {
        set_property enabled true $has_yuyv8
    }
}

proc validate_PARAM_VALUE.HAS_YUYV8 { PARAM_VALUE.HAS_YUYV8 } {
    # Procedure called to validate HAS_YUYV8
    return true
}

proc update_PARAM_VALUE.HAS_RGBA8 { PARAM_VALUE.HAS_RGBA8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_RGBA8 when any of the dependent parameters in the arguments change
    set has_rgba8 ${PARAM_VALUE.HAS_RGBA8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 0} {
        set_property enabled false $has_rgba8
        set_property value 0 $has_rgba8
    } else {
        set_property enabled true $has_rgba8
    }
}

proc validate_PARAM_VALUE.HAS_RGBA8 { PARAM_VALUE.HAS_RGBA8 PARAM_VALUE.HAS_YUVA8 PARAM_VALUE.HAS_BGRA8 PARAM_VALUE.HAS_ALPHA} {
    # Procedure called to validate HAS_RGBA8
    set RGBA8 [get_property value ${PARAM_VALUE.HAS_RGBA8}]
    set YUVA8 [get_property value ${PARAM_VALUE.HAS_YUVA8}]
    set BGRA8 [get_property value ${PARAM_VALUE.HAS_BGRA8}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]

    if { $has_alpha == 1 && $RGBA8 == 0 && $YUVA8 == 0 && $BGRA8 == 0 } {
        set_property errmsg "Please select at least one Alpha Video Format" ${PARAM_VALUE.HAS_RGBA8}
        return false
    }
    return true
}

proc update_PARAM_VALUE.HAS_YUVA8 { PARAM_VALUE.HAS_YUVA8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_YUVA8 when any of the dependent parameters in the arguments change
    set has_yuva8 ${PARAM_VALUE.HAS_YUVA8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 0} {
        set_property enabled false $has_yuva8
        set_property value 0 $has_yuva8
    } else {
        set_property enabled true $has_yuva8
    }
}

proc validate_PARAM_VALUE.HAS_YUVA8 { PARAM_VALUE.HAS_YUVA8 } {
    # Procedure called to validate HAS_YUVA8
    return true
}

proc update_PARAM_VALUE.HAS_RGBX10 { PARAM_VALUE.MAX_DATA_WIDTH PARAM_VALUE.HAS_RGBX10 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_RGBX10 when any of the dependent parameters in the arguments change
    set has_rgbx10 ${PARAM_VALUE.HAS_RGBX10}
    set data_width [get_property value ${PARAM_VALUE.MAX_DATA_WIDTH}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]
    if { $data_width == 8 || $has_alpha == 1} {
        set_property enabled false $has_rgbx10
        set_property value 0 $has_rgbx10
    } else {
        set_property enabled true $has_rgbx10
    }
}

proc validate_PARAM_VALUE.HAS_RGBX10 { PARAM_VALUE.HAS_RGBX10 } {
    # Procedure called to validate HAS_RGBX10
    return true
}

proc update_PARAM_VALUE.HAS_YUVX10 { PARAM_VALUE.MAX_DATA_WIDTH PARAM_VALUE.HAS_YUVX10 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_YUVX10 when any of the dependent parameters in the arguments change
    set has_yuvx10 ${PARAM_VALUE.HAS_YUVX10}
    set data_width [get_property value ${PARAM_VALUE.MAX_DATA_WIDTH}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]
    if { $data_width == 8 || $has_alpha == 1} {
        set_property enabled false $has_yuvx10
        set_property value 0 $has_yuvx10
    } else {
        set_property enabled true $has_yuvx10
    }
}

proc validate_PARAM_VALUE.HAS_YUVX10 { PARAM_VALUE.HAS_YUVX10 } {
    # Procedure called to validate HAS_YUVX10
    return true
}

proc update_PARAM_VALUE.HAS_Y_UV8 { PARAM_VALUE.HAS_Y_UV8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y_UV8 when any of the dependent parameters in the arguments change
    set has_y_uv8 ${PARAM_VALUE.HAS_Y_UV8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_y_uv8
        set_property value 0 $has_y_uv8
    } else {
        set_property enabled true $has_y_uv8
    }
}

proc validate_PARAM_VALUE.HAS_Y_UV8 { PARAM_VALUE.HAS_Y_UV8 } {
    # Procedure called to validate HAS_Y_UV8
    return true
}

proc update_PARAM_VALUE.HAS_Y_UV8_420 { PARAM_VALUE.HAS_Y_UV8_420 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y_UV8_420 when any of the dependent parameters in the arguments change
    set has_y_uv8_420 ${PARAM_VALUE.HAS_Y_UV8_420}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_y_uv8_420
        set_property value 0 $has_y_uv8_420
    } else {
        set_property enabled true $has_y_uv8_420
    }
}

proc validate_PARAM_VALUE.HAS_Y_UV8_420 { PARAM_VALUE.HAS_Y_UV8_420 } {
    # Procedure called to validate HAS_Y_UV8_420
    return true
}

proc update_PARAM_VALUE.HAS_RGB8 { PARAM_VALUE.HAS_RGB8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_RGB8 when any of the dependent parameters in the arguments change
    set has_rgb8 ${PARAM_VALUE.HAS_RGB8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_rgb8
        set_property value 0 $has_rgb8
    } else {
        set_property enabled true $has_rgb8
    }
}

proc validate_PARAM_VALUE.HAS_RGB8 { PARAM_VALUE.HAS_RGBX8 PARAM_VALUE.HAS_YUVX8 PARAM_VALUE.HAS_YUYV8
                                     PARAM_VALUE.HAS_RGBX10 PARAM_VALUE.HAS_YUVX10
                                     PARAM_VALUE.HAS_Y_UV8 PARAM_VALUE.HAS_Y_UV8_420
                                     PARAM_VALUE.HAS_RGB8 PARAM_VALUE.HAS_YUV8
                                     PARAM_VALUE.HAS_Y_UV10 PARAM_VALUE.HAS_Y_UV10_420
                                     PARAM_VALUE.HAS_Y8 PARAM_VALUE.HAS_Y10
                                     PARAM_VALUE.HAS_BGRX8 PARAM_VALUE.HAS_UYVY8
                                     PARAM_VALUE.HAS_ALPHA
 } {
    # Procedure called to validate HAS_RGB8
    set RGBX8 [get_property value ${PARAM_VALUE.HAS_RGBX8}]
    set YUVX8 [get_property value ${PARAM_VALUE.HAS_YUVX8}]
    set YUYV8 [get_property value ${PARAM_VALUE.HAS_YUYV8}]
    set RGBX10 [get_property value ${PARAM_VALUE.HAS_RGBX10}]
    set YUVX10 [get_property value ${PARAM_VALUE.HAS_YUVX10}]
    set Y_UV8 [get_property value ${PARAM_VALUE.HAS_Y_UV8}]
    set Y_UV8_420 [get_property value ${PARAM_VALUE.HAS_Y_UV8_420}]
    set RGB8 [get_property value ${PARAM_VALUE.HAS_RGB8}]
    set YUV8 [get_property value ${PARAM_VALUE.HAS_YUV8}]
    set Y_UV10 [get_property value ${PARAM_VALUE.HAS_Y_UV10}]
    set Y_UV10_420 [get_property value ${PARAM_VALUE.HAS_Y_UV10_420}]
    set Y8 [get_property value ${PARAM_VALUE.HAS_Y8}]
    set Y10 [get_property value ${PARAM_VALUE.HAS_Y10}]
    set BGRX8 [get_property value ${PARAM_VALUE.HAS_BGRX8}]
    set UYVY8 [get_property value ${PARAM_VALUE.HAS_UYVY8}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]

    if { $has_alpha == 0 && $RGBX8 == 0 && $YUVX8 == 0 && $YUYV8 == 0 && $RGBX10 == 0 && $YUVX10 == 0 && $Y_UV8 == 0 && $Y_UV8_420 == 0 && $RGB8 == 0 && $YUV8 == 0 && $Y_UV10 == 0 && $Y_UV10_420 == 0 && $Y8 == 0 && $Y10 == 0 && $BGRX8 == 0 && $UYVY8 == 0 } {
        set_property errmsg "Please select at least one Video Format" ${PARAM_VALUE.HAS_RGB8}
        return false
    }
    return true
}

proc update_PARAM_VALUE.HAS_YUV8 { PARAM_VALUE.HAS_YUV8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_YUV8 when any of the dependent parameters in the arguments change
    set has_yuv8 ${PARAM_VALUE.HAS_YUV8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_yuv8
        set_property value 0 $has_yuv8
    } else {
        set_property enabled true $has_yuv8
    }
}

proc validate_PARAM_VALUE.HAS_YUV8 { PARAM_VALUE.HAS_YUV8 } {
    # Procedure called to validate HAS_YUV8
    return true
}

proc update_PARAM_VALUE.HAS_Y_UV10 { PARAM_VALUE.MAX_DATA_WIDTH PARAM_VALUE.HAS_Y_UV10 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y_UV10 when any of the dependent parameters in the arguments change
    set has_y_uv10 ${PARAM_VALUE.HAS_Y_UV10}
    set data_width [get_property value ${PARAM_VALUE.MAX_DATA_WIDTH}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]
    if { $data_width == 8 || $has_alpha == 1} {
        set_property enabled false $has_y_uv10
        set_property value 0 $has_y_uv10
    } else {
        set_property enabled true $has_y_uv10
    }
}

proc validate_PARAM_VALUE.HAS_Y_UV10 { PARAM_VALUE.HAS_Y_UV10 } {
    # Procedure called to validate HAS_Y_UV10
    return true
}

proc update_PARAM_VALUE.HAS_Y_UV10_420 { PARAM_VALUE.MAX_DATA_WIDTH PARAM_VALUE.HAS_Y_UV10_420 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y_UV10_420 when any of the dependent parameters in the arguments change
    set has_y_uv10_420 ${PARAM_VALUE.HAS_Y_UV10_420}
    set data_width [get_property value ${PARAM_VALUE.MAX_DATA_WIDTH}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]
    if { $data_width == 8 || $has_alpha == 1} {
        set_property enabled false $has_y_uv10_420
        set_property value 0 $has_y_uv10_420
    } else {
        set_property enabled true $has_y_uv10_420
    }
}

proc validate_PARAM_VALUE.HAS_Y_UV10_420 { PARAM_VALUE.HAS_Y_UV10_420 } {
    # Procedure called to validate HAS_Y_UV10_420
    return true
}

proc update_PARAM_VALUE.HAS_Y8 { PARAM_VALUE.HAS_Y8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y8 when any of the dependent parameters in the arguments change
    set has_y8 ${PARAM_VALUE.HAS_Y8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_y8
        set_property value 0 $has_y8
    } else {
        set_property enabled true $has_y8
    }
}

proc validate_PARAM_VALUE.HAS_Y8 { PARAM_VALUE.HAS_Y8 } {
    # Procedure called to validate HAS_Y8
    return true
}

proc update_PARAM_VALUE.HAS_Y10 { PARAM_VALUE.MAX_DATA_WIDTH PARAM_VALUE.HAS_Y10 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_Y10 when any of the dependent parameters in the arguments change
    set has_y10 ${PARAM_VALUE.HAS_Y10}
    set data_width [get_property value ${PARAM_VALUE.MAX_DATA_WIDTH}]
    set has_alpha [get_property value ${PARAM_VALUE.HAS_ALPHA}]
    if { $data_width == 8 || $has_alpha == 1} {
        set_property enabled false $has_y10
        set_property value 0 $has_y10
    } else {
        set_property enabled true $has_y10
    }
}

proc validate_PARAM_VALUE.HAS_Y10 { PARAM_VALUE.HAS_Y10 } {
    # Procedure called to validate HAS_Y10
    return true
}

proc update_PARAM_VALUE.HAS_BGRA8 { PARAM_VALUE.HAS_BGRA8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_BGRA8 when any of the dependent parameters in the arguments change
    set has_bgra8 ${PARAM_VALUE.HAS_BGRA8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 0} {
        set_property enabled false $has_bgra8
        set_property value 0 $has_bgra8
    } else {
        set_property enabled true $has_bgra8
    }
}

proc validate_PARAM_VALUE.HAS_BGRA8 { PARAM_VALUE.HAS_BGRA8 } {
    # Procedure called to validate HAS_BGRA8
    return true
}

proc update_PARAM_VALUE.HAS_BGRX8 { PARAM_VALUE.HAS_BGRX8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_BGRX8 when any of the dependent parameters in the arguments change
    set has_bgrx8 ${PARAM_VALUE.HAS_BGRX8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_bgrx8
        set_property value 0 $has_bgrx8
    } else {
        set_property enabled true $has_bgrx8
    }
}

proc validate_PARAM_VALUE.HAS_BGRX8 { PARAM_VALUE.HAS_BGRX8 } {
    # Procedure called to validate HAS_BGRX8
    return true
}

proc update_PARAM_VALUE.HAS_UYVY8 { PARAM_VALUE.HAS_UYVY8 PARAM_VALUE.HAS_ALPHA } {
    # Procedure called to update HAS_UYVY8 when any of the dependent parameters in the arguments change
    set has_uyvy8 ${PARAM_VALUE.HAS_UYVY8}
    if {[get_property value ${PARAM_VALUE.HAS_ALPHA}] == 1} {
        set_property enabled false $has_uyvy8
        set_property value 0 $has_uyvy8
    } else {
        set_property enabled true $has_uyvy8
    }
}

proc validate_PARAM_VALUE.HAS_UYVY8 { PARAM_VALUE.HAS_UYVY8 } {
    # Procedure called to validate HAS_UYVY8
    return true
}

proc update_PARAM_VALUE.MAX_NR_PLANES { PARAM_VALUE.HAS_Y_UV8 PARAM_VALUE.HAS_Y_UV8_420 PARAM_VALUE.HAS_Y_UV10 PARAM_VALUE.HAS_Y_UV10_420 PARAM_VALUE.MAX_NR_PLANES } {
    # Procedure called to update MAX_NR_PLANES when any of the dependent parameters in the arguments change
    set val 1
    if { [get_property value ${PARAM_VALUE.HAS_Y_UV8}]==1 || [get_property value ${PARAM_VALUE.HAS_Y_UV8_420}]==1 || [get_property value ${PARAM_VALUE.HAS_Y_UV10}]==1 || [get_property value ${PARAM_VALUE.HAS_Y_UV10_420}]==1 } {
        set val 2
    }
        set_property value $val ${PARAM_VALUE.MAX_NR_PLANES}
}

proc validate_PARAM_VALUE.MAX_NR_PLANES { PARAM_VALUE.MAX_NR_PLANES } {
    # Procedure called to validate MAX_NR_PLANES
    return true
}

proc validate_PARAM_VALUE.AXIMM_ADDR_WIDTH { PARAM_VALUE.AXIMM_ADDR_WIDTH } {
    # Procedure called to validate AXIMM_ADDR_WIDTH
    return true
}

proc update_PARAM_VALUE.AXIMM_ADDR_WIDTH { PARAM_VALUE.AXIMM_ADDR_WIDTH } {
    # Procedure called to update AXIMM_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

#proc update_MODELPARAM_VALUE.C_S_AXI_CTRL_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_CTRL_ADDR_WIDTH } {
#    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
#    # WARNING: There is no corresponding user parameter named "C_S_AXI_CTRL_ADDR_WIDTH". Setting updated value from the model parameter.
#set_property value 7 ${MODELPARAM_VALUE.C_S_AXI_CTRL_ADDR_WIDTH}
#}

proc update_MODELPARAM_VALUE.C_S_AXI_CTRL_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_CTRL_DATA_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    # WARNING: There is no corresponding user parameter named "C_S_AXI_CTRL_DATA_WIDTH". Setting updated value from the model parameter.
set_property value 32 ${MODELPARAM_VALUE.C_S_AXI_CTRL_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ADDR_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ADDR_WIDTH PARAM_VALUE.AXIMM_ADDR_WIDTH} {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.AXIMM_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_AWUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_ARUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_WUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_RUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_BUSER_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_USER_VALUE}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_PROT_VALUE}
}

proc update_MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE { MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE } {
    # Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    set_property value [get_property value ${PARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE}] ${MODELPARAM_VALUE.C_M_AXI_MM_VIDEO_CACHE_VALUE}
}

