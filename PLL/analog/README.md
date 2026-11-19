# PLL analog layouts and schematics

| Block | Files | Footprint |
|---|---|---:|
| Differential VCO, doubler, feedback buffer | Routed GDS and full-RC PEX | 41 × 30.175 µm |
| Charge pump, shared-diffusion revision 3 | Repaired GDS and capacitance extraction | 9.42 × 10.76 µm |
| Phase detector | Repaired GDS and capacitance extraction | 12.59 × 7.81 µm |
| 32/33 prescaler, compact | Repaired GDS and capacitance extraction | 33.195 × 21.74 µm |
| Integer-N divider | Routed GDS, LEF, DEF, RTL, routed Verilog and extracted SPICE | 51.84 × 63.04 µm |

The VCO is `glayout_diffbuf_opt_20261119T035353Z/candidate_0017`. Main DRC and LVS passed. The extracted run measured 1.3072 GHz at the core and 2.6148 GHz at the doubler. The selected candidate is still outside the optimizer targets.

## Xschem

Open the sheets in `schematics/` using Xschem with the GF180MCU D symbol libraries configured and the working directory set to `schematics/`. The included block sheets and symbols have local references. The VCO schematic uses the corrected seven-device receiver sheet. Device dimensions in the schematics can differ from the extracted layouts.

`PLL.sch` is the existing system schematic. It shows an earlier ring oscillator and fractional-controller architecture. The separately included differential VCO and integer-N divider are the current routed blocks. Their schematic integration and complete PLL signoff remain separate work.

The current extracted phase detector and charge pump were tested together at 1 MHz. The included divider is the routed RTL revision originally built for the 500 kHz plan with a 600–620 MHz input. Confirm the division plan, timing, and common metal stack at integration. The loop-filter schematic is included. Its proposed MIM replacement has no routed layout in this snapshot.

The four current block schematics netlisted successfully in Xschem. The legacy PLL sheet emits a netlist and returns Xschem status 10, also reproduced on the original sheet.
