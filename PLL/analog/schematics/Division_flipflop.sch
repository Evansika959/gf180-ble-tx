v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 -10 -130 30 {lab=#net1}
N -130 90 -130 150 {lab=#net2}
N -130 210 -130 290 {lab=vss}
N -130 290 240 290 {lab=vss}
N 240 210 240 290 {lab=vss}
N 40 200 40 290 {lab=vss}
N 40 180 80 180 {lab=vss}
N 80 180 80 290 {lab=vss}
N 240 180 290 180 {lab=vss}
N 290 180 290 290 {lab=vss}
N 240 290 290 290 {lab=vss}
N 240 70 290 70 {lab=vss}
N 290 70 290 180 {lab=vss}
N 40 -80 90 -80 {lab=3v3}
N 240 -90 280 -90 {lab=3v3}
N 280 -190 280 -90 {lab=3v3}
N -130 60 -70 60 {lab=3v3}
N -70 -190 -70 60 {lab=3v3}
N -130 -40 -70 -40 {lab=3v3}
N -230 180 -170 180 {lab=D}
N -230 60 -230 180 {lab=D}
N 40 100 40 150 {lab=#net3}
N -130 120 -20 120 {lab=#net2}
N -20 70 -20 120 {lab=#net2}
N -20 70 0 70 {lab=#net2}
N 40 -50 40 40 {lab=#net4}
N 40 -190 40 -110 {lab=3v3}
N 240 -190 240 -120 {lab=3v3}
N 240 -60 240 40 {lab=clk_outb}
N 240 100 240 150 {lab=#net5}
N -130 -190 -130 -70 {lab=3v3}
N -130 -190 280 -190 {lab=3v3}
N 160 -90 200 -90 {lab=#net4}
N 40 -10 160 -10 {lab=#net4}
N -310 -190 -130 -190 {lab=3v3}
N -310 290 -130 290 {lab=vss}
N -40 180 0 180 {lab=clk_in}
N -40 -80 -40 180 {lab=clk_in}
N 170 180 200 180 {lab=#net4}
N 90 -190 90 -80 {lab=3v3}
N 80 70 80 180 {lab=vss}
N 40 70 80 70 {lab=vss}
N -130 180 -100 180 {lab=vss}
N -100 180 -100 290 {lab=vss}
N -230 -40 -230 60 {lab=D}
N -230 -40 -170 -40 {lab=D}
N -210 60 -170 60 {lab=clk_in}
N -210 -80 -210 60 {lab=clk_in}
N 160 -90 160 -10 {lab=#net4}
N 140 70 140 140 {lab=clk_in}
N -40 140 140 140 {lab=clk_in}
N 160 180 170 180 {lab=#net4}
N 160 -10 160 180 {lab=#net4}
N 140 70 200 70 {lab=clk_in}
N 480 -90 520 -90 {lab=3v3}
N 480 -190 480 -120 {lab=3v3}
N 400 -90 440 -90 {lab=clk_outb}
N 480 130 530 130 {lab=vss}
N 480 160 480 210 {lab=vss}
N 380 130 440 130 {lab=clk_outb}
N 480 -60 480 100 {lab=#net6}
N 380 -90 380 130 {lab=clk_outb}
N 380 -90 400 -90 {lab=clk_outb}
N 280 -190 480 -190 {lab=3v3}
N 480 210 480 290 {lab=vss}
N 290 290 480 290 {lab=vss}
N 530 130 530 290 {lab=vss}
N 480 290 530 290 {lab=vss}
N 520 -190 520 -90 {lab=3v3}
N 480 -190 520 -190 {lab=3v3}
N -210 -80 0 -80 {lab=clk_in}
N -280 -80 -210 -80 {lab=clk_in}
N 240 -0 380 0 {lab=clk_outb}
N -310 50 -230 50 {lab=D}
N -320 -80 -280 -80 {lab=clk_in}
C {symbols/nfet_03v3.sym} 20 180 0 0 {name=M1
L=0.36u
W=0.56u
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
C {symbols/nfet_03v3.sym} -150 180 0 0 {name=M2
L=0.36u
W=0.56u
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
C {symbols/nfet_03v3.sym} 220 180 0 0 {name=M3
L=0.36u
W=0.56u
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
C {symbols/nfet_03v3.sym} 220 70 0 0 {name=M4
L=0.36u
W=0.56u
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
C {symbols/pfet_03v3.sym} -150 -40 0 0 {name=M5
L=0.36u
W=1.12u
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
C {symbols/pfet_03v3.sym} -150 60 0 0 {name=M6
L=0.36u
W=1.12u
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
C {symbols/pfet_03v3.sym} 20 -80 0 0 {name=M8
L=0.36u
W=1.12u
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
C {symbols/pfet_03v3.sym} 220 -90 0 0 {name=M9
L=0.36u
W=1.12u
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
C {symbols/nfet_03v3.sym} 20 70 0 0 {name=M7
L=0.36u
W=0.56u
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
C {symbols/pfet_03v3.sym} 460 -90 0 0 {name=M10
L=0.36u
W=1.12u
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
C {symbols/nfet_03v3.sym} 460 130 0 0 {name=M11
L=0.36u
W=0.56u
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
C {iopin.sym} -310 -190 0 1 {name=p5 lab=3v3}
C {iopin.sym} -310 290 0 1 {name=p6 lab=vss}
C {iopin.sym} 380 10 0 0 {name=p7 lab=clk_outb}
C {iopin.sym} -310 50 0 1 {name=p1 lab=D}
C {iopin.sym} -320 -80 0 1 {name=p2 lab=clk_in}
C {iopin.sym} 480 10 0 0 {name=p3 lab=clk_out}
