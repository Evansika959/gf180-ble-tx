v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -110 -210 40 -210 {lab=3v3}
N -200 -120 -150 -120 {lab=in1}
N -190 -120 -190 50 {lab=in1}
N 0 -90 -0 -30 {lab=#net1}
N 0 -0 40 -0 {lab=3v3}
N 40 -120 40 -0 {lab=3v3}
N -0 -120 40 -120 {lab=3v3}
N 40 -210 40 -120 {lab=3v3}
N -150 -120 -40 -120 {lab=in1}
N -190 50 -190 170 {lab=in1}
N -190 170 -150 170 {lab=in1}
N -110 60 -110 140 {lab=#net2}
N -110 60 110 60 {lab=#net2}
N 110 60 110 140 {lab=#net2}
N -110 170 110 170 {lab=vss}
N -80 280 0 280 {lab=vss}
N -0 170 0 280 {lab=vss}
N -110 200 -110 260 {lab=vss}
N -110 260 -0 260 {lab=vss}
N 0 260 110 260 {lab=vss}
N 110 200 110 260 {lab=vss}
N 150 170 160 170 {lab=in2}
N -200 0 -40 -0 {lab=in2}
N 0 30 -0 60 {lab=#net2}
N -80 0 -80 40 {lab=in2}
N -80 40 180 40 {lab=in2}
N 180 40 180 170 {lab=in2}
N 160 170 180 170 {lab=in2}
N -0 -210 0 -150 {lab=3v3}
N 110 260 300 260 {lab=vss}
N 300 210 300 260 {lab=vss}
N 40 -210 300 -210 {lab=3v3}
N 300 -210 300 -150 {lab=3v3}
N 210 -120 260 -120 {lab=#net2}
N 210 -120 210 180 {lab=#net2}
N 210 180 260 180 {lab=#net2}
N 300 180 330 180 {lab=vss}
N 330 180 330 260 {lab=vss}
N 300 260 330 260 {lab=vss}
N 300 -120 330 -120 {lab=3v3}
N 330 -210 330 -120 {lab=3v3}
N 300 -210 330 -210 {lab=3v3}
N 300 -90 300 150 {lab=out}
N 300 -0 320 -0 {lab=out}
N 110 60 210 60 {lab=#net2}
C {symbols/pfet_03v3.sym} -20 -120 0 0 {name=M1
L=0.36u
W=0.72u
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
C {symbols/pfet_03v3.sym} -20 0 0 0 {name=M2
L=0.36u
W=0.72u
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
C {symbols/nfet_03v3.sym} -130 170 0 0 {name=M3
L=0.36u
W=0.36u
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
C {symbols/nfet_03v3.sym} 130 170 0 1 {name=M4
L=0.36u
W=0.36u
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
C {iopin.sym} -200 -120 0 1 {name=p1 lab=in1}
C {iopin.sym} -200 0 0 1 {name=p2 lab=in2}
C {iopin.sym} 320 0 0 0 {name=p5 lab=out}
C {iopin.sym} -110 -210 0 1 {name=p3 lab=3v3}
C {iopin.sym} -80 280 0 1 {name=p4 lab=vss}
C {symbols/nfet_03v3.sym} 280 180 0 0 {name=M5
L=0.36u
W=0.36u
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
C {symbols/pfet_03v3.sym} 280 -120 0 0 {name=M6
L=0.36u
W=0.72u
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
