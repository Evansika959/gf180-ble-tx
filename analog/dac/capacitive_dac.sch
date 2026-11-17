v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -360 -60 -360 -50 {lab=Vout}
N -360 -60 600 -60 {lab=Vout}
N 600 -60 600 -50 {lab=Vout}
N 370 -60 370 -50 {lab=Vout}
N 250 -60 250 -50 {lab=Vout}
N 130 -60 130 -50 {lab=Vout}
N 0 -60 0 -50 {lab=Vout}
N -110 -60 -110 -50 {lab=Vout}
N -240 -60 -240 -50 {lab=Vout}
N 480 -60 480 -50 {lab=Vout}
N -430 350 -390 350 {lab=#net1}
N -430 350 -430 355 {lab=#net1}
N -360 350 -360 440 {lab=#net2}
N -360 10 -360 50 {lab=B0}
N -310 350 -270 350 {lab=#net3}
N -310 350 -310 355 {lab=#net3}
N -240 350 -240 440 {lab=#net4}
N -240 10 -240 50 {lab=B1}
N -180 350 -140 350 {lab=#net5}
N -180 350 -180 355 {lab=#net5}
N -110 350 -110 440 {lab=#net6}
N -110 10 -110 50 {lab=B2}
N -70 350 -30 350 {lab=#net7}
N -70 350 -70 355 {lab=#net7}
N 0 350 0 440 {lab=#net8}
N 0 10 0 50 {lab=B3}
N 60 350 100 350 {lab=#net9}
N 60 350 60 355 {lab=#net9}
N 130 350 130 440 {lab=#net10}
N 130 10 130 50 {lab=B4}
N 180 350 220 350 {lab=#net11}
N 180 350 180 355 {lab=#net11}
N 250 350 250 440 {lab=#net12}
N 250 10 250 50 {lab=B5}
N 300 350 340 350 {lab=#net13}
N 300 350 300 355 {lab=#net13}
N 370 350 370 440 {lab=#net14}
N 370 10 370 50 {lab=B6}
N 410 350 450 350 {lab=#net15}
N 410 350 410 355 {lab=#net15}
N 480 350 480 440 {lab=#net16}
N 480 10 480 50 {lab=B7}
C {symbols/cap_mim_2f0fF.sym} -110 -20 0 0 {name=C1
W=10e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} -240 -20 0 0 {name=C2
W=5e-6
L=10e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 0 -20 0 0 {name=C3
W=10e-6
L=20e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 130 -20 0 0 {name=C4
W=20e-6
L=20e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 250 -20 0 0 {name=C5
W=20e-6
L=40e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} 370 -20 0 0 {name=C6
W=40e-6
L=40e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {symbols/cap_mim_2f0fF.sym} -360 -20 0 0 {name=C7
W=5e-6
L=5e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {vsource.sym} -430 385 0 0 {name=V2 value="PULSE(0 3.3 0 1n 1n 125n 250n)" savecurrent=false}
C {gnd.sym} -430 415 0 0 {name=l2 lab=0}
C {capa.sym} 600 -20 0 0 {name=C8
m=1
value=20f
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 600 10 0 0 {name=l1 lab=0}
C {code_shown.sym} 810 120 0 0 {name=s2 only_toplevel=false value="

.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice cap_mim

.control
tran 0.05n 17u

plot v(b0) v(b1)+4 v(b2)+8 
plot v(vout)

.endc
"}
C {lab_wire.sym} 525 -60 0 0 {name=p1 sig_type=std_logic lab=Vout}
C {symbols/cap_mim_2f0fF.sym} 480 -20 0 0 {name=C9
W=40e-6
L=80e-6
model=cap_mim_2f0fF
spiceprefix=X
m=1}
C {INV.sym} -360 200 3 0 {name=x1}
C {vsource.sym} -360 470 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} -360 500 0 0 {name=l3 lab=0}
C {gnd.sym} -330 350 0 0 {name=l4 lab=0}
C {lab_wire.sym} -360 30 0 0 {name=p3 sig_type=std_logic lab=B0}
C {vsource.sym} -310 385 0 0 {name=V3 value="PULSE(0 3.3 0 1n 1n 250n 500n)" savecurrent=false}
C {gnd.sym} -310 415 0 0 {name=l5 lab=0}
C {INV.sym} -240 200 3 0 {name=x2}
C {vsource.sym} -240 470 0 0 {name=V4 value=3.3 savecurrent=false}
C {gnd.sym} -240 500 0 0 {name=l6 lab=0}
C {gnd.sym} -210 350 0 0 {name=l7 lab=0}
C {lab_wire.sym} -240 30 0 0 {name=p4 sig_type=std_logic lab=B1}
C {vsource.sym} -180 385 0 0 {name=V5 value="PULSE(0 3.3 0 1n 1n 500n 1u)" savecurrent=false}
C {gnd.sym} -180 415 0 0 {name=l8 lab=0}
C {INV.sym} -110 200 3 0 {name=x3}
C {vsource.sym} -110 470 0 0 {name=V6 value=3.3 savecurrent=false}
C {gnd.sym} -110 500 0 0 {name=l9 lab=0}
C {gnd.sym} -80 350 0 0 {name=l10 lab=0}
C {vsource.sym} -70 385 0 0 {name=V7 value="PULSE(0 3.3 0 1n 1n 1u 2u)" savecurrent=false}
C {gnd.sym} -70 415 0 0 {name=l11 lab=0}
C {INV.sym} 0 200 3 0 {name=x4}
C {vsource.sym} 0 470 0 0 {name=V8 value=3.3 savecurrent=false}
C {gnd.sym} 0 500 0 0 {name=l12 lab=0}
C {gnd.sym} 30 350 0 0 {name=l13 lab=0}
C {lab_wire.sym} 0 30 0 0 {name=p6 sig_type=std_logic lab=B3}
C {vsource.sym} 60 385 0 0 {name=V9 value="PULSE(0 3.3 0 1n 1n 2u 4u)" savecurrent=false}
C {gnd.sym} 60 415 0 0 {name=l14 lab=0}
C {INV.sym} 130 200 3 0 {name=x5}
C {vsource.sym} 130 470 0 0 {name=V10 value=3.3 savecurrent=false}
C {gnd.sym} 130 500 0 0 {name=l15 lab=0}
C {gnd.sym} 160 350 0 0 {name=l16 lab=0}
C {lab_wire.sym} 130 30 0 0 {name=p7 sig_type=std_logic lab=B4}
C {vsource.sym} 180 385 0 0 {name=V11 value="PULSE(0 3.3 0 1n 1n 4u 8u)" savecurrent=false}
C {gnd.sym} 180 415 0 0 {name=l17 lab=0}
C {INV.sym} 250 200 3 0 {name=x6}
C {vsource.sym} 250 470 0 0 {name=V12 value=3.3 savecurrent=false}
C {gnd.sym} 250 500 0 0 {name=l18 lab=0}
C {gnd.sym} 280 350 0 0 {name=l19 lab=0}
C {lab_wire.sym} 250 30 0 0 {name=p8 sig_type=std_logic lab=B5}
C {vsource.sym} 300 385 0 0 {name=V13 value="PULSE(0 3.3 0 1n 1n 8u 16u)" savecurrent=false}
C {gnd.sym} 300 415 0 0 {name=l20 lab=0}
C {INV.sym} 370 200 3 0 {name=x7}
C {vsource.sym} 370 470 0 0 {name=V14 value=3.3 savecurrent=false}
C {gnd.sym} 370 500 0 0 {name=l21 lab=0}
C {gnd.sym} 400 350 0 0 {name=l22 lab=0}
C {lab_wire.sym} 370 30 0 0 {name=p9 sig_type=std_logic lab=B6}
C {vsource.sym} 410 385 0 0 {name=V15 value="PULSE(0 3.3 0 1n 1n 16u 32u)" savecurrent=false}
C {gnd.sym} 410 415 0 0 {name=l23 lab=0}
C {INV.sym} 480 200 3 0 {name=x8}
C {vsource.sym} 480 470 0 0 {name=V16 value=3.3 savecurrent=false}
C {gnd.sym} 480 500 0 0 {name=l24 lab=0}
C {gnd.sym} 510 350 0 0 {name=l25 lab=0}
C {lab_wire.sym} 480 30 0 0 {name=p10 sig_type=std_logic lab=B7}
C {lab_wire.sym} -110 30 0 0 {name=p2 sig_type=std_logic lab=B2}
