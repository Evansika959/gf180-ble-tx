# Standalone Yosys synthesis of ble_tx on gf180mcu_fd_sc_mcu7t5v0.
# Usage (in the IIC-OSIC-TOOLS container): SPS=2 yosys -c synth.tcl
# TOP=ble_tx_uart synthesizes the block with its UART front end (rtl/ble_uart.v).
# The full flow (floorplan to GDS) is digital/librelane/config.yaml.
yosys -import
set sps [expr {[info exists ::env(SPS)] ? $::env(SPS) : 2}]
set top [expr {[info exists ::env(TOP)] ? $::env(TOP) : "ble_tx"}]
set lib $::env(PDK_ROOT)/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_5v00.lib

read_liberty -lib $lib
read_verilog -defer ../rtl/ble_gauss_lut.v ../rtl/ble_tx.v ../rtl/ble_uart.v
hierarchy -check -top $top -chparam SPS $sps
synth -top $top -flatten
dfflibmap -liberty $lib
abc -liberty $lib
opt_clean -purge
hilomap -hicell gf180mcu_fd_sc_mcu7t5v0__tieh Z -locell gf180mcu_fd_sc_mcu7t5v0__tiel ZN
check -assert
tee -o ${top}_sps${sps}_stat.txt stat -liberty $lib
write_verilog -noattr ${top}_sps${sps}.syn.v
