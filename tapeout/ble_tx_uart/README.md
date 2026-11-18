# ble_tx_uart layout

The signed-off layout of `ble_tx_uart`: the BLE advertising modulator (`ble_tx`)
with its one-pin UART front end (`ble_uart`), on gf180mcuD,
`gf180mcu_fd_sc_mcu7t5v0`, 5 metal layers. This is a block for the chip's top
level, not a full chip: it has no pad ring and no metal fill.

| | |
|---|---|
| Die | 270 x 300 um (81,000 um2) |
| Standard cells | 62,980 um2, 87.0% utilisation |
| Clock | 8 MHz (`clk`, 125 ns) |
| Power | 1.59 mW measured from an advertising packet loaded over `uart_rx` (53% clock network, 34% flip-flops, 13% logic) |
| Setup / hold slack, worst of 9 corners | +100.5 ns / +0.22 ns |
| GDS sha256 (first 16) | `6d3a942b6f74986a` |

## Pins

| Pin | Dir | |
|---|---|---|
| `clk` | in | 8 MHz clock |
| `rst_n` | in | reset, active low |
| `uart_rx` | in | 8N1 serial from the controller at clk/8 (1 Mbaud): the only controller connection |
| `fine_code[7:0]` | out | signed Gaussian-filtered frequency code, one per clock (to the DAC / oscillator) |
| `code_valid` | out | high while `fine_code` belongs to a packet |
| `air_bit` | out | the raw bit on air (test) |
| `sym_strobe` | out | first clock of each 1 us symbol (test) |
| `VDD`, `VSS` | power | |

There is no `busy` pin. A packet's air time is fixed by its length: once the start
byte has been sent, the controller waits `(10 + len) x 8 + 10` us, or 400 us for any
packet, before loading the next PDU (`digital/README.md`).

## Where it came from

- RTL: `digital/rtl/ble_uart.v`, `ble_tx.v`, `ble_gauss_lut.v`, the commit that
  removed the busy pin.
- Flow: `digital/agent`, design `designs/ble_tx_uart`, whose `config.yaml` gives
  this layout: `python -m pd.baseline --design designs/ble_tx_uart` lays it out
  again. The settings are those of the first search's answer (runs/uart_s1 n12)
  with the slew margin raised from 22 to 26, since 22 left two slow-corner slew
  violations on this netlist.
- Signoff took five driver-upsizing passes (`upsized_drivers.txt`, 18 drivers).

## What it passed

- Foundry KLayout DRC deck (`libs.tech/klayout/tech/drc`, variant D, 51 rule tables,
  558 rules, front and back end): 0. Magic DRC 0, routing DRC 0, antenna 0.
- Netgen LVS 0; KLayout vs Magic GDS XOR 0.
- Max slew, capacitance and fanout: 0 at every corner. IR drop 0.08 mV worst.
- `metrics.json` lists `timing__drv__floating__nets` from the repair step after
  placement; the final database has no floating net. Its 22 unannotated nets are the
  clock tree's `clkload` dummy cells, whose outputs are unused by design.
- `digital/test/test_ble_tx_uart.py` (9 tests, including the controller's fixed
  wait) on `nl/ble_tx_uart.nl.v`: with unit delay, and with `sdf/` at
  max_ss_125C_4v50 and max_ff_n40C_5v50, every one of the 1,984 cells annotated.
  Icarus needs the SDF's INTERCONNECT entries dropped and the escaped instance
  names (`u_tx\.g_pdu\[9\]...`) renamed in netlist and SDF alike for that.

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
