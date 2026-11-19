v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
T {DAC MOSCAP tuning: identical shunt loads on both sides of every stage.} -640 225 0 0 0.35 0.35 {}
T {D=S=VTUNE_DAC, G=inter-stage RF, B=0. V_DAC emulates an external 0-3.3V DAC.} -640 255 0 0 0.27 0.27 {}
T {Nominal target: VCO 1.200-1.240GHz; Doubled RF 2.400-2.480GHz.} -640 -270 0 0 0.28 0.28 {}
T {A single-ended stage output is also 1.2GHz. An explicit divide-by-2 is required for 600MHz feedback.} -640 -235 0 0 0.25 0.25 {}
T {VCO_BIAS sets the center frequency; VTUNE_DC is the DAC control voltage.} -640 740 0 0 0.28 0.28 {}
T {New MOSCAPs: W=0.88um, L=0.28um, nf=1, m=1. Original stage devices and receiver values are preserved.} -640 775 0 0 0.25 0.25 {}
T {Stage 1 + MOSCAP} -550 305 0 0 0.25 0.25 {}
T {Stage 1 - MOSCAP} -550 505 0 0 0.25 0.25 {}
T {Stage 2 + MOSCAP} -110 305 0 0 0.25 0.25 {}
T {Stage 2 - MOSCAP} -110 505 0 0 0.25 0.25 {}
T {Stage 3 + MOSCAP} 350 305 0 0 0.25 0.25 {}
T {Stage 3 - MOSCAP} 350 505 0 0 0.25 0.25 {}
T {Stage 4 + MOSCAP} 790 305 0 0 0.25 0.25 {}
T {Stage 4 - MOSCAP} 790 505 0 0 0.25 0.25 {}
N 1040 -70 1070 -70 {lab=#net1}
N 1070 -180 1070 -70 {lab=#net1}
N -270 -180 1070 -180 {lab=#net1}
N -270 -180 -270 -70 {lab=#net1}
N -300 -70 -270 -70 {lab=#net1}
N 140 -70 180 -70 {lab=#net1}
N 174.134026936207 -180 174.134026936207 -70 {lab=#net1}
N 600 -70 630 -70 {lab=#net1}
N 630 -180 630 -70 {lab=#net1}
N 1040 70 1070 70 {lab=0}
N 1070 70 1070 170 {lab=0}
N 170 170 1070 170 {lab=0}
N 170 70 170 170 {lab=0}
N 140 70 170 70 {lab=0}
N 600 70 630 70 {lab=0}
N 630 70 630 170 {lab=0}
N -270 170 170 170 {lab=0}
N -270 70 -270 170 {lab=0}
N -300 70 -270 70 {lab=0}
N -770 -180 -770 -30 {lab=#net1}
N -770 -180 -270 -180 {lab=#net1}
N -770 170 -270 170 {lab=0}
N -770 30 -770 170 {lab=0}
N 1900 -30 1940 -30 {lab=#net2}
N 1940 -180 1940 -30 {lab=#net2}
N 1900 30 1940 30 {lab=0}
N 1940 30 1940 170 {lab=0}
N 1070 170 1940 170 {lab=0}
N 1540 -180 1540 20 {lab=#net2}
N 1540 -180 1940 -180 {lab=#net2}
N 1540 80 1540 170 {lab=0}
N 1900 0 1970 0 {lab=#net3}
N 1940 -180 2310 -180 {lab=#net2}
N 2310 -180 2310 -30 {lab=#net2}
N 2270 -30 2310 -30 {lab=#net2}
N 2270 30 2310 30 {lab=0}
N 2310 30 2310 170 {lab=0}
N 1940 170 2310 170 {lab=0}
N 1460 -0 1470 -0 {lab=#net4}
N 1530 0 1600 0 {lab=#net5}
N 1760 50 1760 60 {lab=0}
N 1760 50 1860 50 {lab=0}
N 1860 50 1860 170 {lab=0}
N 1790 80 1930 80 {lab=#net3}
N 1930 0 1930 80 {lab=#net3}
N 1590 80 1730 80 {lab=#net5}
N 1590 0 1590 80 {lab=#net5}
N 2270 0 2400 -0 {lab=#net6}
N 2700 -30 2740 -30 {lab=#net2}
N 2740 -180 2740 -30 {lab=#net2}
N 2310 -180 2740 -180 {lab=#net2}
N 2310 170 2740 170 {lab=0}
N 2700 30 2740 30 {lab=0}
N 2740 30 2740 170 {lab=0}
N 1480 110 1500 110 {lab=0}
N 1500 110 1500 170 {lab=0}
N 1460 0 1460 80 {lab=#net4}
N 1460 140 1460 170 {lab=0}
N -550 380 -470 380 {lab=Out+1}
N -430 350 -320 350 {lab=VTUNE_DAC}
N -320 350 -320 410 {lab=VTUNE_DAC}
N -430 410 -320 410 {lab=VTUNE_DAC}
N -430 380 -375 380 {lab=0}
N -375 380 -375 460 {lab=0}
N -550 580 -470 580 {lab=Out-1}
N -430 550 -320 550 {lab=VTUNE_DAC}
N -320 550 -320 610 {lab=VTUNE_DAC}
N -430 610 -320 610 {lab=VTUNE_DAC}
N -430 580 -375 580 {lab=0}
N -375 580 -375 660 {lab=0}
N -110 380 -30 380 {lab=Out+2}
N 10 350 120 350 {lab=VTUNE_DAC}
N 120 350 120 410 {lab=VTUNE_DAC}
N 10 410 120 410 {lab=VTUNE_DAC}
N 10 380 65 380 {lab=0}
N 65 380 65 460 {lab=0}
N -110 580 -30 580 {lab=Out-2}
N 10 550 120 550 {lab=VTUNE_DAC}
N 120 550 120 610 {lab=VTUNE_DAC}
N 10 610 120 610 {lab=VTUNE_DAC}
N 10 580 65 580 {lab=0}
N 65 580 65 660 {lab=0}
N 350 380 430 380 {lab=Out+3}
N 470 350 580 350 {lab=VTUNE_DAC}
N 580 350 580 410 {lab=VTUNE_DAC}
N 470 410 580 410 {lab=VTUNE_DAC}
N 470 380 525 380 {lab=0}
N 525 380 525 460 {lab=0}
N 350 580 430 580 {lab=Out-3}
N 470 550 580 550 {lab=VTUNE_DAC}
N 580 550 580 610 {lab=VTUNE_DAC}
N 470 610 580 610 {lab=VTUNE_DAC}
N 470 580 525 580 {lab=0}
N 525 580 525 660 {lab=0}
N 790 380 870 380 {lab=Out+4}
N 910 350 1020 350 {lab=VTUNE_DAC}
N 1020 350 1020 410 {lab=VTUNE_DAC}
N 910 410 1020 410 {lab=VTUNE_DAC}
N 910 380 965 380 {lab=0}
N 965 380 965 460 {lab=0}
N 790 580 870 580 {lab=Out-4}
N 910 550 1020 550 {lab=VTUNE_DAC}
N 1020 550 1020 610 {lab=VTUNE_DAC}
N 910 610 1020 610 {lab=VTUNE_DAC}
N 910 580 965 580 {lab=0}
N 965 580 965 660 {lab=0}
N -770 280 -770 350 {lab=VTUNE_DAC}
N -770 410 -770 460 {lab=0}
N 1280 350 1460 350 {lab=0}
N 1460 170 1460 330 {lab=0}
N 1280 250 1570 250 {lab=#net2}
N 1570 -180 1570 250 {lab=#net2}
N 1280 270 1370 270 {lab=Prescaler_Clk}
N 1460 330 1460 350 {lab=0}
N 1280 330 1360 330 {lab=Tail_Bias}
C {Differential_Stage_DAC_Core.sym} -450 0 0 0 {name=x1}
C {Differential_Stage_DAC_Core.sym} -10 0 0 0 {name=x2}
C {Differential_Stage_DAC_Core.sym} 450 0 0 0 {name=x3}
C {Differential_Stage_DAC_Core.sym} 890 0 0 0 {name=x4}
C {lab_pin.sym} -300 -40 0 1 {name=p1 sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} -300 40 0 1 {name=p2 sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} 140 -40 0 1 {name=p3 sig_type=std_logic lab="Out+2"}
C {lab_pin.sym} 140 40 0 1 {name=p4 sig_type=std_logic lab="Out-2"}
C {lab_pin.sym} 600 -40 0 1 {name=p5 sig_type=std_logic lab="Out+3"}
C {lab_pin.sym} 600 40 0 1 {name=p6 sig_type=std_logic lab="Out-3"}
C {lab_pin.sym} 1040 -40 0 1 {name=p7 sig_type=std_logic lab="Out+4"}
C {lab_pin.sym} 1040 40 0 1 {name=p8 sig_type=std_logic lab="Out-4"}
C {vsource.sym} -770 0 0 0 {name=V1 value="'VCO_BIAS'" savecurrent=false}
C {gnd.sym} -270 170 0 0 {name=l1 lab=0}
C {lab_pin.sym} -160 50 0 0 {name=p9 sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} -160 30 0 0 {name=p10 sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} 300 50 0 0 {name=p11 sig_type=std_logic lab="Out+2"}
C {lab_pin.sym} 300 30 0 0 {name=p12 sig_type=std_logic lab="Out-2"}
C {lab_pin.sym} 740 30 0 0 {name=p13 sig_type=std_logic lab="Out-3"}
C {lab_pin.sym} 740 50 0 0 {name=p14 sig_type=std_logic lab="Out+3"}
C {lab_pin.sym} -600 -30 0 0 {name=p15 sig_type=std_logic lab="Out+3"}
C {lab_pin.sym} -160 -30 0 0 {name=p16 sig_type=std_logic lab="Out+4"}
C {lab_pin.sym} -600 30 0 0 {name=p17 sig_type=std_logic lab="Out+4"}
C {lab_pin.sym} -600 50 0 0 {name=p18 sig_type=std_logic lab="Out-4"}
C {lab_pin.sym} -160 -50 0 0 {name=p19 sig_type=std_logic lab="Out-4"}
C {lab_pin.sym} -600 -50 0 0 {name=p20 sig_type=std_logic lab="Out-3"}
C {lab_pin.sym} 300 -50 0 0 {name=p21 sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} 300 -30 0 0 {name=p22 sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} 740 -50 0 0 {name=p23 sig_type=std_logic lab="Out+2"}
C {lab_pin.sym} 740 -30 0 0 {name=p24 sig_type=std_logic lab="Out-2"}
C {simulator_commands.sym} -720 -350 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice res_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim

* Nominal schematic calibration only. All original oscillator sizes are retained.
.param VCO_BIAS=1.45 VTUNE_DC=0.317244194
.param MOSCAP_W=0.88u MOSCAP_L=0.28u
.temp 27
.options reltol=1e-4 abstol=1e-12 vntol=1e-6
CTEST_DOUBLE Double_Out 0 3f
.ic V(Out+1)=0.707 V(Out-1)=0.687
.ic V(Out+2)=0.694 V(Out-2)=0.700
.ic V(Out+3)=0.702 V(Out-3)=0.692
.ic V(Out+4)=0.696 V(Out-4)=0.698

.control
set noaskquit
set num_threads=1
set numdgt=12
set wr_singlescale
set wr_vecnames
tran 2p 120n 0 2p uic
set plainlet
let o1p=v(out+1)
let o1n=v(out-1)
let o2p=v(out+2)
let o2n=v(out-2)
let o3p=v(out+3)
let o3n=v(out-3)
let o4p=v(out+4)
let o4n=v(out-4)
let rf_out=v(double_out)
unset plainlet
let vd1=o1p-o1n
let vd2=o2p-o2n
let vd3=o3p-o3n
let vd4=o4p-o4n
let cm1=(o1p+o1n)/2
let p_vco=-@v1[dc]*i(V1)
let p_buffers=-@v2[dc]*i(V2)
let p_dac=-@v_dac[dc]*i(V_DAC)
let p_total=p_vco+p_buffers+p_dac
meas tran vco_swing PP vd1 FROM=85n TO=120n
meas tran rf_swing PP rf_out FROM=85n TO=120n
meas tran rf_mean AVG rf_out FROM=85n TO=120n
meas tran plus_mean AVG o1p FROM=85n TO=120n
let rf_ac=rf_out-rf_mean
let plus_ac=o1p-plus_mean
meas tran span_vco TRIG vd1 VAL=0 RISE=1 TD=85n TARG vd1 VAL=0 RISE=11 TD=85n
meas tran span_single TRIG plus_ac VAL=0 RISE=1 TD=85n TARG plus_ac VAL=0 RISE=11 TD=85n
meas tran span_rf TRIG rf_ac VAL=0 RISE=1 TD=85n TARG rf_ac VAL=0 RISE=11 TD=85n
let vco_mhz=10/span_vco/1e6
let single_ended_mhz=10/span_single/1e6
let rf_mhz=10/span_rf/1e6
let doubler_ratio=span_vco/span_rf
print vco_mhz single_ended_mhz rf_mhz doubler_ratio
meas tran vco_power AVG p_vco FROM=85n TO=120n
meas tran total_power AVG p_total FROM=85n TO=120n
plot o1p o1n xlimit 115n 120n
plot vd1 vd2 vd3 vd4 xlimit 115n 120n
plot rf_out xlimit 115n 120n
wrdata dac_moscap_waveforms.dat o1p o1n vd1 vd2 vd3 vd4 rf_out cm1 p_vco p_buffers p_dac p_total
write dac_moscap_vco.raw o1p o1n vd1 vd2 vd3 vd4 rf_out cm1 p_vco p_buffers p_dac p_total
.endc
"}
C {Schottky_Doubler_DAC_Ref.sym} 1310 0 0 0 {name=x5}
C {lab_pin.sym} 1160 -20 0 0 {name=p25 sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} 1160 20 0 0 {name=p26 sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} 2700 0 0 1 {name=p27 sig_type=std_logic lab="Double_Out"}
C {Freq_Buffer_Inverter_DAC_Ref.sym} 1750 0 0 0 {name=x6}
C {vsource.sym} 1540 50 0 0 {name=V2 value=3.3 savecurrent=false}
C {Freq_Buffer_Inverter_DAC_Ref.sym} 2120 0 0 0 {name=x7}
C {symbols/cap_mim_2f0fF.sym} 1500 0 1 0 {name=C1
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {Freq_Buffer_Inverter_DAC_Ref.sym} 2550 0 0 0 {name=x8}
C {symbols/ppolyf_u_1k.sym} 1460 110 0 1 {name=R3
W=0.8e-6
L=30e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {symbols/ppolyf_u_1k.sym} 1760 80 1 0 {name=R1
W=0.8e-6
L=30e-6
model=ppolyf_u_1k
spiceprefix=X
m=1}
C {lab_pin.sym} -550 380 0 0 {name=G_MC1P sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} -320 350 0 1 {name=T_MC1P sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} -375 460 0 0 {name=B_MC1P lab=0}
C {symbols/nfet_03v3.sym} -450 380 0 0 {name=MC1P
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} -550 580 0 0 {name=G_MC1N sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} -320 550 0 1 {name=T_MC1N sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} -375 660 0 0 {name=B_MC1N lab=0}
C {symbols/nfet_03v3.sym} -450 580 0 0 {name=MC1N
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} -110 380 0 0 {name=G_MC2P sig_type=std_logic lab="Out+2"}
C {lab_pin.sym} 120 350 0 1 {name=T_MC2P sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 65 460 0 0 {name=B_MC2P lab=0}
C {symbols/nfet_03v3.sym} -10 380 0 0 {name=MC2P
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} -110 580 0 0 {name=G_MC2N sig_type=std_logic lab="Out-2"}
C {lab_pin.sym} 120 550 0 1 {name=T_MC2N sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 65 660 0 0 {name=B_MC2N lab=0}
C {symbols/nfet_03v3.sym} -10 580 0 0 {name=MC2N
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 350 380 0 0 {name=G_MC3P sig_type=std_logic lab="Out+3"}
C {lab_pin.sym} 580 350 0 1 {name=T_MC3P sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 525 460 0 0 {name=B_MC3P lab=0}
C {symbols/nfet_03v3.sym} 450 380 0 0 {name=MC3P
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 350 580 0 0 {name=G_MC3N sig_type=std_logic lab="Out-3"}
C {lab_pin.sym} 580 550 0 1 {name=T_MC3N sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 525 660 0 0 {name=B_MC3N lab=0}
C {symbols/nfet_03v3.sym} 450 580 0 0 {name=MC3N
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 790 380 0 0 {name=G_MC4P sig_type=std_logic lab="Out+4"}
C {lab_pin.sym} 1020 350 0 1 {name=T_MC4P sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 965 460 0 0 {name=B_MC4P lab=0}
C {symbols/nfet_03v3.sym} 890 380 0 0 {name=MC4P
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} 790 580 0 0 {name=G_MC4N sig_type=std_logic lab="Out-4"}
C {lab_pin.sym} 1020 550 0 1 {name=T_MC4N sig_type=std_logic lab=VTUNE_DAC}
C {gnd.sym} 965 660 0 0 {name=B_MC4N lab=0}
C {symbols/nfet_03v3.sym} 890 580 0 0 {name=MC4N
L=MOSCAP_L
W=MOSCAP_W
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=nfet_03v3
spiceprefix=X
}
C {lab_pin.sym} -770 280 0 0 {name=VTUNE_PORT sig_type=std_logic lab=VTUNE_DAC}
C {vsource.sym} -770 380 0 0 {name=V_DAC value="'VTUNE_DC'" savecurrent=false}
C {gnd.sym} -770 460 0 0 {name=GND_DAC lab=0}
C {lab_pin.sym} 1280 290 0 1 {name=p28 sig_type=std_logic lab="Out+1"}
C {lab_pin.sym} 1280 310 0 1 {name=p29 sig_type=std_logic lab="Out-1"}
C {lab_pin.sym} 1370 270 0 1 {name=p30 sig_type=std_logic lab="Prescaler_Clk"}
C {Differential_Buffer.sym} 1130 300 0 0 {name=x9}
C {lab_pin.sym} 1360 330 0 1 {name=p31 sig_type=std_logic lab="Tail_Bias"}
