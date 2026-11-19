"""Electrical and physical interface of the BLE/PLL integration."""
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
TOP = "A01_topcell"
CFG = [f"CFG[{i}]" for i in range(6)]
CODES = [f"FINE_CODE[{i}]" for i in range(8)]
PORTS = ["VDD", "VSS", "VDD_VCO", "VCTRL", "CP_IBIAS", "TAIL_BIAS", "VTUNE",
         "REF_1M", "CLK_8M", "UART_RX", "RST_N", *CFG, "RF_OUT", *CODES,
         "CODE_VALID", "AIR_BIT", "SYM_STROBE"]

# The maps use the existing GDS labels as keys. Ports omitted here are
# internal probe points. They keep their names within each macro.
MACROS = {
    "tx": ("tapeout/ble_tx_uart/gds/ble_tx_uart.gds", "ble_tx_uart",
           {"VDD": "VDD", "VSS": "VSS", "clk": "CLK_8M", "rst_n": "RST_N",
            "uart_rx": "UART_RX", "code_valid": "CODE_VALID", "air_bit": "AIR_BIT",
            "sym_strobe": "SYM_STROBE", **{f"fine_code[{i}]": CODES[i] for i in range(8)}}),
    "divider": ("PLL/analog/integer_n_divider/ble_feedback_divider.gds", "ble_feedback_divider",
                {"VDD": "VDD", "VSS": "VSS", "rst_n": "RST_N", "clk_prescaled": "PRESCALED",
                 "clk_feedback": "FB_1M", "modulus_33": "MC",
                 **{f"cfg_divider[{i}]": CFG[i] for i in range(6)}}),
    "prescaler": ("PLL/analog/prescaler/32_33_Prescaler_fixed.gds", "32_33_Complete_Prescaler",
                  {"VDD": "VDD", "VSS": "VSS", "CLK_IN": "CORE_CLK", "MC": "MC",
                   "CLK_OUT": "PRESCALED"}),
    "vco": ("PLL/analog/vco/Differential_VCO_routed.gds", "Differential_VCO_ROUTED",
            {"VDD": "VDD_VCO", "VBUF": "VDD", "VSS": "VSS", "DOUBLE_OUT": "RF_OUT",
             "VTUNE": "VTUNE", "TAIL_BIAS": "TAIL_BIAS", "PRESCALER_CLK": "CORE_CLK"}),
    "pfd": ("PLL/analog/phase_detector/Phase_Detector_FE_fixed.gds", "Phase_Detector_FE",
            {"VDD": "VDD", "VSS": "VSS", "F_REF": "REF_1M", "F_VCO": "FB_1M",
             "UPb": "UPB", "DN": "DN"}),
    "pump": ("PLL/analog/charge_pump/Charge_Pump_FE_fixed.gds", "Charge_Pump_FE",
             {"VDD": "VDD", "VSS": "VSS", "UPb": "UPB", "DN": "DN",
              "IBIAS": "CP_IBIAS", "OUT": "VCTRL"}),
}

# The option-B top plate dimensions fit underneath the 100 x 100 um
# maximum plate area. Include the nominal GF180 model perimeter term.
C1_UM = 25.225
C2_WIDTH_UM = 23.600
C2_LENGTH_UM = 94.495
C2_TILES = 4
C2_COUNT = 8
R_WIDTH_UM = .8
# The extracted device is ppolyf_u (350 ohms/square at typical), including
# the width correction and the two terminal resistances in the SPICE model.
R_LENGTH_UM = 88.055


def logical_lines(path):
    lines = []
    for line in Path(path).read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("*"):
            continue
        if line.startswith("+"):
            lines[-1] += " " + line[1:].strip()
        else:
            lines.append(line)
    return lines


def subckt(path, name):
    for line in logical_lines(path):
        fields = line.split()
        if fields[0].lower() == ".subckt" and fields[1].lower() == name.lower():
            return fields[2:]
    raise ValueError(f"{name} not found in {path}")


def spice_instance(name, model, pins, mapping):
    nets = [mapping.get(pin, f"{name}_{pin}") for pin in pins]
    return f"X{name} {' '.join(nets)} {model}"


def spice_top(vco_source):
    analog = REPO / "PLL/analog"
    sources = {
        "tx": (REPO / "tapeout/ble_tx_uart/spice/ble_tx_uart.spice", "ble_tx_uart"),
        "divider": (analog / "integer_n_divider/ble_feedback_divider_extracted.spice",
                    "ble_feedback_divider"),
        "prescaler": (analog / "prescaler/32_33_Prescaler_CPEX.spice", "x32_33_Prescaler_PEX"),
        "vco": (vco_source, "VCO_PEX"),
        "pfd": (analog / "phase_detector/Phase_Detector_FE_CPEX.spice", "Phase_Detector_FE_PEX"),
        "pump": (analog / "charge_pump/Charge_Pump_FE_CPEX.spice", "Charge_Pump_FE_PEX"),
    }
    lines = ["* A01 BLE/PLL integration, external high-impedance VCO supply follower",
             f".subckt {TOP} {' '.join(PORTS)}"]
    for name, (file, model) in sources.items():
        lines.append(spice_instance(name, model, subckt(file, model), MACROS[name][2]))
    return lines + ["Xloop VCTRL VSS PLL_LOOP_FILTER",f".ends {TOP}"]


def spice_filter():
    lines = [".subckt PLL_LOOP_FILTER VCTRL VSS",
              f"Xrz VCTRL LF_RZ VSS ppolyf_u r_width={R_WIDTH_UM}u r_length={R_LENGTH_UM}u",
              f"Xc1 VSS VCTRL cap_mim_2f0_m5m6_noshield c_width={C1_UM}u c_length={C1_UM}u"]
    lines += [f"Xc2_{i} VSS LF_RZ cap_mim_2f0_m5m6_noshield "
              f"c_width={C2_WIDTH_UM}u c_length={C2_LENGTH_UM}u"
              for i in range(C2_COUNT*C2_TILES)]
    return lines + [".ends PLL_LOOP_FILTER"]


def strip_final_end(lines):
    return [line for line in lines if not re.fullmatch(r"\.end", line, re.I)]
