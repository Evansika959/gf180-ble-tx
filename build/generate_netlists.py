"""Generate top-level SPICE and layout-LVS sources from the interface map."""
import json
from pathlib import Path

from design import (C1_UM, C2_COUNT, C2_LENGTH_UM, C2_TILES, C2_WIDTH_UM, HERE, MACROS, PORTS, REPO,
                    R_LENGTH_UM, R_WIDTH_UM, TOP, logical_lines, spice_filter, spice_top,
                    strip_final_end)


def block_body(path, name):
    active = False
    result = []
    for line in logical_lines(path):
        parts = line.split()
        if parts[0].lower() == ".subckt" and parts[1].lower() == name.lower():
            active = True
        if active:
            # The routed two-terminal endcap CDL omits the well terminals
            # present in the foundry's endcap simulation model.
            if len(parts) == 4 and parts[-1].endswith("__endcap"):
                instance, vdd, vss, model = parts
                line = f"{instance} {vdd} {vdd} {vss} {vss} {model}"
            result.append(line)
            if parts[0].lower() == ".ends":
                return result
    raise ValueError(f"No complete {name} definition in {path}")


def make_sources():
    out = HERE / "spice"
    out.mkdir(exist_ok=True)
    analog = REPO / "PLL/analog"
    vco = analog / "vco/Differential_VCO_pex.spice"
    blocks = []
    for path in (vco, analog/"prescaler/32_33_Prescaler_CPEX.spice",
                 analog/"phase_detector/Phase_Detector_FE_CPEX.spice",
                 analog/"charge_pump/Charge_Pump_FE_CPEX.spice"):
        blocks.extend(strip_final_end(path.read_text().splitlines()))
        blocks.append("")
    blocks.extend(block_body(analog/"integer_n_divider/ble_feedback_divider_extracted.spice",
                             "ble_feedback_divider"))
    blocks.extend(block_body(REPO/"tapeout/ble_tx_uart/spice/ble_tx_uart.spice", "ble_tx_uart"))
    blocks.extend(spice_filter())
    (out/"blocks_pex.spice").write_text("\n".join(blocks)+"\n")
    (out/"A01_topcell.spice").write_text("\n".join(spice_top(vco))+"\n")

    # Reused macro interiors are audited at block level. This source uses
    # physical GDS cell/port names and checks all their parent-level nets.
    interfaces = []
    top = [f".subckt {TOP} {' '.join(PORTS)}"]
    for key, (_, cell, mapping) in MACROS.items():
        interfaces += [f".subckt {cell} {' '.join(mapping)}", f".ends {cell}"]
        top.append(f"X{key} {' '.join(mapping.values())} {cell}")
    interfaces += [
        ".subckt PLL_RZ P N B",
        f"Xr P N B ppolyf_u r_width={R_WIDTH_UM}u r_length={R_LENGTH_UM}u",
        ".ends PLL_RZ",
        ".subckt PLL_C1 TOP BOTTOM",
        f"Xc TOP BOTTOM cap_mim_2f0_m5m6_noshield c_width={C1_UM}u c_length={C1_UM}u",
        ".ends PLL_C1",
        ".subckt PLL_C2_UNIT TOP BOTTOM",
        *[f"Xc{i} TOP BOTTOM cap_mim_2f0_m5m6_noshield c_width={C2_WIDTH_UM}u c_length={C2_LENGTH_UM}u"
          for i in range(C2_TILES)],
        ".ends PLL_C2_UNIT",
    ]
    top += ["Xres VCTRL LF_RZ VSS PLL_RZ", "Xc1 VSS VCTRL PLL_C1"]
    top += [f"Xc2_{i} VSS LF_RZ PLL_C2_UNIT" for i in range(C2_COUNT)]
    top.append(f".ends {TOP}")
    (out/"A01_topcell_lvs.spice").write_text("\n".join(
        ["* Macro-boundary LVS source with explicit RC filter devices.",
         *interfaces, "", *top])+"\n")

    abstract = [cell for _, cell, _ in MACROS.values()]
    config = {
        "STD_CELL_LIBRARY": "gf180mcu_fd_sc_mcu7t5v0",
        "INCLUDE_CONFIGS": [],
        "TOP_SOURCE": TOP,
        "TOP_LAYOUT": "$TOP_SOURCE",
        "EXTRACT_FLATGLOB": [],
        "EXTRACT_ABSTRACT": abstract,
        "LVS_FLATTEN": [],
        "LVS_NOFLATTEN": abstract,
        "LVS_IGNORE": [],
        "LVS_SPICE_FILES": ["$UPRJ_ROOT/build/spice/A01_topcell_lvs.spice"],
        "LVS_VERILOG_FILES": [],
        "LAYOUT_FILE": "$UPRJ_ROOT/build/gds/$TOP_LAYOUT.gds",
    }
    (HERE/"lvs_config.json").write_text(json.dumps(config,indent=2)+"\n")


if __name__ == "__main__":
    make_sources()
