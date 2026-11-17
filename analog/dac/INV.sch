v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 20 -50 20 -20 {lab=VOUT}
N 20 40 20 60 {lab=GND}
N -20 -80 -20 10 {lab=VIN}
N -60 -40 -20 -40 {lab=VIN}
N 20 -40 60 -40 {lab=VOUT}
N 20 -80 40 -80 {lab=VOUT}
N 40 -130 40 -80 {lab=VOUT}
N 20 10 50 10 {lab=GND}
N 50 10 50 60 {lab=GND}
N 20 60 50 60 {lab=GND}
N 20 -140 20 -110 {lab=VOUT}
N 20 -140 40 -140 {lab=VOUT}
N 40 -140 40 -130 {lab=VOUT}
C {symbols/nfet_03v3.sym} 0 10 0 0 {name=M1
L=1u
W=1.5u
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
C {symbols/pfet_03v3.sym} 0 -80 0 0 {name=M2
L=1u
W=3u
nf=1
m=1
ad="'int((nf+1)/2) * W/nf * 0.18u'"
pd="'2*int((nf+1)/2) * (W/nf + 0.18u)'"
as="'int((nf+2)/2) * W/nf * 0.18u'"
ps="'2*int((nf+2)/2) * (W/nf + 0.18u)'"
nrd="'0.18u / W'" nrs="'0.18u / W'"
sa=0 sb=0 sd=0
model=pfet_03v3
spiceprefix=X
}
C {iopin.sym} 60 -40 0 0 {name=p1 lab=VOUT}
C {iopin.sym} -60 -40 2 0 {name=p2 lab=VIN}
C {iopin.sym} 20 60 1 0 {name=p3 lab=GND}
C {iopin.sym} 20 -140 3 0 {name=p4 lab=VDD}
