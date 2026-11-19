v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 -30 10 30 {lab=inv_out}
N 10 -60 30 -60 {lab=#net1}
N 30 -130 30 -60 {lab=#net1}
N 10 -130 30 -130 {lab=#net1}
N 10 -130 10 -90 {lab=#net1}
N 10 60 30 60 {lab=#net2}
N 30 60 30 140 {lab=#net2}
N 10 140 30 140 {lab=#net2}
N 10 90 10 140 {lab=#net2}
N -60 60 -30 60 {lab=inv_in}
N -60 -60 -60 60 {lab=inv_in}
N -60 -60 -30 -60 {lab=inv_in}
N 10 -0 80 0 {lab=inv_out}
N -110 -0 -60 0 {lab=inv_in}
C {symbols/pfet_03v3.sym} -10 -60 0 0 {name=M1
L=0.28u
W=2u
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
C {symbols/nfet_03v3.sym} -10 60 0 0 {name=M2
L=0.28u
W=1u
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
C {iopin.sym} -110 0 0 1 {name=p1 lab=inv_in}
C {iopin.sym} 80 0 0 0 {name=p2 lab=inv_out}
C {iopin.sym} 10 -130 0 1 {name=p3 lab=3v3}
C {iopin.sym} 10 140 0 1 {name=p4 lab=vss}
