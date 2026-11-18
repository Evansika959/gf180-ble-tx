# Digital modulator

`ble_tx` turns a legacy advertising PDU into a stream of signed 8-bit DAC
codes for the PLL's modulation input: preamble, access address, PDU and CRC24 (whitened), Gaussian filtered
(BT = 0.5), one code per clock. It matches `model/ble_adv.py` bit for bit:

```python
air_bits(pdu, channel)                                    # air_bit at each sym_strobe
fine_codes(frequency_trajectory(bits, SPS), 2e3)          # fine_code while code_valid
```

| File | Contents |
|------|----------|
| `rtl/ble_tx.v` | Top: PDU buffer, bit sequencer, CRC24, whitening, filter window |
| `rtl/ble_gauss_lut.v` | Generated Gaussian LUT (do not edit) |
| `rtl/ble_uart.v` | UART receiver and command decoder `ble_uart`, and the chip-level top `ble_tx_uart` (UART + `ble_tx`) |
| `scripts/gen_gauss_lut.py` | Regenerates the LUT from the model (`--step-hz`, `--sps`, `--width`) |
| `test/test_ble_tx.py` | cocotb: compares RTL or gate-level netlist against the model |
| `test/test_ble_tx_uart.py` | cocotb: the same through the single UART pin, RTL or gate level |
| `synth/synth.tcl` | Quick Yosys synthesis onto `gf180mcu_fd_sc_mcu7t5v0` |
| `librelane/config.yaml` | LibreLane RTL-to-GDS flow |

## Interface

Write the PDU bytes (`header0`, `length`, payload) with `wr_en`/`wr_addr`/`wr_data`,
set `channel`, pulse `start`. The length byte is latched at `start`; payload
bytes are read live, so only rewrite ones already sent. `busy` stays high
until the last code is out. The
first code arrives 2 symbols + 1 clock after `start`, because each output
sample needs the symbols up to 1.5 symbols ahead.

`SPS` is the clock in MHz (samples per 1 us symbol). The default is 8: an
8 MHz clock gives one code per clock for the 8 MS/s DAC. SPS 2 and 16 are also
generated and tested. Codes are 8-bit signed, 2 kHz/LSB, range -125..125
(+-250 kHz deviation); the DAC and VCO modulation gain set the real Hz/LSB.

## Serial interface (`ble_tx_uart`)

`ble_tx_uart` puts a UART receiver in front of `ble_tx`, so the chip takes its
packet, channel and start over one input pin, `uart_rx`. Any MCU UART TX pin or
a USB-serial adapter can drive it. It is the only connection to the controller:
there is no read path and no `busy` pin. A packet's air time is fixed by its
length, so once the start byte has been sent, wait `(10 + len) x 8 + 10` us
(`len` = the PDU's length byte), or 400 us for any packet, before loading the
next PDU or starting again. A start sent while a packet is on air is ignored, and
a PDU written then can corrupt the packet on air.

`uart_rx` is standard 8N1: idle high, a low start bit, 8 data bits LSB first, a
high stop bit. A bit lasts `CLKS_PER_BIT` clocks (default 8), so the baud rate
is clk/8: 1 Mbaud at SPS=8, 250 kbaud at SPS=2, 2 Mbaud at SPS=16. The
receiver samples the middle of each bit and resynchronizes on every start bit,
so the sender may be about 3% off. Pulses shorter than half a bit are ignored
and a byte with a low stop bit is dropped.

A pause marks where a command starts: once the line has been idle for
`GAP_BITS` bit times (default 20, 20 us at 1 Mbaud), the next byte is a command.
Send each command as one burst, then pause.

| Command | Data | Action |
|---------|------|--------|
| `00aa_aaaa` | `d0 d1 ...` | Write PDU bytes from address `a` (0 = header0, 1 = length, 2.. = payload); the address increments |
| `01cc_cccc` | none | `channel = c` (latched by `ble_tx` at start; 37 after reset) |
| `1xxx_xxxs` | none | `s = 1` pulses `start` |

A full 39-byte PDU loads in about 0.4 ms at 1 Mbaud. From Python:

```python
import serial, time
s = serial.Serial("/dev/tty.usbserial", 1_000_000)
s.write(bytes([0x00]) + pdu); time.sleep(0.001)   # PDU from address 0
s.write(bytes([0x40 | 37]));  time.sleep(0.001)   # channel 37
s.write(bytes([0x81])); s.flush()                 # start
time.sleep(400e-6)                                # on air; then the next packet
```

`fine_code`, `code_valid`, `air_bit` and `sym_strobe` come straight out of
`ble_tx`, as described above; its `busy` stays inside the block.

## Running (IIC-OSIC-TOOLS container, from `/foss/designs/gf180-ble-tx/digital`)

```sh
python3 scripts/gen_gauss_lut.py                          # only after changing step/SPS
cd test && python3 test_ble_tx.py                         # RTL, SPS=2, 8 and 16
python3 test_ble_tx_uart.py                               # the same through the UART pin
cd ../synth && SPS=8 yosys -c synth.tcl                   # netlist + area report
cd ../test && GL=1 SPS=8 python3 test_ble_tx.py           # gate-level sim of that netlist
cd ../synth && TOP=ble_tx_uart SPS=8 yosys -c synth.tcl   # with the UART front end
cd ../test && GL=1 SPS=8 python3 test_ble_tx_uart.py
cd ../librelane && librelane --manual-pdk --pdk-root $PDK_ROOT --pdk gf180mcuD \
    --scl gf180mcu_fd_sc_mcu7t5v0 config.yaml
```

## Pre-layout timing

`sta/sta.tcl` runs OpenSTA on the Yosys netlist at the ss_125C_4v50,
tt_025C_5v00 and ff_n40C_5v50 corners with the constraints in
`sta/ble_tx.sdc`: 8 MHz clock (period from `SPS`, or `CLOCK_PERIOD` in ns),
30% of the period for I/O on each side, 1 ns setup / 0.25 ns hold uncertainty
for the ideal clock, and the 3 ns max-slew limit LibreLane signs off against.
There are no wire parasitics yet, so expect post-layout slack to be a few ns
lower.

```sh
cd synth && SPS=8 yosys -c synth.tcl          # netlist
cd ../sta && SPS=8 sta -exit sta.tcl          # worst slack per corner + sta/reports/sta_sps8.rpt
```
