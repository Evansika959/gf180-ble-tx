#!/usr/bin/env python3
"""Generate the GF180 MIM-capacitor core of the capacitive DAC.

This script intentionally ignores voltage sources, .control statements, the
load capacitor, and the INV testbench instances in the xschem-generated SPICE
file.  Those are not part of a passive capacitor-array layout.  It extracts
only ``cap_mim_2f0fF`` instances and creates a pin for the common plate and for
each bit plate.

Run this inside the IIC-OSIC-TOOLS container, where KLayout's Python module is
available::

    cd /foss/designs/gf180-ble-tx/analog/dac
    python3 generate_dac_gds.py capacitive_dac.spice

Outputs:
  * capacitive_dac_core.gds
  * capacitive_dac_core_lvs.spice

The geometry targets gf180mcu MIM option A (``cap_mim_2f0fF``): Metal2 bottom
plate, FuseTop top plate, Via2 to Metal3, CAP_MK, and MIM_L_MK.  It is a
deterministic starting layout, not a replacement for PDK DRC/LVS and analog
matching review.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path

try:
    import klayout.db as kdb
except ImportError as exc:
    raise SystemExit(
        "KLayout's Python module is missing. Run this script inside the "
        "IIC-OSIC-TOOLS container (python3 has klayout.db there)."
    ) from exc


MODEL = "cap_mim_2f0fF"
DBU_UM = 0.001

# GF180MCU GDS layers used by the 2 fF/um^2 M2-M3 MIM capacitor.
LAYER_METAL2 = (36, 0)
LAYER_METAL2_LABEL = (36, 10)
LAYER_VIA2 = (38, 0)
LAYER_METAL3 = (42, 0)
LAYER_METAL3_LABEL = (42, 10)
LAYER_FUSETOP = (75, 0)
LAYER_CAP_MK = (117, 5)
LAYER_MIM_L_MK = (117, 10)

# Conservative values derived from the open GF180 MIM-option-A rule deck.
BOTTOM_ENC_UM = 1.20
CAP_GAP_UM = 5.00
VIA_SIZE_UM = 0.26
VIA_SPACE_UM = 0.50
VIA_TOP_ENC_UM = 0.40
ROUTE_WIDTH_UM = 1.20
PIN_LENGTH_UM = 10.00
BUS_CLEARANCE_UM = 6.00


@dataclass(frozen=True)
class MimCap:
    instance: str
    common_net: str
    bit_net: str
    width_um: float
    length_um: float

    @property
    def area_um2(self) -> float:
        return self.width_um * self.length_um


def spice_number_to_um(value: str) -> float:
    """Parse a SPICE length and return micrometres.

    Xschem emitted SI values (for example 5e-6), but common SPICE suffixes are
    accepted as well so the generator remains useful after schematic edits.
    """

    text = value.strip().lower()
    match = re.fullmatch(
        r"([+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:e[+-]?\d+)?)"
        r"(meg|mil|[tgkmunpf])?",
        text,
    )
    if not match:
        raise ValueError(f"unsupported SPICE number: {value!r}")

    number = float(match.group(1))
    suffix = match.group(2)
    scale = {
        None: 1.0,
        "t": 1e12,
        "g": 1e9,
        "meg": 1e6,
        "k": 1e3,
        "m": 1e-3,
        "u": 1e-6,
        "n": 1e-9,
        "p": 1e-12,
        "f": 1e-15,
        "mil": 25.4e-6,
    }[suffix]
    return number * scale * 1e6


def bit_index(net: str) -> tuple[int, str]:
    match = re.fullmatch(r"[bB](\d+)", net)
    return (int(match.group(1)), net) if match else (10**9, net.lower())


def parse_mim_caps(netlist: Path) -> list[MimCap]:
    caps: list[MimCap] = []
    line_re = re.compile(
        rf"^\s*(X\S+)\s+(\S+)\s+(\S+)\s+{MODEL}\b(.*)$",
        re.IGNORECASE,
    )
    param_re = re.compile(r"\b(c_width|c_length)\s*=\s*([^\s]+)", re.I)

    for line_number, raw_line in enumerate(netlist.read_text().splitlines(), 1):
        stripped = raw_line.lstrip()
        if not stripped or stripped.startswith(("*", ".")):
            continue
        match = line_re.match(raw_line)
        if not match:
            continue
        params = {key.lower(): value for key, value in param_re.findall(match.group(4))}
        missing = {"c_width", "c_length"} - params.keys()
        if missing:
            raise ValueError(
                f"{netlist}:{line_number}: missing {', '.join(sorted(missing))}"
            )
        cap = MimCap(
            instance=match.group(1),
            common_net=match.group(2),
            bit_net=match.group(3),
            width_um=spice_number_to_um(params["c_width"]),
            length_um=spice_number_to_um(params["c_length"]),
        )
        if cap.width_um < 5.0 or cap.length_um < 5.0:
            raise ValueError(
                f"{netlist}:{line_number}: {cap.instance} is smaller than 5 um; "
                "its area may violate GF180 MIM.8a (minimum 25 um^2)"
            )
        if cap.area_um2 < 25.0 or cap.area_um2 > 10_000.0:
            raise ValueError(
                f"{netlist}:{line_number}: {cap.instance} area "
                f"{cap.area_um2:g} um^2 is outside the GF180 25..10000 um^2 range"
            )
        caps.append(cap)

    if not caps:
        raise ValueError(f"no {MODEL} instances found in {netlist}")

    common_nets = {cap.common_net.lower() for cap in caps}
    if len(common_nets) != 1:
        raise ValueError(
            "all parsed MIM capacitors must share the first (common-plate) net; "
            f"found {sorted(common_nets)}"
        )
    bit_nets = [cap.bit_net.lower() for cap in caps]
    if len(set(bit_nets)) != len(bit_nets):
        raise ValueError("each direct-layout MIM capacitor must have a unique bit net")

    return sorted(caps, key=lambda cap: bit_index(cap.bit_net))


def db(value_um: float) -> int:
    return int(round(value_um / DBU_UM))


def box(x1: float, y1: float, x2: float, y2: float) -> kdb.Box:
    return kdb.Box(db(x1), db(y1), db(x2), db(y2))


def add_label(cell: kdb.Cell, layer: int, name: str, x: float, y: float) -> None:
    text = kdb.Text(name.upper(), kdb.Trans(kdb.Point(db(x), db(y))))
    text.text_size = db(1.0)
    cell.shapes(layer).insert(text)


def add_capacitor_cell(
    layout: kdb.Layout,
    cap: MimCap,
    layers: dict[str, int],
) -> tuple[kdb.Cell, float, float]:
    """Build one hierarchical capacitor and return cell and top-via centre."""

    safe_name = re.sub(r"[^A-Za-z0-9_]", "_", cap.bit_net.upper())
    cell = layout.create_cell(
        f"MIM_{safe_name}_{cap.width_um:g}x{cap.length_um:g}UM"
    )
    width = cap.width_um
    height = cap.length_um

    cell.shapes(layers["metal2"]).insert(
        box(-BOTTOM_ENC_UM, -BOTTOM_ENC_UM, width + BOTTOM_ENC_UM, height + BOTTOM_ENC_UM)
    )
    plate = box(0.0, 0.0, width, height)
    cell.shapes(layers["fusetop"]).insert(plate)
    cell.shapes(layers["cap_mk"]).insert(plate)
    cell.shapes(layers["mim_l_mk"]).insert(plate)

    pitch = VIA_SIZE_UM + VIA_SPACE_UM
    cluster_size = 2.0 * VIA_SIZE_UM + VIA_SPACE_UM
    via_x0 = (width - cluster_size) / 2.0
    via_y0 = height - VIA_TOP_ENC_UM - cluster_size
    if via_x0 < VIA_TOP_ENC_UM or via_y0 < VIA_TOP_ENC_UM:
        raise ValueError(f"{cap.instance} is too small for the 2x2 top-plate via array")
    for row in range(2):
        for column in range(2):
            x1 = via_x0 + column * pitch
            y1 = via_y0 + row * pitch
            cell.shapes(layers["via2"]).insert(
                box(x1, y1, x1 + VIA_SIZE_UM, y1 + VIA_SIZE_UM)
            )

    landing = VIA_TOP_ENC_UM
    cell.shapes(layers["metal3"]).insert(
        box(
            via_x0 - landing,
            via_y0 - landing,
            via_x0 + cluster_size + landing,
            via_y0 + cluster_size + landing,
        )
    )
    return cell, width / 2.0, via_y0 + cluster_size / 2.0


def write_lvs_netlist(path: Path, caps: list[MimCap], top_cell: str) -> None:
    common = caps[0].common_net.upper()
    bit_nets = [cap.bit_net.upper() for cap in caps]
    lines = [
        "* Generated by generate_dac_gds.py",
        "* Capacitor-array core only; inverter/testbench elements are excluded.",
        f".subckt {top_cell} {common} {' '.join(bit_nets)}",
    ]
    for cap in caps:
        capacitance_pf = cap.area_um2 * 2.0 / 1000.0
        perimeter_um = 2.0 * (cap.width_um + cap.length_um)
        lines.append(
            # The GF180 KLayout LVS deck extracts MIMs as primitive C devices,
            # not as the X-subcircuit syntax used by the simulation model.
            f"C{cap.instance} {common} {cap.bit_net.upper()} {capacitance_pf:g}p "
            f"{MODEL} A={cap.area_um2:g}p P={perimeter_um:g}u"
        )
    lines.extend([f".ends {top_cell}", ""])
    path.write_text("\n".join(lines))


def generate_layout(caps: list[MimCap], output: Path, top_cell_name: str) -> None:
    layout = kdb.Layout()
    layout.dbu = DBU_UM
    layers = {
        "metal2": layout.layer(*LAYER_METAL2),
        "metal2_label": layout.layer(*LAYER_METAL2_LABEL),
        "via2": layout.layer(*LAYER_VIA2),
        "metal3": layout.layer(*LAYER_METAL3),
        "metal3_label": layout.layer(*LAYER_METAL3_LABEL),
        "fusetop": layout.layer(*LAYER_FUSETOP),
        "cap_mk": layout.layer(*LAYER_CAP_MK),
        "mim_l_mk": layout.layer(*LAYER_MIM_L_MK),
    }
    top = layout.create_cell(top_cell_name)

    origin_y = PIN_LENGTH_UM + BOTTOM_ENC_UM
    max_height = max(cap.length_um for cap in caps)
    bus_y = origin_y + max_height + BOTTOM_ENC_UM + BUS_CLEARANCE_UM
    x_cursor = BOTTOM_ENC_UM
    placements: list[tuple[MimCap, float, float, float]] = []

    for cap in caps:
        cap_cell, via_x_local, via_y_local = add_capacitor_cell(layout, cap, layers)
        x_origin = x_cursor
        top.insert(kdb.CellInstArray(cap_cell.cell_index(), kdb.Trans(db(x_origin), db(origin_y))))
        route_x = x_origin + via_x_local
        via_y = origin_y + via_y_local
        placements.append((cap, x_origin, route_x, via_y))
        x_cursor += cap.width_um + 2.0 * BOTTOM_ENC_UM + CAP_GAP_UM

    layout_width = x_cursor - CAP_GAP_UM
    common_bus = box(
        0.0,
        bus_y - ROUTE_WIDTH_UM / 2.0,
        layout_width,
        bus_y + ROUTE_WIDTH_UM / 2.0,
    )
    top.shapes(layers["metal3"]).insert(common_bus)

    for cap, x_origin, route_x, via_y in placements:
        # Common top-plate route on Metal3.
        top.shapes(layers["metal3"]).insert(
            box(
                route_x - ROUTE_WIDTH_UM / 2.0,
                via_y,
                route_x + ROUTE_WIDTH_UM / 2.0,
                bus_y + ROUTE_WIDTH_UM / 2.0,
            )
        )

        # Individual bit-plate route on Metal2.
        pin_x = x_origin + cap.width_um / 2.0
        top.shapes(layers["metal2"]).insert(
            box(
                pin_x - ROUTE_WIDTH_UM / 2.0,
                0.0,
                pin_x + ROUTE_WIDTH_UM / 2.0,
                origin_y,
            )
        )
        add_label(top, layers["metal2_label"], cap.bit_net, pin_x, 0.5)

    add_label(top, layers["metal3_label"], caps[0].common_net, 1.0, bus_y)
    output.parent.mkdir(parents=True, exist_ok=True)
    layout.write(str(output))


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("netlist", type=Path, help="xschem-generated SPICE netlist")
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        help="output GDS (default: <netlist-dir>/capacitive_dac_core.gds)",
    )
    parser.add_argument(
        "--top-cell", default="capacitive_dac_core", help="GDS and LVS top-cell name"
    )
    args = parser.parse_args()

    netlist = args.netlist.resolve()
    output = (args.output or netlist.with_name("capacitive_dac_core.gds")).resolve()
    lvs_netlist = output.with_name(f"{args.top_cell}_lvs.spice")

    try:
        caps = parse_mim_caps(netlist)
        generate_layout(caps, output, args.top_cell)
        write_lvs_netlist(lvs_netlist, caps, args.top_cell)
    except (OSError, ValueError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2

    common = caps[0].common_net.upper()
    total_area = sum(cap.area_um2 for cap in caps)
    nominal_pf = total_area * 2.0 / 1000.0
    print(f"Wrote {output}")
    print(f"Wrote {lvs_netlist}")
    print(
        f"Parsed {len(caps)} {MODEL} devices: common={common}, "
        f"bits={','.join(cap.bit_net.upper() for cap in caps)}"
    )
    print(f"Total drawn MIM area: {total_area:g} um^2 (~{nominal_pf:g} pF nominal)")
    print("Next: run the official GF180 variant-A DRC and LVS before integration.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
