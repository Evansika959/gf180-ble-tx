v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 10 -60 40 -60 {lab=3v3}
N 40 -240 40 -60 {lab=3v3}
N 10 -170 40 -170 {lab=3v3}
N 10 -240 10 -200 {lab=3v3}
N 10 -240 230 -240 {lab=3v3}
N 230 -240 230 -160 {lab=3v3}
N 230 -130 260 -130 {lab=3v3}
N 260 -240 260 -130 {lab=3v3}
N 230 -240 260 -240 {lab=3v3}
N 10 -30 10 30 {lab=#net1}
N 10 90 10 130 {lab=#net2}
N 10 190 10 230 {lab=#net3}
N 10 290 10 330 {lab=#net4}
N 10 390 10 430 {lab=#net5}
N 10 490 10 530 {lab=#net6}
N 10 60 50 60 {lab=vss}
N 50 60 50 660 {lab=vss}
N 10 660 50 660 {lab=vss}
N 10 590 10 660 {lab=vss}
N 10 560 50 560 {lab=vss}
N 10 460 50 460 {lab=vss}
N 10 360 50 360 {lab=vss}
N 10 260 50 260 {lab=vss}
N 10 160 50 160 {lab=vss}
N 230 40 270 40 {lab=vss}
N 270 40 270 140 {lab=vss}
N 230 140 270 140 {lab=vss}
N 270 140 270 220 {lab=vss}
N 50 220 270 220 {lab=vss}
N 230 170 230 220 {lab=vss}
N 230 70 230 110 {lab=#net7}
N 230 -100 230 10 {lab=clk_out}
N -70 60 -30 60 {lab=D}
N -70 260 -30 260 {lab=Qn4}
N -70 360 -30 360 {lab=Qn5}
N -70 460 -30 460 {lab=Qn6}
N -70 560 -30 560 {lab=MC}
N -100 -240 10 -240 {lab=3v3}
N -70 -60 -70 60 {lab=D}
N -70 -60 -30 -60 {lab=D}
N -70 160 -30 160 {lab=clk_in}
N -50 110 -50 160 {lab=clk_in}
N -50 110 160 110 {lab=clk_in}
N 160 110 160 140 {lab=clk_in}
N 160 140 190 140 {lab=clk_in}
N 10 -0 130 0 {lab=#net1}
N 130 -130 130 0 {lab=#net1}
N 130 -130 190 -130 {lab=#net1}
N 130 -0 130 40 {lab=#net1}
N 130 40 190 40 {lab=#net1}
N 230 -50 300 -50 {lab=clk_out}
N 10 -140 10 -90 {lab=#net8}
N -120 160 -70 160 {lab=clk_in}
N -110 -170 -110 160 {lab=clk_in}
N -110 -170 -30 -170 {lab=clk_in}
N -80 660 10 660 {lab=vss}
C {symbols/pfet_03v3.sym} -10 -170 0 0 {name=M1
L=0.32u
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
C {symbols/pfet_03v3.sym} -10 -60 0 0 {name=M2
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 60 0 0 {name=M3
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 160 0 0 {name=M4
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 260 0 0 {name=M5
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 360 0 0 {name=M6
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 460 0 0 {name=M7
L=0.32u
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
C {symbols/nfet_03v3.sym} -10 560 0 0 {name=M8
L=0.32u
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
C {symbols/pfet_03v3.sym} 210 -130 0 0 {name=M9
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
C {symbols/nfet_03v3.sym} 210 40 0 0 {name=M10
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
C {symbols/nfet_03v3.sym} 210 140 0 0 {name=M11
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
C {iopin.sym} -70 0 0 1 {name=p1 lab=D}
C {iopin.sym} -120 160 0 1 {name=p2 lab=clk_in}
C {iopin.sym} -70 260 0 1 {name=p3 lab=Qn4}
C {iopin.sym} -70 360 0 1 {name=p4 lab=Qn5}
C {iopin.sym} -70 460 0 1 {name=p5 lab=Qn6}
C {iopin.sym} -80 660 0 1 {name=p6 lab=vss}
C {iopin.sym} -100 -240 0 1 {name=p7 lab=3v3}
C {iopin.sym} -70 560 0 1 {name=p8 lab=MC}
C {iopin.sym} 300 -50 0 0 {name=p9 lab=clk_out}
