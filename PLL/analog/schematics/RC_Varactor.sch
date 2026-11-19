v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 170 -20 170 60 {lab=#net1}
N 170 -110 170 -80 {lab=RC_Loop_Filter}
N -270 -110 170 -110 {lab=RC_Loop_Filter}
N -90 -110 -90 60 {lab=RC_Loop_Filter}
N -90 120 -90 170 {lab=vss}
N -90 170 170 170 {lab=vss}
N 170 120 170 170 {lab=vss}
N -270 170 -90 170 {lab=vss}
N 110 -50 150 -50 {lab=vss}
N 110 -50 110 170 {lab=vss}
C {symbols/cap_nmos_03v3.sym} -90 90 0 0 {name=C1
W=18e-6
L=18e-6
model=cap_nmos_03v3
spiceprefix=X
m=1}
C {symbols/cap_nmos_03v3.sym} 170 90 0 0 {name=C2
W=190e-6
L=190e-6
model=cap_nmos_03v3
spiceprefix=X
m=1}
C {symbols/ppolyf_u_2k.sym} 170 -50 0 0 {name=R1
W=1e-6
L=20.65e-6
model=ppolyf_u_2k
spiceprefix=X
m=1}
C {iopin.sym} -270 -110 0 1 {name=p1 lab=RC_Loop_Filter}
C {iopin.sym} -270 170 0 1 {name=p2 lab=vss}
