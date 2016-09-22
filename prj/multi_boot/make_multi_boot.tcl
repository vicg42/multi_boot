#make_multi_boot.tcl

set device "xc7a200t"
set package "fbg676"
set speed "-2"
set part $device$package$speed

###########################
### Build Golden Image  ###
###########################
# read vhdl
read_vhdl ../golden/src/lib/vicg_common_pkg.vhd
read_vhdl ../golden/src/lib/time_gen.vhd
read_vhdl ../golden/src/lib/fpga_test_01.vhd
read_vhdl ../golden/src/lib/reduce_pack.vhd
read_vhdl ../golden/src/golden.vhd

# read constraints
read_xdc ../golden/src/AC705_golden.xdc

# Run Synthesis
synth_design -top golden -part $part

# implement
opt_design
place_design
phys_opt_design
route_design

#bitstream
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
write_bitstream -force golden

close_design

###########################
### Build Update Image  ###
###########################
# read vhdl
read_vhdl ../update/src/lib/vicg_common_pkg.vhd
read_vhdl ../update/src/lib/time_gen.vhd
read_vhdl ../update/src/lib/fpga_test_01.vhd
read_vhdl ../update/src/lib/reduce_pack.vhd
read_vhdl ../update/src/update.vhd

# read constraints
read_xdc ../update/src/AC705_update.xdc


# Run Synthesis
synth_design -top update -part $part

# implement
opt_design
place_design
phys_opt_design
route_design

#bitstream
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
write_bitstream -force update

close_design

#########################
### Generate MCS File ###
#########################
write_cfgmem -force -format mcs -size 32 -interface spix4 -verbose \
             -loadbit "up 0 ./golden.bit up 0x00400000 ./update.bit" multi_boot.mcs