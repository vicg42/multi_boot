%XILINX_VV%\bin\vivado.bat -mode batch -source jtag_download.tcl
if exist *.tmp del /F *.tmp
if exist vivado_*.* del /F vivado_*.*
if exist vivado_*.* del /F vivado_*.*