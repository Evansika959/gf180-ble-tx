"""cocotb: ble_tx_uart (UART front end + ble_tx) against model/ble_adv.py.

The testbench drives the single uart_rx pin as a UART transmitter would (8N1,
LSB first), with bit edges not aligned to clk. Every packet is loaded, the
channel set and start pulsed over that pin only, and the codes are compared bit
for bit with the golden model.

Run: python test_ble_tx_uart.py              RTL, SPS=2, 8 and 16
     GL=1 SPS=8 python test_ble_tx_uart.py   gate level, digital/synth/ble_tx_uart_sps8.syn.v
"""

import os
import random
import sys
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, ReadOnly, RisingEdge, Timer

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parents[1] / "model"))

from ble_adv import (  # noqa: E402
    adv_nonconn_pdu,
    air_bits,
    complete_local_name,
    fine_codes,
    frequency_trajectory,
)

STEP_HZ = 2e3
CLKS_PER_BIT = 8   # RTL default
GAP_BITS = 20      # RTL default


def sps_of():
    return int(os.environ["TB_SPS"])


def clk_ps():
    return 1_000_000 // sps_of()


def bit_ps(err=0.0):
    """One UART bit at the chip's baud rate, off by err (0.03 = 3% slow)."""
    return round(CLKS_PER_BIT * clk_ps() * (1 + err))


# --------------------------------------------------------- UART transmitter
async def uart_bytes(dut, data, err=0.0, stop=None):
    """Send bytes back to back, 8N1. stop[i] = 0 sends byte i with a bad stop bit."""
    t = bit_ps(err)
    for i, byte in enumerate(data):
        frame = [0] + [(byte >> k) & 1 for k in range(8)] + [1 if stop is None else stop[i]]
        for b in frame:
            dut.uart_rx.value = b
            await Timer(t, unit="ps")
        dut.uart_rx.value = 1


async def pause(bits=GAP_BITS + 4):
    await Timer(bits * bit_ps(), unit="ps")


async def command(dut, data, err=0.0):
    """One command burst, then a gap long enough to end the frame."""
    await uart_bytes(dut, data, err)
    await pause()


async def write_pdu(dut, pdu, addr=0, err=0.0):
    await command(dut, [0x00 | addr] + list(pdu), err)


async def set_channel(dut, ch, err=0.0):
    await command(dut, [0x40 | ch], err)


async def capture(dut):
    """Codes and air bits of the next packet, from first to last code_valid."""
    codes, bits, cycles = [], [], 0
    while True:
        await RisingEdge(dut.clk)
        await ReadOnly()
        cycles += 1
        if int(dut.code_valid.value):
            codes.append(dut.fine_code.value.to_signed())
            if int(dut.sym_strobe.value):
                bits.append(int(dut.air_bit.value))
        elif codes:
            return bits, codes
        assert cycles < 600 * sps_of(), "packet never finished"


async def start_and_capture(dut, err=0.0):
    cap = cocotb.start_soon(capture(dut))
    await uart_bytes(dut, [0x81], err)
    bits, codes = await cap
    await RisingEdge(dut.clk)
    await ReadOnly()
    assert not int(dut.busy.value)
    await pause()
    return bits, codes


async def send(dut, pdu, channel, err=0.0):
    await write_pdu(dut, pdu, err=err)
    await set_channel(dut, channel, err)
    return await start_and_capture(dut, err)


def check(pdu, channel, bits, codes):
    sps = sps_of()
    want_bits = air_bits(pdu, channel)
    want_codes = list(fine_codes(frequency_trajectory(want_bits, sps), STEP_HZ))
    assert bits == want_bits, f"air bits differ (ch {channel}, len {len(pdu)})"
    assert len(codes) == len(want_codes), (len(codes), len(want_codes))
    bad = [i for i, (a, b) in enumerate(zip(codes, want_codes)) if a != b]
    assert not bad, f"{len(bad)} codes differ, first at sample {bad[0]}: {codes[bad[0]]} vs {want_codes[bad[0]]}"


def demo_pdu():
    addr = bytes.fromhex("C0FFEE180001")
    return adv_nonconn_pdu(addr, bytes([2, 0x01, 0x06]) + complete_local_name("GF180-BLE"))


