# gf180-ble-tx

A transmit-only Bluetooth Low Energy (1M PHY, 2.4 GHz GFSK) beacon on the
GF180MCU open PDK, built with open-source tools.

The chip sends legacy advertising packets that a phone BLE scanner can see.
An integer-N PLL generates the carrier. A 1 MHz reference drives a phase
detector, charge pump and RC loop filter. A differential VCO runs at half the
RF frequency, and a ×2 doubler brings its output to 2.402–2.480 GHz. A 32/33
prescaler and an integer-N divider close the feedback loop. A 6-bit `CFG` word
selects the BLE channel. The digital block receives packets over a 1 Mbaud
UART and produces a signed GFSK modulation word for the DAC.

The integrated top cell, `A01_topcell`, is in [build/](build/README.md). The
PLL block layouts are in [PLL/analog/](PLL/analog/README.md). The VCO supply
regulator, DAC, RF output stage, pad ring and metal fill are not integrated
yet. See [docs/plan.md](docs/plan.md) for the original project plan.

## Layout

| Folder     | Contents |
|------------|----------|
| `model/`   | Python golden model: packet build, CRC24, whitening, GFSK trajectory, decode |
| `em/`      | Inductor and passive EM models (OpenEMS, FastHenry2, gdsfactory) |
| `analog/`  | xschem schematics, ngspice/Xyce testbenches, layouts for DCO, PA, dividers |
| `digital/` | Verilog modulator, FLL calibration, SPI; cocotb tests; LibreLane config |
| `PLL/analog/` | Current PLL block layouts, extracted netlists and Xschem sheets |
| `build/`   | `A01_topcell` integration: assembled PLL and digital layout, netlists, LVS config, verification |
| `tapeout/` | Chip top-level in the shuttle template, DRC/LVS runs |
| `board/`   | KiCad bring-up board: crystal, RF match, antenna |

## PLL analog blocks (`PLL/analog/`)

This folder holds the current layouts and schematics for the PLL blocks. Each
block has a GDS and an extracted SPICE netlist. Details are in
[PLL/analog/README.md](PLL/analog/README.md).

| Folder | Block | Contents | Footprint |
|---|---|---|---:|
| [`vco/`](PLL/analog/vco) | Differential VCO, RF doubler and feedback buffer | Routed GDS, full-RC PEX | 41 × 30.175 µm |
| [`prescaler/`](PLL/analog/prescaler) | 32/33 dual-modulus prescaler | GDS, capacitance extraction | 33.195 × 21.74 µm |
| [`integer_n_divider/`](PLL/analog/integer_n_divider) | Integer-N feedback divider (digital, place-and-route) | GDS, LEF, DEF, RTL, routed Verilog, extracted SPICE, BLE channel table | 51.84 × 63.04 µm |
| [`phase_detector/`](PLL/analog/phase_detector) | Phase-frequency detector | GDS, capacitance extraction | 12.59 × 7.81 µm |
| [`charge_pump/`](PLL/analog/charge_pump) | Charge pump | GDS, capacitance extraction | 9.42 × 10.76 µm |
| [`schematics/`](PLL/analog/schematics) | Xschem sheets and symbols | Block sheets, standard-cell models, legacy `PLL.sch` | — |

- **VCO:** main DRC and LVS passed. The extracted VCO runs at 1.3072 GHz, and the doubler output is 2.6148 GHz.
- **Schematics:** open the sheets with Xschem, using the GF180MCU D symbol libraries and `schematics/` as the working directory. Device sizes in the schematics can differ from the extracted layouts.
- **Legacy sheet:** `PLL.sch` shows an earlier ring-oscillator and fractional-N architecture. The routed differential VCO and integer-N divider above replace it.

## Top-level integration (`build/`)

`build/` assembles the PLL blocks and the BLE UART/modulator into one top cell,
`A01_topcell`. It uses the six-metal GF180MCU E stack. The top level adds a
routed RC loop filter (41.3 kΩ poly resistor, 143.8 pF and 1.29 pF MIM
capacitors). Details, port list and rebuild commands are in
[build/README.md](build/README.md).

| Path | Contents |
|---|---|
| [`gds/`](build/gds) | `A01_topcell.gds` integrated layout, and `assembly.json` with macro placement, pin coordinates and source GDS hashes |
| [`schematics/`](build/schematics) | `A01_topcell.sch` Xschem assembly sheet and symbols for each block |
| [`spice/`](build/spice) | Simulation top, LVS source netlist, block PEX and the VCO supply regulator model |
| [`rtl/`](build/rtl) | `A01_digital.v`, the digital top that wraps the UART/modulator and the divider |
| [`timing/`](build/timing) | Min, nom and max SPEF parasitics for the routed divider |
| [`tech/`](build/tech) | Six-metal Magic tech file and its provenance |
| [`verification/`](build/verification) | DRC (main and antenna), LVS, connectivity, divider timing, behavioral and top-level SPICE reports |
| [`lvs_config.json`](build/lvs_config.json) | LVS configuration for `A01_topcell` |
| `*.py`, `*.tcl` | Build and check scripts: `generate_netlists.py`, `generate_schematic.py`, `assemble_layout.py`, `check_connectivity.py`, `verify_lvs.py`, `verify_behavior.py`, `verify_top_spice.py`, `check_divider_timing.tcl` |

The build script order is: generate the netlists and schematic, assemble the
layout, then run the LVS, behavioral, SPICE and timing checks. With a 1 MHz
reference and the ×2 doubler, `f_RF = 2 × (1184 + CFG) × 1 MHz`. `CFG` codes 17
through 56 cover BLE channels 2.402–2.480 GHz.

Not yet integrated: the VCO supply regulator (external for now), DAC, RF output
stage, pad ring and metal fill.

## Golden model

```sh
cd model
pip install -r requirements.txt
python ble_adv.py      # build and decode a "GF180-BLE" advertisement
pytest -q
```

## Tools

IIC-OSIC-TOOLS container with the `gf180mcuD` PDK, xschem, ngspice, Xyce,
KLayout, Magic, Netgen, OpenEMS, LibreLane, cocotb, Icarus Verilog.

## License

Apache-2.0
