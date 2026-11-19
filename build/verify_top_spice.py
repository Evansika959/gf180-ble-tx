"""Check that the combined extracted SPICE deck loads and biases at nominal conditions."""
import argparse
import json
import os
from pathlib import Path
import re

from design import CFG, HERE, PORTS, TOP
from verify_behavior import simulate


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=HERE/"runs/top_spice")
    args = parser.parse_args()
    out = args.out.resolve()
    pdk = Path(os.getenv("PDK_ROOT", "/foss/pdks"))/"gf180mcuD"
    scl = "gf180mcu_fd_sc_mcu7t5v0"
    spu = HERE/"spice"
    # Force midscale during the operating point check. The loop transient in
    # verify_behavior.py leaves VCTRL driven by the extracted charge pump.
    nets = {"VSS": "0"}
    lines = [f'.include "{pdk}/libs.ref/{scl}/spice/{scl}.spice"',
             *[f'.include "{spu}/{name}.spice"' for name in ("blocks_pex", TOP, "vco_supply_model")],
             f"Xdut {' '.join(nets.get(pin,pin) for pin in PORTS)} {TOP}",
             "Xreg VCTRL REG_OUT 0 PLL_VCO_SUPPLY_MODEL", "Vsense REG_OUT VDD_VCO 0",
             "Vmain VDD 0 3.3", "Vmid VCTRL 0 1.65", "Vtail TAIL_BIAS 0 1.4",
             "Vtune VTUNE 0 1.5", "Ipump 0 CP_IBIAS 20u", "Vref REF_1M 0 0",
             "Vclk CLK_8M 0 0", "Vuart UART_RX 0 3.3", "Vreset RST_N 0 0",
             *[f"Vcfg{i} {pin} 0 {3.3 if 29 & (1<<i) else 0}" for i,pin in enumerate(CFG)],
             ".temp 27", ".control", "set noaskquit", "op",
             "print v(vdd_vco) i(vsense)"]
    log = simulate(out, lines, "res_typical", "mimcap_typical", "moscap_typical", "diode_typical")
    hits = dict(re.findall(r"(?mi)^([vi]\([^\n]+?\))\s*=\s*([+\-\d.e]+)",log))
    voltage = float(hits["v(vdd_vco)"])
    current = float(hits["i(vsense)"])
    summary = {"pass": abs(voltage-2.80)<.01 and 0<current<.01,
               "test": "Complete assembled block SPICE operating point with forced VCTRL",
               "vdd_vco_v": voltage, "vco_supply_current_a": current}
    (out/"top_spice.json").write_text(json.dumps(summary, indent=2)+"\n")
    print(json.dumps(summary, indent=2))
    return 0 if summary["pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
