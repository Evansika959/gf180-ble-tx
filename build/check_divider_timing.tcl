# Usage: sta -exit build/check_divider_timing.tcl
# Uses original 3.3 V characterization and extracted macro RC. Top-level
# parasitics are outside this check. A 25 ns clock bounds 1240 MHz / 32.
set foundry $::env(PDK_ROOT)
set build [file dirname [file normalize [info script]]]
set divider [file join $build .. PLL analog integer_n_divider]
set scl gf180mcu_fd_sc_mcu7t5v0
set libs $foundry/gf180mcuD/libs.ref/$scl/lib
define_corners ss tt ff
foreach {corner lib type} {
    ss ss_125C_3v00 max
    tt tt_025C_3v30 nom
    ff ff_n40C_3v60 min
} {
    read_liberty -corner $corner ${libs}/${scl}__${lib}.lib
}
read_verilog $divider/ble_feedback_divider_routed.v
link_design ble_feedback_divider
foreach {corner type} {ss max tt nom ff min} {
    read_spef -corner $corner $build/timing/$type/ble_feedback_divider.$type.spef
}
create_clock -name clk_prescaled -period 25.0 [get_ports clk_prescaled]
set_clock_transition 0.20 [get_clocks clk_prescaled]
set_clock_uncertainty 0.25 [get_clocks clk_prescaled]
set_propagated_clock [get_clocks clk_prescaled]
set_false_path -from [get_ports {cfg_divider* rst_n}]
set_output_delay -clock clk_prescaled -max 19.0 [get_ports modulus_33]
set_output_delay -clock clk_prescaled -min 0.0 [get_ports modulus_33]
set_output_delay -clock clk_prescaled -max 10.0 [get_ports clk_feedback]
set_output_delay -clock clk_prescaled -min 0.0 [get_ports clk_feedback]
set_load 0.030 [get_ports {modulus_33 clk_feedback}]
report_clock_min_period
report_checks -path_delay min_max -fields {slew cap fanout} -group_path_count 3
report_worst_slack -max
report_worst_slack -min
