v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 60 -60 60 {lab=180_Deg_In}
N -110 -80 -60 -80 {lab=0_Deg_In}
N -0 -80 40 -80 {lab=180_Deg_In}
N 40 -80 40 60 {lab=180_Deg_In}
N 0 60 40 60 {lab=180_Deg_In}
N 40 0 160 0 {lab=180_Deg_In}
C {symbols/sc_diode.sym} -30 -80 3 1 {name=D1
model=sc_diode
r_w=1u
r_l=1u
m=1}
C {symbols/sc_diode.sym} -30 60 3 1 {name=D2
model=sc_diode
r_w=1u
r_l=1u
m=1}
C {iopin.sym} -110 -80 0 1 {name=p1 lab=0_Deg_In}
C {iopin.sym} -110 60 0 1 {name=p2 lab=180_Deg_In}
C {iopin.sym} 160 0 0 0 {name=p3 lab=Doubler_Out}