def rand_pdu(rng, n):
    return adv_nonconn_pdu(bytes(rng.randrange(256) for _ in range(6)),
                           bytes(rng.randrange(256) for _ in range(n)),
                           tx_add_random=rng.random() < 0.5)


async def setup(dut):
    cocotb.start_soon(Clock(dut.clk, clk_ps(), unit="ps").start())
    dut.rst_n.value = 0
    dut.uart_rx.value = 1
    await ClockCycles(dut.clk, 3)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)
    await Timer(37_123, unit="ps")   # bit edges off the clock grid


# ---------------------------------------------------------------------- tests
@cocotb.test()
async def demo_packet_all_channels(dut):
    await setup(dut)
    pdu = demo_pdu()
    for ch in (37, 38, 39):
        bits, codes = await send(dut, pdu, ch)
        check(pdu, ch, bits, codes)


@cocotb.test()
async def random_packets(dut):
    await setup(dut)
    rng = random.Random(4)
    for n in list(range(0, 32, 5)) + [31] * 3:
        pdu = rand_pdu(rng, n)
        ch = rng.choice((37, 38, 39, rng.randrange(40)))
        bits, codes = await send(dut, pdu, ch)
        check(pdu, ch, bits, codes)


@cocotb.test()
async def baud_rate_off_by_3_percent(dut):
    """The sender's clock 3% slow, then 3% fast: every byte still lands."""
    await setup(dut)
    rng = random.Random(5)
    for err, ch in ((0.03, 37), (-0.03, 39)):
        pdu = rand_pdu(rng, 31)
        bits, codes = await send(dut, pdu, ch, err)
        check(pdu, ch, bits, codes)


@cocotb.test()
async def glitches_and_framing_errors(dut):
    """A short low pulse on the idle line is not a start bit, and a byte with
    a low stop bit is dropped without disturbing the bytes around it."""
    await setup(dut)
    rng = random.Random(6)
    pdu = rand_pdu(rng, 20)
    await write_pdu(dut, [rng.randrange(256) for _ in range(len(pdu))])   # junk
    await write_pdu(dut, pdu)
    # glitches shorter than half a bit
    for w in (1, CLKS_PER_BIT // 4, CLKS_PER_BIT // 2 - 2):
        dut.uart_rx.value = 0
        await Timer(max(w, 1) * clk_ps(), unit="ps")
        dut.uart_rx.value = 1
        await Timer(3 * bit_ps(), unit="ps")
    # overwrite payload byte 2 with a bad stop bit: must be dropped
    await uart_bytes(dut, [0x04, 0xA5], stop=[1, 0])
    await pause()
    # a start command with a bad stop bit: must not start
    await uart_bytes(dut, [0x81], stop=[0])
    await pause()
    assert not int(dut.busy.value)
    await set_channel(dut, 38)
    bits, codes = await start_and_capture(dut)
    check(pdu, 38, bits, codes)


@cocotb.test()
async def frame_gap(dut):
    """A pause shorter than the gap keeps a burst going; a long one starts a new
    command, so a PDU can be loaded in pieces at explicit addresses."""
    await setup(dut)
    rng = random.Random(7)
    pdu = rand_pdu(rng, 25)
    # one burst with a 1.5-byte pause inside: still contiguous
    await uart_bytes(dut, [0x00] + list(pdu[:10]))
    await pause(15)
    await uart_bytes(dut, list(pdu[10:20]))
    await pause()
    # new frame: the rest from address 20
    await write_pdu(dut, pdu[20:], addr=20)
    await set_channel(dut, 37)
    bits, codes = await start_and_capture(dut)
    check(pdu, 37, bits, codes)
    # busy rises within a bit time of the start byte's stop bit, before any code
    cap = cocotb.start_soon(capture(dut))
    await uart_bytes(dut, [0x81])
    for _ in range(CLKS_PER_BIT):
        await RisingEdge(dut.clk)
        await ReadOnly()
        if int(dut.busy.value):
            break
    assert int(dut.busy.value), "busy did not rise after start"
    assert not int(dut.code_valid.value)
    await cap


@cocotb.test()
async def reset_mid_packet(dut):
    """Reset while a packet is on air: busy, code_valid and fine_code drop at once,
    the channel goes back to 37, and the PDU buffer (not reset) can be sent again
    without reloading."""
    await setup(dut)
    pdu = demo_pdu()
    await write_pdu(dut, pdu)
    await set_channel(dut, 39)
    await uart_bytes(dut, [0x81])
    while not int(dut.busy.value):
        await RisingEdge(dut.clk)
    await ClockCycles(dut.clk, 100 * sps_of())
    dut.rst_n.value = 0
    await RisingEdge(dut.clk)
    await ReadOnly()
    assert not int(dut.busy.value) and not int(dut.code_valid.value)
    assert dut.fine_code.value.to_signed() == 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)
    bits, codes = await start_and_capture(dut)          # channel is 37 after reset
    check(pdu, 37, bits, codes)


