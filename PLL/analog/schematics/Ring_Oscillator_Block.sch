v {xschem version=3.4.8RC file_version=1.3
* Copyright 2022 GlobalFoundries PDK Authors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     https://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.

}
G {}
K {}
V {}
S {}
F {}
E {}
N 450 -370 450 -290 {lab=#net1}
N 770 -370 770 -290 {lab=clk_out}
N 620 -370 620 -290 {lab=#net2}
N 360 -260 410 -260 {lab=clk_out}
N 360 -400 360 -260 {lab=clk_out}
N 360 -400 410 -400 {lab=clk_out}
N 530 -330 550 -330 {lab=#net1}
N 550 -400 580 -400 {lab=#net1}
N 550 -400 550 -330 {lab=#net1}
N 560 -260 580 -260 {lab=#net1}
N 550 -260 560 -260 {lab=#net1}
N 550 -330 550 -260 {lab=#net1}
N 450 -330 530 -330 {lab=#net1}
N 770 -330 850 -330 {lab=clk_out}
N 450 -400 480 -400 {lab=3v3}
N 450 -260 480 -260 {lab=vss}
N 480 -260 480 -190 {lab=vss}
N 620 -400 650 -400 {lab=3v3}
N 620 -260 650 -260 {lab=vss}
N 650 -260 650 -190 {lab=vss}
N 770 -400 800 -400 {lab=3v3}
N 770 -260 800 -260 {lab=vss}
N 800 -260 800 -190 {lab=vss}
N 800 -510 800 -400 {lab=3v3}
N 480 -510 480 -400 {lab=3v3}
N 650 -500 650 -400 {lab=3v3}
N 650 -510 650 -500 {lab=3v3}
N 450 -230 450 -200 {lab=#net3}
N 770 -230 770 -200 {lab=#net4}
N 620 -230 620 -200 {lab=#net5}
N 650 -190 650 -170 {lab=vss}
N 620 -170 650 -170 {lab=vss}
N 770 -170 800 -170 {lab=vss}
N 800 -190 800 -170 {lab=vss}
N 450 -170 480 -170 {lab=vss}
N 480 -190 480 -170 {lab=vss}
N 450 -140 450 -120 {lab=vss}
N 450 -120 800 -120 {lab=vss}
N 800 -170 800 -120 {lab=vss}
N 770 -140 770 -120 {lab=vss}
N 620 -140 620 -120 {lab=vss}
N 480 -170 480 -120 {lab=vss}
N 650 -170 650 -120 {lab=vss}
N 770 -490 800 -490 {lab=3v3}
N 620 -490 650 -490 {lab=3v3}
N 450 -490 480 -490 {lab=3v3}
N 450 -460 450 -430 {lab=#net6}
N 620 -460 620 -430 {lab=#net7}
N 770 -460 770 -430 {lab=#net8}
N 800 -560 800 -510 {lab=3v3}
N 290 -560 800 -560 {lab=3v3}
N 280 -560 290 -560 {lab=3v3}
N 450 -560 450 -520 {lab=3v3}
N 620 -560 620 -520 {lab=3v3}
N 650 -560 650 -510 {lab=3v3}
N 480 -560 480 -510 {lab=3v3}
N 280 -120 450 -120 {lab=vss}
N 690 -260 730 -260 {lab=#net2}
N 620 -330 690 -330 {lab=#net2}
N 690 -330 690 -260 {lab=#net2}
N 690 -400 730 -400 {lab=#net2}
N 690 -400 690 -330 {lab=#net2}
N 170 -560 280 -560 {lab=3v3}
N 170 -120 280 -120 {lab=vss}
N 170 -490 410 -490 {lab=vb_p}
N 710 -490 730 -490 {lab=vb_p}
N 770 -560 770 -520 {lab=3v3}
N 560 -490 580 -490 {lab=vb_p}
N 730 -170 730 -140 {lab=v_ctrl}
N 560 -170 560 -140 {lab=v_ctrl}
N 560 -170 580 -170 {lab=v_ctrl}
N 400 -140 400 -130 {lab=v_ctrl}
N 400 -130 730 -130 {lab=v_ctrl}
N 730 -140 730 -130 {lab=v_ctrl}
N 400 -170 400 -140 {lab=v_ctrl}
N 170 -170 410 -170 {lab=v_ctrl}
N 560 -140 560 -130 {lab=v_ctrl}
N 710 -520 710 -490 {lab=vb_p}
N 350 -520 350 -490 {lab=vb_p}
N 560 -520 560 -490 {lab=vb_p}
N 710 -530 710 -520 {lab=vb_p}
N 350 -530 710 -530 {lab=vb_p}
N 350 -530 350 -520 {lab=vb_p}
N 560 -530 560 -520 {lab=vb_p}
C {symbols/nfet_03v3.sym} 430 -260 0 0 {name=M1
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
C {symbols/pfet_03v3.sym} 430 -400 0 0 {name=M2
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
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 600 -400 0 0 {name=M3
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
model=pfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 750 -400 0 0 {name=M4
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
model=pfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 600 -260 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} 750 -260 0 0 {name=M6
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
C {lab_pin.sym} 770 -330 0 0 {name=p1 sig_type=std_logic lab=clk_out}
C {lab_pin.sym} 360 -330 0 0 {name=p2 sig_type=std_logic lab=clk_out}
C {symbols/nfet_03v3.sym} 430 -170 0 0 {name=M7
L=0.4u
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
C {symbols/nfet_03v3.sym} 600 -170 0 0 {name=M8
L=0.4u
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
C {symbols/nfet_03v3.sym} 750 -170 0 0 {name=M9
L=0.4u
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
C {symbols/pfet_03v3.sym} 430 -490 0 0 {name=M10
L=0.4u
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
C {symbols/pfet_03v3.sym} 600 -490 0 0 {name=M11
L=0.4u
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
C {symbols/pfet_03v3.sym} 750 -490 0 0 {name=M12
L=0.4u
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
C {iopin.sym} 170 -560 0 1 {name=p7 lab=3v3}
C {iopin.sym} 170 -490 0 1 {name=p4 lab=vb_p}
C {iopin.sym} 850 -330 0 0 {name=p3 lab=clk_out}
C {iopin.sym} 170 -170 0 1 {name=p6 lab=v_ctrl}
C {iopin.sym} 170 -120 0 1 {name=p8 lab=vss}
