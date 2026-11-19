v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -70 -0 110 0 {lab=0}
N 20 -0 20 140 {lab=0}
N -70 140 20 140 {lab=0}
N -90 -0 -70 -0 {lab=0}
N 110 0 130 0 {lab=0}
N -90 140 -70 140 {lab=0}
N -90 30 -90 110 {lab=#net1}
N -90 -110 -90 -30 {lab=DNb}
N -180 -140 -130 -140 {lab=F_ref}
N -180 -140 -180 140 {lab=F_ref}
N -180 140 -130 140 {lab=F_ref}
N -220 -0 -130 -0 {lab=F_VC0}
N 130 30 130 50 {lab=#net1}
N 170 -0 200 0 {lab=UP}
N 260 -140 300 -140 {lab=DNb}
N 260 -130 260 0 {lab=DNb}
N 260 0 300 -0 {lab=DNb}
N 340 -100 340 -30 {lab=DN}
N 330 -140 370 -140 {lab=#net2}
N 370 -210 370 -140 {lab=#net2}
N 260 -140 260 -130 {lab=DNb}
N 340 -110 340 -100 {lab=DN}
N -90 -210 370 -210 {lab=#net2}
N -90 -210 -90 -170 {lab=#net2}
N -90 -140 -60 -140 {lab=#net2}
N -60 -210 -60 -140 {lab=#net2}
N 340 -210 340 -170 {lab=#net2}
N 340 30 340 240 {lab=0}
N -90 240 340 240 {lab=0}
N -90 170 -90 240 {lab=0}
N 20 140 20 240 {lab=0}
N 340 -0 380 0 {lab=0}
N 380 0 380 240 {lab=0}
N 340 240 380 240 {lab=0}
N 630 0 810 0 {lab=0}
N 720 0 720 140 {lab=0}
N 630 140 720 140 {lab=0}
N 610 0 630 0 {lab=0}
N 810 0 830 0 {lab=0}
N 610 140 630 140 {lab=0}
N 610 30 610 110 {lab=#net3}
N 610 -110 610 -30 {lab=UPb}
N 520 -140 570 -140 {lab=F_VC0}
N 520 -140 520 140 {lab=F_VC0}
N 520 140 570 140 {lab=F_VC0}
N 480 0 570 0 {lab=F_ref}
N 830 30 830 50 {lab=#net3}
N 870 0 900 0 {lab=DN}
N 960 -140 1000 -140 {lab=UPb}
N 960 -130 960 0 {lab=UPb}
N 960 0 1000 0 {lab=UPb}
N 1040 -100 1040 -30 {lab=UP}
N 1030 -140 1070 -140 {lab=#net2}
N 1070 -210 1070 -140 {lab=#net2}
N 960 -140 960 -130 {lab=UPb}
N 1040 -110 1040 -100 {lab=UP}
N 610 -210 1070 -210 {lab=#net2}
N 610 -210 610 -170 {lab=#net2}
N 610 -140 640 -140 {lab=#net2}
N 640 -210 640 -140 {lab=#net2}
N 1040 -210 1040 -170 {lab=#net2}
N 1040 30 1040 240 {lab=0}
N 610 240 1040 240 {lab=0}
N 610 170 610 240 {lab=0}
N 720 140 720 240 {lab=0}
N 1040 0 1080 0 {lab=0}
N 1080 0 1080 240 {lab=0}
N 1040 240 1080 240 {lab=0}
N 370 -210 610 -210 {lab=#net2}
N 380 240 610 240 {lab=0}
N -320 -210 -320 -30 {lab=#net2}
N -320 -210 -90 -210 {lab=#net2}
N -320 30 -320 240 {lab=0}
N -320 240 -90 240 {lab=0}
N 830 -70 830 -30 {lab=UPb}
N 610 -70 830 -70 {lab=UPb}
N 830 -70 960 -70 {lab=UPb}
N 130 -70 130 -30 {lab=DNb}
N -90 -70 130 -70 {lab=DNb}
N 130 -70 260 -70 {lab=DNb}
N 130 -100 130 -70 {lab=DNb}
N 340 -70 380 -70 {lab=DN}
N 830 -100 830 -70 {lab=UPb}
N 1040 -70 1090 -70 {lab=UP}
N -170 140 -170 160 {lab=F_ref}
N -170 220 -170 240 {lab=0}
N -230 0 -230 50 {lab=F_VC0}
N -230 -0 -220 -0 {lab=F_VC0}
N -230 110 -230 240 {lab=0}
N 130 50 130 90 {lab=#net1}
N -90 90 130 90 {lab=#net1}
N 610 50 830 50 {lab=#net3}
C {symbols/pfet_03v3.sym} -110 -140 0 0 {name=M1
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
C {symbols/pfet_03v3.sym} 320 -140 0 0 {name=M2
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
C {symbols/nfet_03v3.sym} -110 0 0 0 {name=M3
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
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 150 0 0 1 {name=M4
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
C {symbols/nfet_03v3.sym} -110 140 0 0 {name=M5
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
C {symbols/nfet_03v3.sym} 320 0 0 0 {name=M6
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
model=nfet_03v3
spiceprefix=X
}
C {symbols/pfet_03v3.sym} 590 -140 0 0 {name=M7
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
C {symbols/pfet_03v3.sym} 1020 -140 0 0 {name=M8
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
C {symbols/nfet_03v3.sym} 590 0 0 0 {name=M9
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
model=nfet_03v3
spiceprefix=X
}
C {symbols/nfet_03v3.sym} 850 0 0 1 {name=M10
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
C {symbols/nfet_03v3.sym} 590 140 0 0 {name=M11
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
C {symbols/nfet_03v3.sym} 1020 0 0 0 {name=M12
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
model=nfet_03v3
spiceprefix=X
}
C {gnd.sym} 440 240 0 0 {name=l1 lab=0}
C {vsource.sym} -320 0 0 0 {name=V1 value=3.3 savecurrent=false}
C {lab_pin.sym} -180 -20 0 0 {name=p1 sig_type=std_logic lab=F_ref}
C {lab_pin.sym} 200 0 0 1 {name=p2 sig_type=std_logic lab=UP}
C {lab_pin.sym} 130 -100 0 1 {name=p3 sig_type=std_logic lab=DNb}
C {lab_pin.sym} 380 -70 0 1 {name=p4 sig_type=std_logic lab=DN}
C {lab_pin.sym} -220 0 0 0 {name=p5 sig_type=std_logic lab=F_VC0}
C {lab_pin.sym} 520 -20 0 0 {name=p6 sig_type=std_logic lab=F_VC0}
C {lab_pin.sym} 480 0 0 0 {name=p7 sig_type=std_logic lab=F_ref}
C {lab_pin.sym} 830 -100 0 0 {name=p8 sig_type=std_logic lab=UPb}
C {lab_pin.sym} 900 0 0 1 {name=p9 sig_type=std_logic lab=DN}
C {lab_pin.sym} 1090 -70 0 1 {name=p10 sig_type=std_logic lab=UP}
C {simulator_commands.sym} -290 -380 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical

.temp 27

* Nominal frequency: 40 MHz
.param pfd_tref=25n pfd_tfb=25n
.param pfd_dref=10n pfd_dfb=10n

* Input clocks: 3.3 V, 100 ps edges, 50% duty cycle

.control
set noaskquit
set numdgt=7

foreach test 1 2 3 4 5

  * Restore nominal settings before selecting each case
  alterparam pfd_tfb=25n
  alterparam pfd_dref=10n
  alterparam pfd_dfb=10n

  if $test = 1
    alterparam pfd_dfb=12n
    echo CASE_1_REF_LEADS_BY_2ns
  end

  if $test = 2
    alterparam pfd_dref=12n
    echo CASE_2_FEEDBACK_LEADS_BY_2ns
  end

  if $test = 3
    echo CASE_3_ALIGNED_CLOCKS
  end

  if $test = 4
    alterparam pfd_tfb=25.641025641n
    echo CASE_4_FEEDBACK_39MHz
  end

  if $test = 5
    alterparam pfd_tfb=24.390243902n
    echo CASE_5_FEEDBACK_41MHz
  end

  reset
  save v(F_ref) v(F_VC0) v(UP) v(DN) v(UPb) v(DNb)

  * Run 2.5 us; maximum timestep 10 ps
  tran 10p 2.5u 0 10p

  * Convert outputs to logic levels using a 1.65 V threshold
  let up_logic = (v(UP) gt 1.65)
  let dn_logic = (v(DN) gt 1.65)
  let both_on = up_logic * dn_logic

  * Ignore the first 500 ns
  meas tran up_duty AVG up_logic FROM=500n TO=2.5u
  meas tran dn_duty AVG dn_logic FROM=500n TO=2.5u
  meas tran overlap_duty AVG both_on FROM=500n TO=2.5u

  * Positive means UP dominates; negative means DN dominates
  let duty_error = up_duty - dn_duty
  print duty_error

  * Vertical offsets separate the displayed waveforms
  let ref_trace = v(F_ref) + 12
  let fb_trace = v(F_VC0) + 8
  let up_trace = v(UP) + 4

  if $test < 4
    plot ref_trace fb_trace up_trace v(DN) xlimit 500n 600n title PFD_case_\{$test\}
  else
    plot ref_trace fb_trace up_trace v(DN) xlimit 500n 1.5u title PFD_case_\{$test\}
  end

end
.endc
"}
C {vsource.sym} -230 80 0 0 {name=V2 value="PULSE(0 3.3 \{pfd_dfb\} 100p 100p \{pfd_tfb/2-100p\} \{pfd_tfb\})" savecurrent=false}
C {vsource.sym} -170 190 0 0 {name=V3 value="PULSE(0 3.3 \{pfd_dref\} 100p 100p \{pfd_tref/2-100p\} \{pfd_tref\})" savecurrent=false}