@cocotb.test()
async def reset_mid_byte(dut):
    """Reset while a UART byte is half received: the byte is lost, nothing is
    written or started, and the next frame is taken as a command."""
    await setup(dut)
    pdu = demo_pdu()
    await write_pdu(dut, pdu)
    stray = cocotb.start_soon(uart_bytes(dut, [0x81]))  # a start command...
    await Timer(4 * bit_ps(), unit="ps")                # ...cut off mid-byte
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    await stray
    await pause()
    assert not int(dut.busy.value), "a half-received start byte started a packet"
    await set_channel(dut, 38)
    bits, codes = await start_and_capture(dut)
    check(pdu, 38, bits, codes)


@cocotb.test()
async def idle_outputs_quiet(dut):
    """With nothing sent, and again after a packet, the outputs hold still: busy,
    code_valid, sym_strobe low and fine_code 0, with no UART traffic."""
    await setup(dut)

    async def quiet(cycles):
        for _ in range(cycles):
            await RisingEdge(dut.clk)
            await ReadOnly()
            assert not int(dut.busy.value) and not int(dut.code_valid.value)
            assert not int(dut.sym_strobe.value)
            assert dut.fine_code.value.to_signed() == 0
        await Timer(1, unit="ns")                       # leave the read-only phase
    await quiet(200 * CLKS_PER_BIT)
    pdu = demo_pdu()
    await write_pdu(dut, pdu)
    await quiet(10 * CLKS_PER_BIT)                      # loading alone sends nothing
    await set_channel(dut, 37)
    bits, codes = await start_and_capture(dut)
    check(pdu, 37, bits, codes)
    await quiet(200 * CLKS_PER_BIT)


def run(sps, gl=False):
    from cocotb_tools.runner import get_runner

    digital = HERE.parent
    if gl:
        cells = Path(os.environ["PDK_ROOT"]) / "gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/verilog"
        sources = [cells / "primitives.v", cells / "gf180mcu_fd_sc_mcu7t5v0.v",
                   digital / "synth" / f"ble_tx_uart_sps{sps}.syn.v"]
        params, defines, tag = {}, {"FUNCTIONAL": 1, "UNIT_DELAY": "#1"}, f"uart_gl_sps{sps}"
    else:
        sources = [digital / "rtl" / "ble_uart.v", digital / "rtl" / "ble_tx.v",
                   digital / "rtl" / "ble_gauss_lut.v"]
        params, defines, tag = {"SPS": sps}, {}, f"uart_sps{sps}"
    build = HERE / f"sim_build_{tag}"
    runner = get_runner("icarus")
    runner.build(sources=sources, hdl_toplevel="ble_tx_uart", parameters=params,
                 defines=defines, build_dir=build, always=True, timescale=("1ns", "1ps"))
    runner.test(hdl_toplevel="ble_tx_uart", test_module="test_ble_tx_uart", test_dir=HERE,
                build_dir=build, results_xml=HERE / f"results_{tag}.xml",
                extra_env={"TB_SPS": str(sps)})


def test_uart_sps2():
    run(2)


def test_uart_sps8():
    run(8)


def test_uart_sps16():
    run(16)


if __name__ == "__main__":
    for s in [int(x) for x in os.environ.get("SPS", "2 8 16").split()]:
        run(s, gl=bool(os.environ.get("GL")))
