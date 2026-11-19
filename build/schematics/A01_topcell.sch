v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {BLE transmitter and 1 MHz PLL integration} -160 -105 0 0 0.52 0.52 {}
T {High-impedance external regulator: VCTRL input, VDD_VCO output} -160 -63 0 0 0.29 0.29 {}
T {FINE_CODE and CODE_VALID are the digital modulation interface} -160 -39 0 0 0.29 0.29 {}
C {iopin.sym} -210 1190 0 0 {name=p1 lab=VDD}
C {iopin.sym} -210 1215 0 0 {name=p2 lab=VSS}
C {iopin.sym} -210 1240 0 0 {name=p3 lab=VDD_VCO}
C {iopin.sym} -210 1265 0 0 {name=p4 lab=VCTRL}
C {iopin.sym} -210 1290 0 0 {name=p5 lab=CP_IBIAS}
C {iopin.sym} -210 1315 0 0 {name=p6 lab=TAIL_BIAS}
C {iopin.sym} -210 1340 0 0 {name=p7 lab=VTUNE}
C {iopin.sym} -210 1365 0 0 {name=p8 lab=REF_1M}
C {iopin.sym} -210 1390 0 0 {name=p9 lab=CLK_8M}
C {iopin.sym} -210 1415 0 0 {name=p10 lab=UART_RX}
C {iopin.sym} -210 1440 0 0 {name=p11 lab=RST_N}
C {iopin.sym} 180 1190 0 0 {name=p12 lab=CFG[0]}
C {iopin.sym} 180 1215 0 0 {name=p13 lab=CFG[1]}
C {iopin.sym} 180 1240 0 0 {name=p14 lab=CFG[2]}
C {iopin.sym} 180 1265 0 0 {name=p15 lab=CFG[3]}
C {iopin.sym} 180 1290 0 0 {name=p16 lab=CFG[4]}
C {iopin.sym} 180 1315 0 0 {name=p17 lab=CFG[5]}
C {iopin.sym} 180 1340 0 0 {name=p18 lab=RF_OUT}
C {iopin.sym} 180 1365 0 0 {name=p19 lab=FINE_CODE[0]}
C {iopin.sym} 180 1390 0 0 {name=p20 lab=FINE_CODE[1]}
C {iopin.sym} 180 1415 0 0 {name=p21 lab=FINE_CODE[2]}
C {iopin.sym} 180 1440 0 0 {name=p22 lab=FINE_CODE[3]}
C {iopin.sym} 570 1190 0 0 {name=p23 lab=FINE_CODE[4]}
C {iopin.sym} 570 1215 0 0 {name=p24 lab=FINE_CODE[5]}
C {iopin.sym} 570 1240 0 0 {name=p25 lab=FINE_CODE[6]}
C {iopin.sym} 570 1265 0 0 {name=p26 lab=FINE_CODE[7]}
C {iopin.sym} 570 1290 0 0 {name=p27 lab=CODE_VALID}
C {iopin.sym} 570 1315 0 0 {name=p28 lab=AIR_BIT}
C {iopin.sym} 570 1340 0 0 {name=p29 lab=SYM_STROBE}
C {code_shown.sym} -185 1040 0 0 {name=MACROMODELS only_toplevel=false value=".include ../spice/blocks_pex.spice"}
C {tx.sym} 480 900 0 0 {name=Xtx}
N 310 830 350 830 {lab=VDD}
C {lab_pin.sym} 310 830 0 0 {name=L_tx_0 lab=VDD}
N 310 850 350 850 {lab=VSS}
C {lab_pin.sym} 310 850 0 0 {name=L_tx_1 lab=VSS}
N 310 870 350 870 {lab=AIR_BIT}
C {lab_pin.sym} 310 870 0 0 {name=L_tx_2 lab=AIR_BIT}
N 310 890 350 890 {lab=CLK_8M}
C {lab_pin.sym} 310 890 0 0 {name=L_tx_3 lab=CLK_8M}
N 310 910 350 910 {lab=CODE_VALID}
C {lab_pin.sym} 310 910 0 0 {name=L_tx_4 lab=CODE_VALID}
N 310 930 350 930 {lab=FINE_CODE[0]}
C {lab_pin.sym} 310 930 0 0 {name=L_tx_5 lab=FINE_CODE[0]}
N 310 950 350 950 {lab=FINE_CODE[1]}
C {lab_pin.sym} 310 950 0 0 {name=L_tx_6 lab=FINE_CODE[1]}
N 310 970 350 970 {lab=FINE_CODE[2]}
C {lab_pin.sym} 310 970 0 0 {name=L_tx_7 lab=FINE_CODE[2]}
N 610 830 650 830 {lab=FINE_CODE[3]}
C {lab_pin.sym} 650 830 0 1 {name=L_tx_8 lab=FINE_CODE[3]}
N 610 850 650 850 {lab=FINE_CODE[4]}
C {lab_pin.sym} 650 850 0 1 {name=L_tx_9 lab=FINE_CODE[4]}
N 610 870 650 870 {lab=FINE_CODE[5]}
C {lab_pin.sym} 650 870 0 1 {name=L_tx_10 lab=FINE_CODE[5]}
N 610 890 650 890 {lab=FINE_CODE[6]}
C {lab_pin.sym} 650 890 0 1 {name=L_tx_11 lab=FINE_CODE[6]}
N 610 910 650 910 {lab=FINE_CODE[7]}
C {lab_pin.sym} 650 910 0 1 {name=L_tx_12 lab=FINE_CODE[7]}
N 610 930 650 930 {lab=RST_N}
C {lab_pin.sym} 650 930 0 1 {name=L_tx_13 lab=RST_N}
N 610 950 650 950 {lab=SYM_STROBE}
C {lab_pin.sym} 650 950 0 1 {name=L_tx_14 lab=SYM_STROBE}
N 610 970 650 970 {lab=UART_RX}
C {lab_pin.sym} 650 970 0 1 {name=L_tx_15 lab=UART_RX}
C {divider.sym} 960 160 0 0 {name=Xdivider}
N 790 110 830 110 {lab=VDD}
C {lab_pin.sym} 790 110 0 0 {name=L_divider_0 lab=VDD}
N 790 130 830 130 {lab=VSS}
C {lab_pin.sym} 790 130 0 0 {name=L_divider_1 lab=VSS}
N 790 150 830 150 {lab=CFG[0]}
C {lab_pin.sym} 790 150 0 0 {name=L_divider_2 lab=CFG[0]}
N 790 170 830 170 {lab=CFG[1]}
C {lab_pin.sym} 790 170 0 0 {name=L_divider_3 lab=CFG[1]}
N 790 190 830 190 {lab=CFG[2]}
C {lab_pin.sym} 790 190 0 0 {name=L_divider_4 lab=CFG[2]}
N 790 210 830 210 {lab=CFG[3]}
C {lab_pin.sym} 790 210 0 0 {name=L_divider_5 lab=CFG[3]}
N 1090 110 1130 110 {lab=CFG[4]}
C {lab_pin.sym} 1130 110 0 1 {name=L_divider_6 lab=CFG[4]}
N 1090 130 1130 130 {lab=CFG[5]}
C {lab_pin.sym} 1130 130 0 1 {name=L_divider_7 lab=CFG[5]}
N 1090 150 1130 150 {lab=FB_1M}
C {lab_pin.sym} 1130 150 0 1 {name=L_divider_8 lab=FB_1M}
N 1090 170 1130 170 {lab=PRESCALED}
C {lab_pin.sym} 1130 170 0 1 {name=L_divider_9 lab=PRESCALED}
N 1090 190 1130 190 {lab=MC}
C {lab_pin.sym} 1130 190 0 1 {name=L_divider_10 lab=MC}
N 1090 210 1130 210 {lab=RST_N}
C {lab_pin.sym} 1130 210 0 1 {name=L_divider_11 lab=RST_N}
C {prescaler.sym} 480 160 0 0 {name=Xprescaler}
N 310 140 350 140 {lab=VDD}
C {lab_pin.sym} 310 140 0 0 {name=L_prescaler_0 lab=VDD}
N 310 160 350 160 {lab=VSS}
C {lab_pin.sym} 310 160 0 0 {name=L_prescaler_1 lab=VSS}
N 310 180 350 180 {lab=CORE_CLK}
C {lab_pin.sym} 310 180 0 0 {name=L_prescaler_2 lab=CORE_CLK}
N 610 140 650 140 {lab=MC}
C {lab_pin.sym} 650 140 0 1 {name=L_prescaler_3 lab=MC}
N 610 160 650 160 {lab=PRESCALED}
C {lab_pin.sym} 650 160 0 1 {name=L_prescaler_4 lab=PRESCALED}
C {vco.sym} 0 160 0 0 {name=Xvco}
N -170 90 -130 90 {lab=VDD_VCO}
C {lab_pin.sym} -170 90 0 0 {name=L_vco_0 lab=VDD_VCO}
N -170 110 -130 110 {lab=VDD}
C {lab_pin.sym} -170 110 0 0 {name=L_vco_1 lab=VDD}
N -170 130 -130 130 {lab=VSS}
C {lab_pin.sym} -170 130 0 0 {name=L_vco_2 lab=VSS}
N -170 150 -130 150 {lab=vco_O1P}
C {lab_pin.sym} -170 150 0 0 {name=L_vco_3 lab=vco_O1P}
N -170 170 -130 170 {lab=vco_O1N}
C {lab_pin.sym} -170 170 0 0 {name=L_vco_4 lab=vco_O1N}
N -170 190 -130 190 {lab=vco_O2P}
C {lab_pin.sym} -170 190 0 0 {name=L_vco_5 lab=vco_O2P}
N -170 210 -130 210 {lab=vco_O2N}
C {lab_pin.sym} -170 210 0 0 {name=L_vco_6 lab=vco_O2N}
N -170 230 -130 230 {lab=vco_O3P}
C {lab_pin.sym} -170 230 0 0 {name=L_vco_7 lab=vco_O3P}
N 130 90 170 90 {lab=vco_O3N}
C {lab_pin.sym} 170 90 0 1 {name=L_vco_8 lab=vco_O3N}
N 130 110 170 110 {lab=vco_O4P}
C {lab_pin.sym} 170 110 0 1 {name=L_vco_9 lab=vco_O4P}
N 130 130 170 130 {lab=vco_O4N}
C {lab_pin.sym} 170 130 0 1 {name=L_vco_10 lab=vco_O4N}
N 130 150 170 150 {lab=RF_OUT}
C {lab_pin.sym} 170 150 0 1 {name=L_vco_11 lab=RF_OUT}
N 130 170 170 170 {lab=VTUNE}
C {lab_pin.sym} 170 170 0 1 {name=L_vco_12 lab=VTUNE}
N 130 190 170 190 {lab=TAIL_BIAS}
C {lab_pin.sym} 170 190 0 1 {name=L_vco_13 lab=TAIL_BIAS}
N 130 210 170 210 {lab=CORE_CLK}
C {lab_pin.sym} 170 210 0 1 {name=L_vco_14 lab=CORE_CLK}
C {pfd.sym} 960 540 0 0 {name=Xpfd}
N 790 510 830 510 {lab=VDD}
C {lab_pin.sym} 790 510 0 0 {name=L_pfd_0 lab=VDD}
N 790 530 830 530 {lab=VSS}
C {lab_pin.sym} 790 530 0 0 {name=L_pfd_1 lab=VSS}
N 790 550 830 550 {lab=REF_1M}
C {lab_pin.sym} 790 550 0 0 {name=L_pfd_2 lab=REF_1M}
N 790 570 830 570 {lab=FB_1M}
C {lab_pin.sym} 790 570 0 0 {name=L_pfd_3 lab=FB_1M}
N 1090 510 1130 510 {lab=pfd_UP}
C {lab_pin.sym} 1130 510 0 1 {name=L_pfd_4 lab=pfd_UP}
N 1090 530 1130 530 {lab=DN}
C {lab_pin.sym} 1130 530 0 1 {name=L_pfd_5 lab=DN}
N 1090 550 1130 550 {lab=UPB}
C {lab_pin.sym} 1130 550 0 1 {name=L_pfd_6 lab=UPB}
N 1090 570 1130 570 {lab=pfd_DNb}
C {lab_pin.sym} 1130 570 0 1 {name=L_pfd_7 lab=pfd_DNb}
C {pump.sym} 480 540 0 0 {name=Xpump}
N 310 520 350 520 {lab=VDD}
C {lab_pin.sym} 310 520 0 0 {name=L_pump_0 lab=VDD}
N 310 540 350 540 {lab=VSS}
C {lab_pin.sym} 310 540 0 0 {name=L_pump_1 lab=VSS}
N 310 560 350 560 {lab=UPB}
C {lab_pin.sym} 310 560 0 0 {name=L_pump_2 lab=UPB}
N 610 520 650 520 {lab=DN}
C {lab_pin.sym} 650 520 0 1 {name=L_pump_3 lab=DN}
N 610 540 650 540 {lab=CP_IBIAS}
C {lab_pin.sym} 650 540 0 1 {name=L_pump_4 lab=CP_IBIAS}
N 610 560 650 560 {lab=VCTRL}
C {lab_pin.sym} 650 560 0 1 {name=L_pump_5 lab=VCTRL}
C {loop.sym} 0 540 0 0 {name=Xloop}
N -170 540 -130 540 {lab=VCTRL}
C {lab_pin.sym} -170 540 0 0 {name=L_loop_0 lab=VCTRL}
N 130 540 170 540 {lab=VSS}
C {lab_pin.sym} 170 540 0 1 {name=L_loop_1 lab=VSS}
