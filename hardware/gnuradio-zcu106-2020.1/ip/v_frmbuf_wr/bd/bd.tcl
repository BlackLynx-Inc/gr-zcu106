
proc init { cellpath otherInfo } {

    set intf [get_bd_intf_pins $cellpath/m_axi_mm_video]
    set_property CONFIG.HAS_BURST 0 $intf
    set_property CONFIG.HAS_BURST.VALUE_SRC CONSTANT $intf
    set_property CONFIG.SUPPORTS_NARROW_BURST 0 $intf
    set_property CONFIG.SUPPORTS_NARROW_BURST.VALUE_SRC CONSTANT $intf

}

proc post_config_ip { cellpath otherInfo } {

    set cell [get_bd_cells $cellpath]
    set intf [get_bd_intf_pins $cell/m_axi_mm_video]
    set num_out [get_property CONFIG.AXIMM_NUM_OUTSTANDING $cell]
    set_property CONFIG.NUM_WRITE_OUTSTANDING $num_out $intf
    set bur_len [get_property CONFIG.AXIMM_BURST_LENGTH $cell]
    set_property CONFIG.AXIMM_BURST_LENGTH $bur_len $intf

}
