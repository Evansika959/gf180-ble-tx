v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -220 -300 -220 -290 {lab=#net1}
N 180 -300 180 -290 {lab=#net1}
N 40 -300 40 -290 {lab=#net1}
N -90 -300 -90 -290 {lab=#net1}
N -310 70 -250 70 {lab=B0}
N -220 70 -220 100 {lab=#net2}
N -180 70 -120 70 {lab=B1}
N -90 70 -90 100 {lab=#net3}
N -50 70 10 70 {lab=B2}
N 40 70 40 100 {lab=#net4}
N 90 70 150 70 {lab=B3}
N 180 70 180 100 {lab=#net5}
N -220 -300 240 -300 {lab=#net1}
N 240 -300 300 -300 {lab=#net1}
N 380 70 440 70 {lab=B4}
N 470 70 470 100 {lab=#net6}
N 510 70 570 70 {lab=B5}
N 600 70 600 100 {lab=#net7}
N 640 70 700 70 {lab=B6}
N 730 70 730 100 {lab=#net8}
N 780 70 840 70 {lab=B7}
N 870 70 870 100 {lab=#net9}
N 360 -300 1030 -300 {lab=Vout}
N 870 -300 870 -290 {lab=Vout}
N 730 -300 730 -290 {lab=Vout}
N 600 -300 600 -290 {lab=Vout}
N 470 -300 470 -290 {lab=Vout}
C {symbols/cap_mim_2f0fF.sym} -220 -260 0 0 {name=C1
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {vsource.sym} -310 100 0 0 {name=V1 value="PULSE(0 3.3 0 1n 1n 1u 2u)" savecurrent=false}
C {gnd.sym} -310 130 0 0 {name=l1 lab=0}
C {symbols/cap_mim_2f0fF.sym} -90 -260 0 0 {name=C2
W=5e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 40 -260 0 0 {name=C3
W=10e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 180 -260 0 0 {name=C4
W=10e-6
L=20e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {INV.sym} -220 -80 3 0 {name=x1}
C {vsource.sym} -220 130 0 0 {name=V2 value=3.3 savecurrent=false}
C {gnd.sym} -220 160 0 0 {name=l2 lab=0}
C {gnd.sym} -190 70 0 0 {name=l3 lab=0}
C {vsource.sym} -180 100 0 0 {name=V3 value="PULSE(0 3.3 0 1n 1n 2u 4u)" savecurrent=false}
C {gnd.sym} -180 130 0 0 {name=l4 lab=0}
C {INV.sym} -90 -80 3 0 {name=x2}
C {vsource.sym} -90 130 0 0 {name=V4 value=3.3 savecurrent=false}
C {gnd.sym} -90 160 0 0 {name=l5 lab=0}
C {gnd.sym} -60 70 0 0 {name=l6 lab=0}
C {vsource.sym} -50 100 0 0 {name=V5 value="PULSE(0 3.3 0 1n 1n 4u 8u)" savecurrent=false}
C {gnd.sym} -50 130 0 0 {name=l7 lab=0}
C {INV.sym} 40 -80 3 0 {name=x3}
C {vsource.sym} 40 130 0 0 {name=V6 value=3.3 savecurrent=false}
C {gnd.sym} 40 160 0 0 {name=l8 lab=0}
C {gnd.sym} 70 70 0 0 {name=l9 lab=0}
C {vsource.sym} 90 100 0 0 {name=V7 value="PULSE(0 3.3 0 1n 1n 8u 16u)" savecurrent=false}
C {gnd.sym} 90 130 0 0 {name=l10 lab=0}
C {INV.sym} 180 -80 3 0 {name=x4}
C {vsource.sym} 180 130 0 0 {name=V8 value=3.3 savecurrent=false}
C {gnd.sym} 180 160 0 0 {name=l11 lab=0}
C {gnd.sym} 210 70 0 0 {name=l12 lab=0}
C {gnd.sym} 1090 -300 0 0 {name=l13 lab=0}
C {code_shown.sym} 1180 -660 0 0 {name=s1 only_toplevel=false value="

.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim

.control
tran 0.5n 512u

plot v(vout) 
.endc
"}
C {lab_wire.sym} -270 70 0 0 {name=p1 sig_type=std_logic lab=B0}
C {lab_wire.sym} -150 70 0 0 {name=p2 sig_type=std_logic lab=B1}
C {lab_wire.sym} -10 70 0 0 {name=p3 sig_type=std_logic lab=B2}
C {lab_wire.sym} 130 70 0 0 {name=p4 sig_type=std_logic lab=B3}
C {lab_wire.sym} 1020 -300 0 0 {name=p5 sig_type=std_logic lab=Vout}
C {capa.sym} 1060 -300 1 0 {name=C5
m=1
value=20f
footprint=1206
device="ceramic capacitor"}
C {symbols/cap_mim_2f0fF.sym} 330 -300 1 0 {name=C6
W=1e-6
L=1e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 470 -260 0 0 {name=C7
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {vsource.sym} 380 100 0 0 {name=V9 value="PULSE(0 3.3 0 1n 1n 16u 32u)" savecurrent=false}
C {gnd.sym} 380 130 0 0 {name=l14 lab=0}
C {symbols/cap_mim_2f0fF.sym} 600 -260 0 0 {name=C8
W=5e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 730 -260 0 0 {name=C9
W=10e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 870 -260 0 0 {name=C10
W=10e-6
L=20e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {INV.sym} 470 -80 3 0 {name=x5}
C {vsource.sym} 470 130 0 0 {name=V10 value=3.3 savecurrent=false}
C {gnd.sym} 470 160 0 0 {name=l15 lab=0}
C {gnd.sym} 500 70 0 0 {name=l16 lab=0}
C {vsource.sym} 510 100 0 0 {name=V11 value="PULSE(0 3.3 0 1n 1n 32u 64u)" savecurrent=false}
C {gnd.sym} 510 130 0 0 {name=l17 lab=0}
C {INV.sym} 600 -80 3 0 {name=x6}
C {vsource.sym} 600 130 0 0 {name=V12 value=3.3 savecurrent=false}
C {gnd.sym} 600 160 0 0 {name=l18 lab=0}
C {gnd.sym} 630 70 0 0 {name=l19 lab=0}
C {vsource.sym} 640 100 0 0 {name=V13 value="PULSE(0 3.3 0 1n 1n 64u 128u)" savecurrent=false}
C {gnd.sym} 640 130 0 0 {name=l20 lab=0}
C {INV.sym} 730 -80 3 0 {name=x7}
C {vsource.sym} 730 130 0 0 {name=V14 value=3.3 savecurrent=false}
C {gnd.sym} 730 160 0 0 {name=l21 lab=0}
C {gnd.sym} 760 70 0 0 {name=l22 lab=0}
C {vsource.sym} 780 100 0 0 {name=V15 value="PULSE(0 3.3 0 1n 1n 128u 256u)" savecurrent=false}
C {gnd.sym} 780 130 0 0 {name=l23 lab=0}
C {INV.sym} 870 -80 3 0 {name=x8}
C {vsource.sym} 870 130 0 0 {name=V16 value=3.3 savecurrent=false}
C {gnd.sym} 870 160 0 0 {name=l24 lab=0}
C {gnd.sym} 900 70 0 0 {name=l25 lab=0}
C {lab_wire.sym} 420 70 0 0 {name=p6 sig_type=std_logic lab=B4}
C {lab_wire.sym} 540 70 0 0 {name=p7 sig_type=std_logic lab=B5}
C {lab_wire.sym} 680 70 0 0 {name=p8 sig_type=std_logic lab=B6}
C {lab_wire.sym} 820 70 0 0 {name=p9 sig_type=std_logic lab=B7}
