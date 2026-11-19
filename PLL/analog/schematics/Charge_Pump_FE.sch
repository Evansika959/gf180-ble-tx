v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -130 160 -90 160 {lab=0}
N -130 290 -90 290 {lab=0}
N -130 390 240 390 {lab=0}
N 240 320 240 390 {lab=0}
N 80 320 80 390 {lab=0}
N 80 290 110 290 {lab=0}
N 110 160 110 290 {lab=0}
N 80 160 110 160 {lab=0}
N 110 290 110 390 {lab=0}
N -90 320 -90 390 {lab=0}
N 240 390 280 390 {lab=0}
N 240 290 280 290 {lab=0}
N 240 160 280 160 {lab=0}
N 240 190 240 260 {lab=#net1}
N 80 70 80 130 {lab=#net2}
N 80 190 80 260 {lab=#net3}
N 80 -20 80 10 {lab=0}
N 80 -20 110 -20 {lab=0}
N 110 -20 110 160 {lab=0}
N -280 -40 -280 -20 {lab=#net4}
N -280 -40 -0 -40 {lab=#net4}
N -0 -40 0 290 {lab=#net4}
N -50 290 0 290 {lab=#net4}
N 0 290 40 290 {lab=#net4}
N 10 100 80 100 {lab=#net2}
N 10 100 10 160 {lab=#net2}
N 10 160 40 160 {lab=#net2}
N -50 160 10 160 {lab=#net2}
N -90 190 -90 260 {lab=#net5}
N 280 160 280 390 {lab=0}
N -130 160 -130 390 {lab=0}
N -90 -60 -90 130 {lab=#net6}
N -90 -170 -90 -120 {lab=#net7}
N -130 -90 -90 -90 {lab=#net4}
N -130 -200 -130 -90 {lab=#net4}
N -130 -200 -90 -200 {lab=#net4}
N -280 -330 -280 -40 {lab=#net4}
N -280 -330 240 -330 {lab=#net4}
N 240 -330 240 -230 {lab=#net4}
N -130 -330 -130 -200 {lab=#net4}
N 240 -90 280 -90 {lab=#net4}
N 280 -330 280 -90 {lab=#net4}
N 240 -330 280 -330 {lab=#net4}
N 240 -200 280 -200 {lab=#net4}
N 240 -170 240 -120 {lab=#net8}
N 240 -60 240 130 {lab=OUT}
N 80 100 160 100 {lab=#net2}
N 160 100 160 160 {lab=#net2}
N 160 160 200 160 {lab=#net2}
N -90 -10 -20 -10 {lab=#net6}
N -20 -90 -20 -10 {lab=#net6}
N -50 -90 -20 -90 {lab=#net6}
N -20 -90 200 -90 {lab=#net6}
N -50 -200 -40 -200 {lab=0}
N -40 -200 -40 390 {lab=0}
N -280 390 -130 390 {lab=0}
N -280 40 -280 390 {lab=0}
N 170 290 200 290 {lab=DN}
N -90 -330 -90 -230 {lab=#net4}
N 150 -200 200 -200 {lab=UPb}
N 150 -200 150 -170 {lab=UPb}
N 180 290 180 310 {lab=DN}
N 180 370 180 390 {lab=0}
N 150 -110 150 -60 {lab=0}
N 150 -60 150 390 {lab=0}
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
C {isource.sym} 80 40 0 0 {name=I0 value=20u}
C {vsource.sym} -280 10 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} 80 390 0 0 {name=l1 lab=0}
C {lab_pin.sym} 150 -200 0 0 {name=p1 sig_type=std_logic lab=UPb}
C {lab_pin.sym} 170 290 0 0 {name=p2 sig_type=std_logic lab=DN}
C {lab_pin.sym} 240 40 0 1 {name=p3 sig_type=std_logic lab=OUT}
C {simulator_commands.sym} -440 -420 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.temp 27

* Pulse plateau widths; 100 ps edges give 12.5 ns
* active time at the 50% voltage crossings.
.param cp_pw_up=12.4n cp_pw_dn=12.4n

* PMOS source switch: active LOW

* NMOS sink switch: active HIGH

* Positive sense current means charge delivered by the pump
VSENSE_TEST OUT cp_load 0

* Test load and output-voltage clamp
CLOAD_TEST cp_load 0 10p
RHOLD_TEST cp_load cp_bias 1m
VBIAS_TEST cp_bias 0 1.65

.ic v(cp_load)=1.65

.control
set noaskquit
set numdgt=7

* ------------------------------------------------------------
* DC output-current sweep
* State 0: both OFF
* State 1: source only
* State 2: sink only
* State 3: both ON
* ------------------------------------------------------------

foreach state 0 1 2 3
  reset
  alter VUP_TEST dc=3.3
  alter VDN_TEST dc=0

  if $state = 1
    alter VUP_TEST dc=0
  end

  if $state = 2
    alter VDN_TEST dc=3.3
  end

  if $state = 3
    alter VUP_TEST dc=0
    alter VDN_TEST dc=3.3
  end

  echo DC_STATE_$state
  dc VBIAS_TEST 0.05 3.25 0.05

  let cp_current = i(VSENSE_TEST)
  meas dc i_mid FIND cp_current AT=1.65

  if $state = 0
    set off_plot=$curplot
  end
  if $state = 1
    set source_plot=$curplot
  end
  if $state = 2
    set sink_plot=$curplot
  end
  if $state = 3
    set both_plot=$curplot
  end
end

plot \{$off_plot\}.cp_current \{$source_plot\}.cp_current \{$sink_plot\}.cp_current \{$both_plot\}.cp_current title CP_DC_current

* Current and mismatch at approximately OUT = 1.65 V
* source_uA and sink_uA are positive current magnitudes.
let source_uA = 1e6 * \{$source_plot\}.i_mid
let sink_uA = -1e6 * \{$sink_plot\}.i_mid
let both_on_uA = 1e6 * \{$both_plot\}.i_mid
let off_nA = 1e9 * \{$off_plot\}.i_mid

print source_uA sink_uA both_on_uA off_nA

if (source_uA + sink_uA) gt 1e-6
  let mismatch_pct = 100*(source_uA-sink_uA)/((source_uA+sink_uA)/2)
  print mismatch_pct
end

* ------------------------------------------------------------
* Transient tests with the output clamp effectively disconnected
* Both branches turn ON together, matching the paper's FE-PFD.
*
* Case 1: UP active 12.5 ns, DN active 10.5 ns
* Case 2: UP active 10.5 ns, DN active 12.5 ns
* Case 3: Both active 12.5 ns
* ------------------------------------------------------------

foreach test 1 2 3
  alterparam cp_pw_up=12.4n
  alterparam cp_pw_dn=12.4n

  if $test = 1
    alterparam cp_pw_dn=10.4n
  end

  if $test = 2
    alterparam cp_pw_up=10.4n
  end

  reset

  * Change the clamp resistance from 1 milliohm to 1 teraohm
  alter RHOLD_TEST=1e12

  echo TRANSIENT_CASE_$test
  tran 5p 600n 0 5p

  * Output drift over eight complete clock periods
  meas tran v_start FIND v(OUT) AT=300n
  meas tran v_end FIND v(OUT) AT=500n
  let drift_mV = 1000*(v_end-v_start)

  * Net charge delivered during one complete clock period
  meas tran q_cycle INTEG i(VSENSE_TEST) FROM=400n TO=425n
  let q_cycle_fC = 1e15*q_cycle

  print drift_mV q_cycle_fC

  plot v(OUT) title CP_output_case_\{$test\}
  plot i(VSENSE_TEST) xlimit 400n 450n title CP_current_case_\{$test\}
end
.endc
"}
C {vsource.sym} 150 -140 0 0 {name=V2 value="DC 3.3 PULSE(3.3 0 100n 100p 100p \{cp_pw_up\} 25n)" savecurrent=false}
C {vsource.sym} 180 340 0 0 {name=V3 value="DC 0 PULSE(0 3.3 100n 100p 100p \{cp_pw_dn\} 25n)" savecurrent=false}
