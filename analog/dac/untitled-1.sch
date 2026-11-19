v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -20 30 -20 60 {lab=#net1}
N -20 60 140 60 {lab=#net1}
N 140 30 140 60 {lab=#net1}
N 60 60 60 150 {lab=#net1}
N 60 210 60 240 {lab=0}
N 110 -0 140 -0 {lab=0}
N 110 -0 110 220 {lab=0}
N 60 220 110 220 {lab=0}
N 60 180 90 180 {lab=0}
N 90 180 90 220 {lab=0}
N -20 -0 110 -0 {lab=0}
N 140 -90 140 -30 {lab=#net2}
N -20 -90 -20 -30 {lab=#net3}
N -110 -0 -60 -0 {lab=D}
N -30 180 20 180 {lab=vb}
N 180 -0 240 -0 {lab=Db}
N -20 -120 -20 -90 {lab=#net3}
N 140 -120 140 -90 {lab=#net2}
N -110 -200 -20 -200 {lab=voutp}
N -20 -200 -20 -180 {lab=voutp}
N 140 -200 140 -180 {lab=voutn}
N 140 -200 250 -200 {lab=voutn}
N 250 -200 250 -190 {lab=voutn}
C {symbols/nfet_03v3.sym} -40 0 0 0 {name=M1
L=0.28u
W=0.22u
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
C {symbols/nfet_03v3.sym} 160 0 2 0 {name=M2
L=0.28u
W=0.22u
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
C {symbols/nfet_03v3.sym} 40 180 0 0 {name=M7
L=0.28u
W=0.22u
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
C {gnd.sym} 60 240 0 0 {name=l1 lab=0}
C {vsource.sym} -110 30 0 0 {name=V1 value="PULSE(0 3.3 0 1n 1n 500n 1u)" savecurrent=false}
C {gnd.sym} -110 60 0 0 {name=l2 lab=0}
C {vsource.sym} -30 210 0 0 {name=V2 value=1.2 savecurrent=false}
C {gnd.sym} -30 240 0 0 {name=l3 lab=0}
C {vsource.sym} 240 30 0 0 {name=V3 value="PULSE(3.3 0 0 1n 1n 500n 1u)" savecurrent=false}
C {gnd.sym} 240 60 0 0 {name=l4 lab=0}
C {res.sym} -20 -150 0 0 {name=R1
value=10k
footprint=1206
device=resistor
m=1}
C {res.sym} 140 -150 0 0 {name=R2
value=10k
footprint=1206
device=resistor
m=1}
C {vsource.sym} -110 -170 0 0 {name=V4 value=3.3 savecurrent=false}
C {gnd.sym} -110 -140 0 0 {name=l5 lab=0}
C {vsource.sym} 250 -160 0 0 {name=V5 value=3.3 savecurrent=false}
C {gnd.sym} 250 -130 0 0 {name=l6 lab=0}
C {lab_wire.sym} -60 -200 0 0 {name=p1 sig_type=std_logic lab=voutp}
C {lab_wire.sym} 200 -200 0 0 {name=p2 sig_type=std_logic lab=voutn}
C {lab_wire.sym} -80 0 0 0 {name=p3 sig_type=std_logic lab=D}
C {lab_wire.sym} 210 0 0 0 {name=p4 sig_type=std_logic lab=Db}
C {lab_wire.sym} 0 180 0 0 {name=p5 sig_type=std_logic lab=vb}
C {code_shown.sym} 480 -280 0 0 {name=s1 only_toplevel=false value="

.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.control 
tran 0.1n 1u

plot v(vout)

.endc

"}
