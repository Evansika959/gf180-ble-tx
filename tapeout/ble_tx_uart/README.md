# ble_tx_uart layout (n12)

The signed-off layout of `ble_tx_uart`: the BLE advertising modulator (`ble_tx`)
with its one-pin UART front end (`ble_uart`), on gf180mcuD,
`gf180mcu_fd_sc_mcu7t5v0`, 5 metal layers. This is a block for the chip's top
level, not a full chip: it has no pad ring and no metal fill.

| | |
|---|---|
| Die | 270 x 300 um (81,000 um2) |
| Standard cells | 62,835 um2, 86.8% utilisation |
| Clock | 8 MHz (`clk`, 125 ns) |
| Power | about 1.57 mW, measured from an advertising packet loaded over `uart_rx` |
| Setup / hold slack, worst of 9 corners | +98.4 ns / +0.18 ns |
| Pins | in: `clk`, `rst_n`, `uart_rx`; out: `busy`, `fine_code[7:0]`, `code_valid`, `air_bit`, `sym_strobe` |
| GDS sha256 (first 16) | `88a26ebeba105614` |

## Where it came from

- RTL: `digital/rtl/ble_uart.v`, `ble_tx.v`, `ble_gauss_lut.v` at commit b6bdaa2
  (the lint-only change after layout was proven equivalent with Yosys `equiv_*`).
- Flow: `digital/agent`, design `designs/ble_tx_uart`. The search `runs/uart_s1`
  (20 runs) picked node n12; its settings are now that design's `config.yaml`, so
  `python -m pd.baseline --design designs/ble_tx_uart` lays it out again.
- Signoff took three driver-upsizing passes (`upsized_drivers.txt`).

## What it passed

- Foundry KLayout DRC deck (`libs.tech/klayout/tech/drc`, variant D, 51 rule tables,
  front and back end): 0. Magic DRC 0, routing DRC 0, antenna 0.
- Netgen LVS 0; KLayout vs Magic GDS XOR 0.
- Max slew, capacitance and fanout: 0 at every corner. IR drop 0.07 mV worst.
- `metrics.json` lists `timing__drv__floating__nets` 2: LibreLane takes it from
  the repair step after placement; the final database and netlist have none. Its 26
  unannotated nets are the clock tree's `clkload` dummy cells, outputs unused.
- `digital/test/test_ble_tx_uart.py` (8 tests) on `nl/ble_tx_uart.nl.v`: with
  unit delay, and with `sdf/` at max_ss_125C_4v50 and max_ff_n40C_5v50. Icarus
  needs the SDF's INTERCONNECT entries dropped and the escaped instance names
  (`u_tx\.g_pdu\[9\]...`) renamed in netlist and SDF alike before it annotates
  every cell.

## Files

| Folder | |
|---|---|
| `gds/` | the layout |
| `def/`, `lef/` | placement and routing; abstract for the top level |
| `lib/` | timing models at the 9 corners |
| `nl/` | netlist (`.nl.v`), with power pins (`.pnl.v`), black-box header (`.vh`) |
| `sdc/` | constraints |
| `spef/` | parasitics, nominal corner |
| `sdf/` | delays at the slow and fast corners |
| `spice/` | extracted netlist used for LVS |
| `render/` | picture of the layout |
| `metrics.json` | every signoff figure |

Left out, as they can be made again from the config: the Magic and KLayout copies
of the GDS, the OpenROAD database, SPEF and SDF at the other corners.
