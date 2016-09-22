set_property PACKAGE_PIN R3 [get_ports p_in_sys_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports p_in_sys_clk_p]
set_property PACKAGE_PIN P3 [get_ports p_in_sys_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports p_in_sys_clk_n]
create_clock -period 5.0 -name {pin_in_refclk[p_in_sys_clk_p]} -waveform {0.000 2.5}


set_property PACKAGE_PIN M26 [get_ports {p_out_usrled[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {p_out_usrled[0]}]
set_property PACKAGE_PIN T24 [get_ports {p_out_usrled[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {p_out_usrled[1]}]
set_property PACKAGE_PIN T25 [get_ports {p_out_usrled[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {p_out_usrled[2]}]
set_property PACKAGE_PIN R26 [get_ports {p_out_usrled[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {p_out_usrled[3]}]



###############################################################################
#Configutarion params
###############################################################################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown [current_design]
#set_property BITSTREAM.CONFIG.CONFIGRATE 66 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
#set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-1 [current_design]
#(If the SPI flash is equal to or greater than 256 Mb, uncomment the constraint below):
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]

set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0X00400000 [current_design]