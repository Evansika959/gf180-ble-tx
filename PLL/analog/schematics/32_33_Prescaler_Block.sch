v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -700 0 -660 0 {lab=Q1}
N -630 -200 -590 -200 {lab=Q1}
N -290 -210 -250 -210 {lab=#net1}
N -250 -210 -250 -10 {lab=#net1}
N -250 -10 -250 20 {lab=#net1}
N -250 20 -170 20 {lab=#net1}
N 1870 40 1910 40 {lab=vss}
N 1910 40 1910 130 {lab=vss}
N -660 130 1910 130 {lab=vss}
N -700 80 -660 80 {lab=vss}
N -660 80 -660 130 {lab=vss}
N -680 -300 -680 -80 {lab=3v3}
N -700 -80 -680 -80 {lab=3v3}
N -680 -300 1560 -300 {lab=3v3}
N 1560 -300 1560 -60 {lab=3v3}
N 1560 -60 1570 -60 {lab=3v3}
N 1130 -60 1160 -60 {lab=3v3}
N 1130 -300 1130 -60 {lab=3v3}
N 660 -60 690 -60 {lab=3v3}
N 660 -300 660 -60 {lab=3v3}
N 220 -60 260 -60 {lab=3v3}
N 220 -300 220 -60 {lab=3v3}
N -200 -60 -170 -60 {lab=3v3}
N -200 -300 -200 -60 {lab=3v3}
N -290 -250 -260 -250 {lab=3v3}
N -260 -300 -260 -250 {lab=3v3}
N -290 -170 -270 -170 {lab=vss}
N -270 -170 -270 130 {lab=vss}
N 130 40 160 40 {lab=vss}
N 160 40 160 130 {lab=vss}
N 560 40 590 40 {lab=vss}
N 590 40 590 130 {lab=vss}
N 990 40 1020 40 {lab=vss}
N 1020 40 1020 130 {lab=vss}
N 1460 40 1490 40 {lab=vss}
N 1490 40 1490 130 {lab=vss}
N -1160 130 -660 130 {lab=vss}
N -1140 -390 -680 -390 {lab=3v3}
N -680 -390 -680 -300 {lab=3v3}
N -1160 -30 -1000 -30 {lab=CLK_IN}
N -620 -220 -590 -220 {lab=Q3n}
N -630 -220 -620 -220 {lab=Q3n}
N -1160 50 -1000 50 {lab=MC}
C {2_input_or.sym} -440 -210 0 0 {name=x8}
C {lab_pin.sym} -660 0 0 1 {name=p1 sig_type=std_logic lab=Q1}
C {Prescaler_FF1.sym} -850 0 0 0 {name=x6}
C {lab_pin.sym} -630 -200 0 0 {name=p2 sig_type=std_logic lab=Q1}
C {lab_pin.sym} 130 -30 0 1 {name=p3 sig_type=std_logic lab=Q2}
C {lab_pin.sym} 560 -30 0 1 {name=p4 sig_type=std_logic lab=Q3}
C {lab_pin.sym} 990 -50 0 1 {name=p5 sig_type=std_logic lab=Q4b}
C {lab_pin.sym} 1460 -50 0 1 {name=p6 sig_type=std_logic lab=Q5b}
C {Division_flipflop.sym} -20 -10 0 0 {name=x1}
C {Division_flipflop.sym} 410 -10 0 0 {name=x2}
C {Division_flipflop.sym} 840 -10 0 0 {name=x3}
C {Division_flipflop.sym} 1310 -10 0 0 {name=x4}
C {Division_flipflop.sym} 1720 -10 0 0 {name=x5}
C {lab_pin.sym} 260 20 0 0 {name=p7 sig_type=std_logic lab=Q2}
C {lab_pin.sym} 690 -40 0 0 {name=p8 sig_type=std_logic lab=Q3}
C {lab_pin.sym} 1160 -40 0 0 {name=p10 sig_type=std_logic lab=Q4b}
C {lab_pin.sym} 690 20 0 0 {name=p11 sig_type=std_logic lab=Q4b}
C {lab_pin.sym} 1160 20 0 0 {name=p12 sig_type=std_logic lab=Q5b}
C {lab_pin.sym} 1870 -50 0 1 {name=p13 sig_type=std_logic lab=Q6b}
C {lab_pin.sym} 1570 20 0 0 {name=p14 sig_type=std_logic lab=Q6b}
C {lab_pin.sym} -1000 -10 0 0 {name=p15 sig_type=std_logic lab=Q4b}
C {lab_pin.sym} 1570 -40 0 0 {name=p16 sig_type=std_logic lab=Q5b}
C {lab_pin.sym} -1000 10 0 0 {name=p17 sig_type=std_logic lab=Q5b}
C {lab_pin.sym} -1000 30 0 0 {name=p18 sig_type=std_logic lab=Q6b}
C {lab_pin.sym} -170 -40 0 0 {name=p21 sig_type=std_logic lab=CLK_IN
}
C {lab_pin.sym} -1000 -50 0 0 {name=p23 sig_type=std_logic lab=Q3n}
C {lab_pin.sym} 560 -50 0 1 {name=p9 sig_type=std_logic lab=Q3n}
C {lab_pin.sym} -630 -220 0 0 {name=p19 sig_type=std_logic lab=Q3n}
C {iopin.sym} -1160 -30 0 1 {name=p24 lab=CLK_IN}
C {iopin.sym} -1160 50 0 1 {name=p20 lab=MC}
C {iopin.sym} -1140 -390 0 1 {name=p25 lab=3v3}
C {iopin.sym} -1160 130 0 1 {name=p26 lab=vss}
C {iopin.sym} 1870 -30 0 0 {name=p27 lab=CLK_OUT}
C {lab_pin.sym} 260 -40 0 0 {name=p28 sig_type=std_logic lab=CLK_IN
}
