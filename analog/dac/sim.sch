v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -50 -20 -0 -20 {lab=vin}
N 115 -20 150 -20 {lab=vout}
C {INV.sym} 40 -20 0 0 {name=x1}
C {code_shown.sym} 190 -50 0 0 {name=s1 only_toplevel=false value="
.include /foss/pdks/gf180mcuD/libs.tech/ngspice/design.ngspice

.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical

.lib /foss/pdks/gf180mcuD/libs.tech/ngspice/sm141064.ngspice mimcap_typical

.control
tran 1n 30u
plot v(Vout) v(vin)
.endc

"
}
C {vsource.sym} -50 10 0 0 {name=V1 value="PULSE(0 3.3 4u 1n 1n 4u 8u)" savecurrent=false}
C {gnd.sym} -50 40 0 0 {name=l1 lab=0}
C {capa.sym} 150 10 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 150 40 0 0 {name=l2 lab=0}
C {lab_wire.sym} 130 -20 0 0 {name=p1 sig_type=std_logic lab=vout}
C {lab_wire.sym} -20 -20 0 0 {name=p2 sig_type=std_logic lab=vin}
