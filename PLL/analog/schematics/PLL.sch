v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -1250 -180 -970 -180 {lab=#net1}
N -1250 -180 -1250 10 {lab=#net1}
N -1040 -140 -970 -140 {lab=#net2}
N -1040 -310 -1040 -140 {lab=#net2}
N -1040 -310 -620 -310 {lab=#net2}
N -620 -310 -620 -210 {lab=#net2}
N -620 -210 -580 -210 {lab=#net2}
N -630 -130 -580 -130 {lab=#net3}
N -630 -300 -630 -130 {lab=#net3}
N -1030 -300 -630 -300 {lab=#net3}
N -1030 -300 -1030 -200 {lab=#net3}
N -1030 -200 -970 -200 {lab=#net3}
N -570 50 470 50 {lab=#net4}
N -570 50 -570 170 {lab=#net4}
N -570 170 -530 170 {lab=#net4}
N -1020 210 -530 210 {lab=#net5}
N -1020 -160 -1020 210 {lab=#net5}
N -1020 -160 -970 -160 {lab=#net5}
N 470 50 470 300 {lab=#net4}
N 400 300 470 300 {lab=#net4}
N 420 -180 420 280 {lab=#net6}
N 400 280 420 280 {lab=#net6}
N -170 170 10 170 {lab=#net7}
N 10 170 10 270 {lab=#net7}
N 10 270 100 270 {lab=#net7}
N -650 -340 -650 -220 {lab=#net8}
N -650 -340 220 -340 {lab=#net8}
N 360 -340 360 -220 {lab=#net8}
N -280 -220 -230 -220 {lab=#net8}
N -230 -340 -230 -220 {lab=#net8}
N -170 370 -110 370 {lab=#net8}
N -110 0 -110 370 {lab=#net8}
N -110 0 450 0 {lab=#net8}
N 450 -340 450 0 {lab=#net8}
N 220 -340 450 -340 {lab=#net8}
N 60 250 100 250 {lab=#net8}
N 60 0 60 250 {lab=#net8}
N -170 410 -20 410 {lab=0}
N -20 330 -20 410 {lab=0}
N -20 330 100 330 {lab=0}
N -280 -120 180 -120 {lab=0}
N -20 -120 -20 330 {lab=0}
N -650 -100 -220 -100 {lab=0}
N -220 -120 -220 -100 {lab=0}
N -1150 -340 -650 -340 {lab=#net8}
N -1150 -340 -1150 -110 {lab=#net8}
N -1150 -50 -1150 540 {lab=0}
N -1150 540 -20 540 {lab=0}
N -20 410 -20 540 {lab=0}
N 310 -180 420 -180 {lab=#net6}
N 310 -220 360 -220 {lab=#net8}
N 180 -120 320 -120 {lab=0}
N 320 -140 320 -120 {lab=0}
N 310 -140 320 -140 {lab=0}
N -280 -160 10 -160 {lab=#net9}
N 0 -160 10 -160 {lab=#net9}
N 0 -200 -0 -160 {lab=#net9}
N -10 -200 -0 -200 {lab=#net9}
N -10 -180 -10 -120 {lab=0}
N -670 -220 -650 -220 {lab=#net8}
N -650 -120 -650 -100 {lab=0}
N -670 -120 -650 -120 {lab=0}
C {fractional_32_33.sym} -350 130 0 1 {name=x1}
C {32_33_Prescaler_Block.sym} 250 290 0 1 {name=x2}
C {Ring_Oscillator_Block.sym} 160 -180 0 0 {name=x3}
C {Charge_Pump_FE_Block.sym} -430 -170 0 0 {name=x4}
C {crystal.sym} -1250 40 0 0 {name=X6
value=2MHz
footprint=CRYSTAL 300
device=CRYSTAL}
C {vsource.sym} -1150 -80 0 0 {name=V1 value=3.3 savecurrent=false}
C {gnd.sym} -600 540 0 0 {name=l1 lab=0}
C {RC_Varactor.sym} -160 -190 0 0 {name=x7}
C {Phase_Detector_Block.sym} -820 -170 0 0 {name=x5}
