"""1 MHz PLL feedback checks with extracted analog blocks and timing models."""
import argparse
from concurrent.futures import ThreadPoolExecutor
import json
import os
from pathlib import Path
import re
import subprocess

import numpy as np

from design import HERE, REPO, spice_filter


def models(*sections):
    root = Path(os.getenv("PDK_ROOT", "/foss/pdks"))
    pdk = root / "gf180mcuD/libs.tech/ngspice"
    return [f'.include "{pdk}/design.ngspice"',
            *[f'.lib "{pdk}/sm141064.ngspice" {section}' for section in ("typical", *sections)]]


def include(path):
    return f'.include "{REPO/"PLL/analog"/path}"'


CP = "charge_pump/Charge_Pump_FE_CPEX.spice"
PFD = "phase_detector/Phase_Detector_FE_CPEX.spice"
PRESCALER = "prescaler/32_33_Prescaler_CPEX.spice"


def simulate(folder, lines, *sections):
    folder.mkdir(parents=True)
    (folder/".spiceinit").write_text("set ngbehavior=hsa\n")
    (folder/"test.spice").write_text("\n".join(
        ["1 MHz BLE PLL integration check", *models(*sections), *lines, "quit", ".endc", ".end"]
    )+"\n")
    log = folder/"ngspice.log"
    with log.open("w") as stream:
        subprocess.run(["ngspice", "-b", "test.spice"], cwd=folder,
                       stdout=stream, stderr=subprocess.STDOUT, check=True, timeout=360)
    text = log.read_text()
    if re.search(r"fatal error|simulation interrupted|timestep too small", text, re.I):
        raise RuntimeError(f"ngspice failed in {folder}")
    return text


def loop_check(folder, n, initial, pole_hz, duration_us):
    supply_initial = 2.80 + 0.20*(initial-1.65)
    lines = [
        include(PFD), include(CP), *spice_filter(),
        f'.include "{HERE/"spice/vco_supply_model.spice"}"',
        "VDD VDD 0 3.3", "IREF 0 CP_IBIAS 20u",
        "VREF REF 0 PULSE(0 3.3 0.12u 100p 100p 499.9n 1u)",
        "XPFD VDD 0 REF FB UP DN UPB DNB Phase_Detector_FE_PEX",
        "XPUMP VDD 0 UPB DN CP_IBIAS VCTRL Charge_Pump_FE_PEX",
        "XLOOP VCTRL 0 PLL_LOOP_FILTER",
        f"XREG VCTRL VDD_VCO 0 PLL_VCO_SUPPLY_MODEL F_POLE={pole_hz}",
        # Fit the supply pushing between the PEX points at 2.76–2.84 V.
        "BFREQ FG 0 V=max(0.02,1.22552+0.42690*(V(VDD_VCO)-2.8))",
        f"BPHASE 0 PH I=1e9*V(FG)/{n}", "CPHASE PH 0 1",
        "BFB FB 0 V=1.65+1.65*tanh(2000*sin(6.283185307179586*V(PH)))",
        f".ic V(VCTRL)={initial} V(xloop.lf_rz)={initial} V(xreg.follow)={supply_initial} V(PH)=0.05",
        ".temp 27", ".options reltol=1e-5 abstol=1e-13 vntol=1e-7",
        ".control", "set noaskquit", "set num_threads=1", "set wr_singlescale",
        "set wr_vecnames", "set numdgt=14",
        "save V(REF) V(FB) V(VCTRL) V(VDD_VCO) V(FG) V(UPB) V(DN)",
        f"tran 0.5n {duration_us}u 0 0.7n uic",
        "wrdata wave.dat V(REF) V(FB) V(VCTRL) V(VDD_VCO) V(FG) V(UPB) V(DN)",
    ]
    simulate(folder, lines, "res_typical", "mimcap_typical")
    wave = np.loadtxt(folder/"wave.dat",skiprows=1)
    time, ref, fb, vctrl, vdd, freq, upb, dn = wave.T

    def edges(y):
        i = np.flatnonzero((y[:-1]<1.65)&(y[1:]>=1.65))
        return time[i]+(time[i+1]-time[i])*(1.65-y[i])/(y[i+1]-y[i])

    fbedges = edges(fb)
    steady_start = (duration_us-30)*1e-6
    periods = np.diff(fbedges[fbedges>steady_start])
    assert periods.size >= 20 and time[-1] >= (duration_us-.1)*1e-6
    steady = time>steady_start
    mean_ppm = float((1e-6/periods.mean()-1)*1e6)
    max_ppm = float(np.max(np.abs(periods/1e-6-1))*1e6)
    # Test settling to within 0.1% on every last-window feedback cycle.
    result = {"test":"pex_frontend_behavioral_supply_vco_and_divider",
              "N":n, "initial_vctrl_v":initial, "mean_feedback_ppm":mean_ppm,
              "worst_cycle_error_ppm":max_ppm,
              "vctrl_min_v":float(vctrl[steady].min()),"vctrl_max_v":float(vctrl[steady].max()),
              "vdd_vco_pp_v":float(np.ptp(vdd[steady])),
              "follower_pole_hz":pole_hz, "duration_us":duration_us,
              "vdd_vco_avg_v":float(np.trapz(vdd[steady],time[steady])/(time[-1]-time[steady][0])),
              "pass":max_ppm<1000 and float(vdd[steady].min())>2.65 and float(vdd[steady].max())<3.15}
    np.savez_compressed(folder/"wave.npz",time_s=time,vctrl_v=vctrl,vdd_vco_v=vdd,
                        core_freq_ghz=freq,feedback_edges_s=fbedges)
    (folder/"wave.dat").unlink()
    return result


