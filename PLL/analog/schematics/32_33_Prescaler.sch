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
N 1870 40 1910 40 {lab=0}
N 1910 40 1910 130 {lab=0}
N -660 130 1910 130 {lab=0}
N -700 80 -660 80 {lab=0}
N -660 80 -660 130 {lab=0}
N -680 -300 -680 -80 {lab=#net2}
N -700 -80 -680 -80 {lab=#net2}
N -680 -300 1560 -300 {lab=#net2}
N 1560 -300 1560 -60 {lab=#net2}
N 1560 -60 1570 -60 {lab=#net2}
N 1130 -60 1160 -60 {lab=#net2}
N 1130 -300 1130 -60 {lab=#net2}
N 660 -60 690 -60 {lab=#net2}
N 660 -300 660 -60 {lab=#net2}
N 220 -60 260 -60 {lab=#net2}
N 220 -300 220 -60 {lab=#net2}
N -200 -60 -170 -60 {lab=#net2}
N -200 -300 -200 -60 {lab=#net2}
N -290 -250 -260 -250 {lab=#net2}
N -260 -300 -260 -250 {lab=#net2}
N -290 -170 -270 -170 {lab=0}
N -270 -170 -270 130 {lab=0}
N 130 40 160 40 {lab=0}
N 160 40 160 130 {lab=0}
N 560 40 590 40 {lab=0}
N 590 40 590 130 {lab=0}
N 990 40 1020 40 {lab=0}
N 1020 40 1020 130 {lab=0}
N 1460 40 1490 40 {lab=0}
N 1490 40 1490 130 {lab=0}
N -1140 130 -660 130 {lab=0}
N -1140 -110 -1140 130 {lab=0}
N -1140 -390 -1140 -170 {lab=#net2}
N -1140 -390 -680 -390 {lab=#net2}
N -680 -390 -680 -300 {lab=#net2}
N -1100 50 -1100 130 {lab=0}
N -1100 -30 -1100 -10 {lab=CLK}
N -1100 -30 -1000 -30 {lab=CLK}
N -1050 50 -1050 70 {lab=#net3}
N -1050 50 -1000 50 {lab=#net3}
N -620 -220 -590 -220 {lab=Q3n}
N -630 -220 -620 -220 {lab=Q3n}
C {lab_pin.sym} -660 0 0 1 {name=p1 sig_type=std_logic lab=Q1}
C {Prescaler_FF1.sym} -850 0 0 0 {name=x6}
C {lab_pin.sym} -630 -200 0 0 {name=p2 sig_type=std_logic lab=Q1}
C {lab_pin.sym} 130 -50 0 1 {name=p3 sig_type=std_logic lab=Q2}
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
C {vsource.sym} -1140 -140 0 0 {name=V1 value=3.3 savecurrent=false}
C {vsource.sym} -1100 20 0 0 {name=V2 value=3.3 savecurrent=false}
C {lab_pin.sym} -1100 -30 0 0 {name=p20 sig_type=std_logic lab=CLK
}
C {lab_pin.sym} -170 -40 0 0 {name=p21 sig_type=std_logic lab=CLK
}
C {lab_pin.sym} 260 -40 0 0 {name=p22 sig_type=std_logic lab=CLK
}
C {vsource.sym} -1050 100 0 0 {name=V3 value=3.3 savecurrent=false}
C {gnd.sym} 160 130 0 0 {name=l1 lab=0}
C {simulator_commands.sym} 0 -470 0 0 {name=COMMANDS
simulator=ngspice
only_toplevel=false 
value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
* Output load: adjust to the next stage's input capacitance.
C_TEST_OUT Q6b 0 10f
.ic V(Q1)=0 V(Q2)=0 V(Q3)=0
.ic V(Q4b)=3.3 V(Q5b)=3.3 V(Q6b)=3.3
.control
set noaskquit
set num_threads=1
set numdgt=8
set wr_singlescale
set wr_vecnames

* Input frequency in Hz.
let fclk = 600e6
let period = 1/fclk
let pulsewidth = period/2 - 1p
let stop_time = 1000*period
let settle_time = 300*period
let zoom_end = settle_time + 12*period

foreach mc 0 3.3
  reset
  option reltol=1e-4 abstol=1e-12 vntol=1e-6

  alter V1 dc = 3.3
  alter V2 dc = 0
  alter @V2[pulse] = [ 0 3.3 1n 1p 1p $&pulsewidth $&period ]
  alter V3 dc = $mc

  save v(CLK) v(Q1) v(Q2) v(Q3) v(Q4b) v(Q5b) v(Q6b) i(V1)

  echo
  echo ===== MC = $mc V =====
  tran 2p $&stop_time 0 2p

  * Measure ten input and ten output periods after settling.
  let span_in = 0
  let span_out = 0
  meas tran span_in TRIG v(CLK) VAL=1.65 RISE=1 TD=$&settle_time TARG v(CLK) VAL=1.65 RISE=11 TD=$&settle_time
  meas tran span_out TRIG v(Q6b) VAL=1.65 RISE=1 TD=$&settle_time TARG v(Q6b) VAL=1.65 RISE=11 TD=$&settle_time

  if span_in > 0
    if span_out > 0
      let input_Hz = 10/span_in
      let output_MHz = (10/span_out)/1e6
      let measured_division = span_out/span_in
      print input_Hz output_MHz measured_division

      * Check ten individual periods for irregular division.
      let edge = 1
      let period_min = 1
      let period_max = 0
      repeat 10
        let next_edge = edge + 1
        meas tran cycle_period TRIG v(Q6b) VAL=1.65 RISE=$&edge TD=$&settle_time TARG v(Q6b) VAL=1.65 RISE=$&next_edge TD=$&settle_time
        if cycle_period < period_min
          let period_min = cycle_period
        end
        if cycle_period > period_max
          let period_max = cycle_period
        end
        let edge = next_edge
      end

      let division_min = period_min*input_Hz
      let division_max = period_max*input_Hz
      print division_min division_max
    else
      echo OUTPUT PERIOD MEASUREMENT FAILED: inspect Q6b and the earlier stages.
    end
  else
    echo INPUT PERIOD MEASUREMENT FAILED: check V2 and the CLK net.
  end

  meas tran output_min MIN v(Q6b) FROM=$&settle_time TO=$&stop_time
  meas tran output_max MAX v(Q6b) FROM=$&settle_time TO=$&stop_time

  meas tran supply_current AVG i(V1) FROM=$&settle_time TO=$&stop_time
  let supply_power_mW = -3.3*supply_current*1000
  print supply_power_mW

  plot v(CLK) v(Q1) v(Q2) v(Q3) xlimit $&settle_time $&zoom_end
  plot v(Q3) v(Q4b) v(Q5b) v(Q6b) xlimit $&settle_time $&stop_time

  wrdata prescaler_MC\{$mc\}.txt v(CLK) v(Q1) v(Q2) v(Q3) v(Q4b) v(Q5b) v(Q6b) i(V1)
end
.endc
"}
C {lab_pin.sym} -1000 -50 0 0 {name=p23 sig_type=std_logic lab=Q3n}
C {lab_pin.sym} 560 -50 0 1 {name=p9 sig_type=std_logic lab=Q3n}
C {lab_pin.sym} -630 -220 0 0 {name=p19 sig_type=std_logic lab=Q3n}
C {2_input_nor.sym} -440 -210 0 0 {name=x7}
