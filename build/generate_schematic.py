"""Create the Xschem assembly sheet from the same circuit as the SPICE top."""
from design import HERE, PORTS, TOP, logical_lines, subckt


HEADER = "v {xschem version=3.4.8RC file_version=1.2}"
BODY = ["G {}","K {}","V {}","S {}","F {}","E {}"]
SPICE = HERE/"spice"
OUT = HERE/"schematics"
CAPTIONS = {
    "vco":"Differential VCO and x2", "prescaler":"32/33 prescaler", "divider":"Integer-N divider",
    "pfd":"Phase detector", "pump":"Charge pump", "loop":"MIM loop filter", "tx":"BLE UART and modulator",
}
POSITIONS = {
    "vco":(0,160), "prescaler":(480,160), "divider":(960,160),
    "loop":(0,540), "pump":(480,540), "pfd":(960,540),
    "tx":(480,900),
}


def symbol(name, model, pins):
    left = (len(pins)+1)//2
    half_h = 10*left+12
    lines = [HEADER, "G {}",
             'K {type=subcircuit\nformat="@name @pinlist '+model+'"\n'
             'template="name=X1"\nspice_sym_def="* Definition in blocks_pex.spice"\n}',
             "V {}","S {}","E {}",
             f"B 4 -110 {-half_h} 110 {half_h} {{}}",
             f"T {{{CAPTIONS[name]}}} -105 {-half_h-28} 0 0 0.3 0.3 {{}}"]
    locations = []
    for number, pin_name in enumerate(pins):
        side = -1 if number<left else 1
        y = (number%left)*20-10*(left-1)
        x = side*130
        lines += [f'B 5 {x-2.5} {y-2.5} {x+2.5} {y+2.5} '
                  f'{{name="{pin_name}" dir=inout pinnumber={number+1}}}',
                  f"L 4 {side*110} {y} {x} {y} {{}}",
                  f"T {{{pin_name}}} {side*103} {y-7} 0 {int(side>0)} 0.17 0.17 {{}}"]
        locations.append((x,y))
    (OUT/f"{name}.sym").write_text("\n".join(lines)+"\n")
    return locations


def main():
    OUT.mkdir(exist_ok=True)
    lines = [HEADER,*BODY]
    lines += ["T {BLE transmitter and 1 MHz PLL integration} -160 -105 0 0 0.52 0.52 {}",
              "T {High-impedance external regulator: VCTRL input, VDD_VCO output} -160 -63 0 0 0.29 0.29 {}",
              "T {FINE_CODE and CODE_VALID are the digital modulation interface} -160 -39 0 0 0.29 0.29 {}"]
    for i, port in enumerate(PORTS):
        x = -210+(i//11)*390
        y = 1190+(i%11)*25
        lines.append(f"C {{iopin.sym}} {x} {y} 0 0 {{name=p{i+1} lab={port}}}")
    lines.append('C {code_shown.sym} -185 1040 0 0 {name=MACROMODELS only_toplevel=false value=".include ../spice/blocks_pex.spice"}')
    for line in logical_lines(SPICE/f"{TOP}.spice"):
        fields = line.split()
        if fields[0][0]!="X":continue
        name,model = fields[0][1:], fields[-1]
        x,y = POSITIONS[name]
        pins = subckt(SPICE/"blocks_pex.spice", model)
        places = symbol(name,model,pins)
        lines.append(f"C {{{name}.sym}} {x} {y} 0 0 {{name=X{name}}}")
        for i, ((dx,dy), net) in enumerate(zip(places,fields[1:-1],strict=True)):
            xx, yy = x+dx, y+dy
            outside = xx+(40 if dx>0 else -40)
            lines += [f"N {min(xx,outside)} {yy} {max(xx,outside)} {yy} {{lab={net}}}",
                      f"C {{lab_pin.sym}} {outside} {yy} 0 {int(dx>0)} {{name=L_{name}_{i} lab={net}}}"]
    (OUT/f"{TOP}.sch").write_text("\n".join(lines)+"\n")


if __name__=="__main__":
    main()
