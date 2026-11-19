v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -210 -130 -130 {lab=3v3}
N -130 -210 130 -210 {lab=3v3}
N 130 -210 130 -130 {lab=3v3}
N -130 -100 130 -100 {lab=3v3}
N 0 -210 0 -100 {lab=3v3}
N -290 -10 -290 40 {lab=O+}
N -290 -10 -70 -10 {lab=O+}
N -70 -10 -70 40 {lab=O+}
N -290 70 -70 70 {lab=vss}
N -180 70 -180 130 {lab=vss}
N -180 130 -70 130 {lab=vss}
N -70 100 -70 130 {lab=vss}
N -290 100 -290 130 {lab=vss}
N -290 130 -180 130 {lab=vss}
N 70 -10 70 40 {lab=O-}
N 70 -10 290 -10 {lab=O-}
N 290 -10 290 40 {lab=O-}
N 70 70 290 70 {lab=vss}
N 180 70 180 130 {lab=vss}
N 180 130 290 130 {lab=vss}
N 290 100 290 130 {lab=vss}
N 70 100 70 130 {lab=vss}
N 70 130 180 130 {lab=vss}
N 10 70 30 70 {lab=O+}
N -30 70 -10 70 {lab=O-}
N -70 -10 10 70 {lab=O+}
N -10 70 70 -10 {lab=O-}
N -130 -70 -130 -10 {lab=O+}
N 130 -70 130 -10 {lab=O-}
N -230 -100 -170 -100 {lab=P+}
N 170 -100 240 -100 {lab=P-}
N -380 70 -330 70 {lab=N+}
N 330 70 410 70 {lab=N-}
N -70 130 70 130 {lab=vss}
N 290 130 330 130 {lab=vss}
N -150 -210 -130 -210 {lab=3v3}
N -300 -10 -290 -10 {lab=O+}
N 290 -10 300 -10 {lab=O-}
C {symbols/pfet_03v3.sym} -150 -100 0 0 {name=M1
L=0.28u
W=4u
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
C {symbols/pfet_03v3.sym} 150 -100 0 1 {name=M2
L=0.28u
W=4u
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
C {symbols/nfet_03v3.sym} -310 70 0 0 {name=M3
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
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} -50 70 0 1 {name=M4
L=0.28u
W=0.54u
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
C {symbols/nfet_03v3.sym} 50 70 0 0 {name=M5
L=0.28u
W=0.54u
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
C {symbols/nfet_03v3.sym} 310 70 0 1 {name=M6
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
model=nfet_03v3
spiceprefix=X
}
C {iopin.sym} -230 -100 0 1 {name=p1 lab=P+}
C {iopin.sym} 240 -100 0 0 {name=p2 lab=P-}
C {iopin.sym} -380 70 0 1 {name=p3 lab=N+}
C {iopin.sym} 410 70 0 0 {name=p4 lab=N-}
C {iopin.sym} 330 130 0 0 {name=p5 lab=vss}
C {iopin.sym} -150 -210 0 1 {name=p6 lab=3v3}
C {iopin.sym} -300 -10 0 1 {name=p7 lab=O+}
C {iopin.sym} 300 -10 0 0 {name=p8 lab=O-}
