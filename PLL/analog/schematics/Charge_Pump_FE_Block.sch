v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 160 -90 160 {lab=vss}
N -130 290 -90 290 {lab=vss}
N -130 390 240 390 {lab=vss}
N 240 320 240 390 {lab=vss}
N 80 320 80 390 {lab=vss}
N 80 290 110 290 {lab=vss}
N 110 160 110 290 {lab=vss}
N 80 160 110 160 {lab=vss}
N 110 290 110 390 {lab=vss}
N -90 320 -90 390 {lab=vss}
N 240 390 280 390 {lab=vss}
N 240 290 280 290 {lab=vss}
N 240 160 280 160 {lab=vss}
N 240 190 240 260 {lab=#net1}
N 80 -20 80 130 {lab=20u_bias}
N 80 190 80 260 {lab=#net2}
N -280 -40 -0 -40 {lab=3v3}
N -0 -40 0 290 {lab=3v3}
N -50 290 0 290 {lab=3v3}
N 0 290 40 290 {lab=3v3}
N 10 100 80 100 {lab=20u_bias}
N 10 100 10 160 {lab=20u_bias}
N 10 160 40 160 {lab=20u_bias}
N -50 160 10 160 {lab=20u_bias}
N -90 190 -90 260 {lab=#net3}
N 280 160 280 390 {lab=vss}
N -130 160 -130 390 {lab=vss}
N -90 -60 -90 130 {lab=#net4}
N -90 -170 -90 -120 {lab=#net5}
N -130 -90 -90 -90 {lab=3v3}
N -130 -200 -130 -90 {lab=3v3}
N -130 -200 -90 -200 {lab=3v3}
N -280 -330 -280 -40 {lab=3v3}
N -280 -330 240 -330 {lab=3v3}
N 240 -330 240 -230 {lab=3v3}
N -130 -330 -130 -200 {lab=3v3}
N 240 -90 280 -90 {lab=3v3}
N 280 -330 280 -90 {lab=3v3}
N 240 -330 280 -330 {lab=3v3}
N 240 -200 280 -200 {lab=3v3}
N 240 -170 240 -120 {lab=#net6}
N 240 -60 240 130 {lab=Charge_Pump_Out}
N 80 100 160 100 {lab=20u_bias}
N 160 100 160 160 {lab=20u_bias}
N 160 160 200 160 {lab=20u_bias}
N -90 -10 -20 -10 {lab=#net4}
N -20 -90 -20 -10 {lab=#net4}
N -50 -90 -20 -90 {lab=#net4}
N -20 -90 200 -90 {lab=#net4}
N -50 -200 -40 -200 {lab=vss}
N -40 -200 -40 390 {lab=vss}
N -280 390 -130 390 {lab=vss}
N 170 -200 200 -200 {lab=UPb}
N 170 290 200 290 {lab=DN}
N -90 -330 -90 -230 {lab=3v3}
N 160 -200 170 -200 {lab=UPb}
N -280 -20 80 -20 {lab=20u_bias}
N -300 -240 140 -240 {lab=UPb}
N 140 -240 140 -200 {lab=UPb}
N 140 -200 160 -200 {lab=UPb}
N 170 250 170 290 {lab=DN}
N -280 250 170 250 {lab=DN}
C {symbols/pfet_03v3.sym} -70 -90 0 1 {name=M1
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
C {symbols/pfet_03v3.sym} 220 -90 0 0 {name=M2
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
C {symbols/pfet_03v3.sym} -70 -200 0 1 {name=M3
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
C {symbols/pfet_03v3.sym} 220 -200 0 0 {name=M4
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
C {symbols/nfet_03v3.sym} 60 160 0 0 {name=M7
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
C {symbols/nfet_03v3.sym} 60 290 0 0 {name=M8
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
C {symbols/nfet_03v3.sym} -70 160 0 1 {name=M9
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
C {symbols/nfet_03v3.sym} -70 290 0 1 {name=M10
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
C {symbols/nfet_03v3.sym} 220 160 0 0 {name=M11
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
C {symbols/nfet_03v3.sym} 220 290 0 0 {name=M12
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
C {iopin.sym} -280 -330 0 1 {name=p4 lab=3v3}
C {iopin.sym} -280 390 0 1 {name=p5 lab=vss}
C {iopin.sym} -280 -20 0 1 {name=p6 lab=20u_bias}
C {iopin.sym} -300 -240 0 1 {name=p7 lab=UPb}
C {iopin.sym} 240 40 0 0 {name=p1 lab=Charge_Pump_Out}
C {iopin.sym} -280 250 0 1 {name=p3 lab=DN}