def prescaler_check(folder, n):
    p, s = divmod(n,32)
    fin = n*1e6
    folder.mkdir(parents=True)
    state_file = folder/"divider.states"
    state_file.write_text("".join(
        f"{i} {int(s>0 and i>=p-s)}s {int(i>=p-p//2)}s 0 -> {(i+1)%p}\n"
        for i in range(p)))
    # simulate() owns an otherwise empty directory. Keep the state table
    # next to it and reference its absolute path.
    test_dir = folder/"transient"
    lines = [
        include(PRESCALER),
        "VDD vdd 0 3.3",
        f"VIN clk 0 PULSE(0 3.3 1n 100p 100p {0.5/fin-100e-12:.12g} {1/fin:.12g})",
        "XPRE vdd 0 clk mc out x32_33_Prescaler_PEX",
        "CLOAD out 0 30f",
        "a_clk [out] [d_clk] adc_model",
        "a_zero [0] [d_zero] adc_model",
        "a_counter [d_zero] d_clk null [d_mc d_fb] divider_model",
        "a_outputs [d_mc d_fb] [mc fb] logic_bridge",
        ".model adc_model adc_bridge(in_low=1.60 in_high=1.70 rise_delay=1p fall_delay=1p)",
        ".model logic_bridge dac_bridge(out_low=0 out_high=3.3 out_undef=1.65 t_rise=100p t_fall=100p)",
        f'.model divider_model d_state(clk_delay=6n reset_delay=1n state_file="{state_file}" reset_state=0 clk_load=0 input_load=0)',
        ".ic V(xpre.Q1)=0 V(xpre.Q2)=0 V(xpre.Q3)=0",
        ".ic V(xpre.Q4b)=3.3 V(xpre.Q5b)=3.3 V(out)=3.3",
        ".control", "set noaskquit", "set num_threads=1", "set numdgt=12",
        "option reltol=1e-4 abstol=1e-12 vntol=1e-6", "save v(fb) v(out) v(mc)",
        "tran 6p 3.9u 0 6p",
        *[f"meas tran period{j} TRIG v(fb) VAL=1.65 RISE={j} TD=0.5u TARG v(fb) VAL=1.65 RISE={j+1} TD=0.5u"
          for j in (1,2)],
    ]
    text = simulate(test_dir,lines)
    periods = [float(m) for m in re.findall(r"(?m)^period[12]\s*=\s*([\d.eE+-]+)",text)]
    return {"test":"cpex_prescaler_with_registered_counter_timing_model","N":n,
            "period_s":periods,"mc_delay_ns":6,"prescaler_output_load_f":30e-15,
            "pass":len(periods)==2 and all(abs(x*fin-n)<.03 for x in periods)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out",type=Path,default=HERE/"runs/integration")
    parser.add_argument("--scope",choices=("both","loop","prescaler"),default="both")
    parser.add_argument("--pole-hz",type=float,default=75_000)
    parser.add_argument("--duration-us",type=float,default=450)
    args = parser.parse_args()
    if args.pole_hz <= 0 or args.duration_us < 50:
        parser.error("Use a positive follower pole and a simulation of at least 50 us")
    out = args.out.resolve()
    out.mkdir(parents=True,exist_ok=False)
    jobs = []
    if args.scope != "prescaler":
        jobs.extend((loop_check,(out/f"loop_{n}",n,1.65,args.pole_hz,args.duration_us)) for n in (1201,1240))
    if args.scope != "loop":
        jobs.extend((prescaler_check,(out/f"prescaler_{n}",n)) for n in (1201,1240))
    rows = []
    with ThreadPoolExecutor(max_workers=4) as pool:
        tasks = [pool.submit(func,*params) for func,params in jobs]
        for task in tasks:
            row=task.result()
            print(json.dumps(row),flush=True)
            rows.append(row)
    (out/"behavior.json").write_text(json.dumps(rows,indent=2)+"\n")
    return 0 if all(row["pass"] for row in rows) else 2


if __name__=="__main__":
    raise SystemExit(main())
