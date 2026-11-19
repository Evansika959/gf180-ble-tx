"""Check the routed macro boundary and natively extract the new RC devices."""
import argparse
import json
import os
from pathlib import Path
import re
import subprocess

import klayout.db as db

from check_connectivity import check
from design import HERE, MACROS, TOP, logical_lines

FILTER_CELLS = ("PLL_RZ", "PLL_C1", "PLL_C2_UNIT")


def native_filter(gds, out, tech):
    original, small = db.Layout(), db.Layout()
    original.read(str(gds))
    small.dbu = original.dbu
    for name in FILTER_CELLS:
        small.create_cell(name).copy_tree(original.cell(name))
    filter_gds = out/"filter.gds"
    small.write(str(filter_gds))
    rc = out/"magicrc"
    rc.write_text(f"crashbackups stop\ntech load {{{tech}}}\n"
                  'if {[tech name] != "gf180mcuE"} {error "Expected six-metal gf180mcuE"}\n'
                  "scalegrid 1 10\ndrc off\n")
    extracted = []
    counts = {}
    for name in FILTER_CELLS:
        work = out/name
        work.mkdir()
        script = work/"extract.tcl"
        script.write_text(f"gds read {{{filter_gds}}}\nload {name}\nselect top cell\n"
                          "extract all\next2spice lvs\next2spice cthresh infinite\n"
                          "ext2spice -o extracted.spice\nquit -noprompt\n")
        with (work/"magic.log").open("w") as stream:
            subprocess.run(["magic","-dnull","-noconsole","-rcfile",str(rc),str(script)],
                           cwd=work,stdout=stream,stderr=subprocess.STDOUT,check=True,timeout=90)
        lines = logical_lines(work/"extracted.spice")
        counts[name] = sum(line.upper().startswith("X") for line in lines)
        extracted.extend(lines)
    return extracted, counts


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out",type=Path,default=HERE/"runs/lvs")
    parser.add_argument("--magic-tech",type=Path,
                        default=Path(os.getenv("GF180_E_MAGIC_TECH",HERE/"tech/gf180mcuE.tech")))
    args = parser.parse_args()
    out = args.out.resolve()
    tech = args.magic_tech.resolve(strict=True)
    out.mkdir(parents=True,exist_ok=False)
    connectivity, layout_top = check()
    native_rc, counts = native_filter(HERE/"gds"/f"{TOP}.gds",out,tech)
    cells = []
    for _,cell,mapping in MACROS.values():
        cells += [f".subckt {cell} {' '.join(mapping)}",f".ends {cell}"]
    layout_spice = out/"layout_boundary.spice"
    layout_spice.write_text("\n".join([*cells,*native_rc,*layout_top])+"\n")
    pdk = Path(os.getenv("PDK_ROOT","/foss/pdks"))/"gf180mcuD"
    setup = out/"setup.tcl"
    setup.write_text(f"source {{{pdk/'libs.tech/netgen/gf180mcuD_setup.tcl'}}}\n"
                     "permute pins cap_mim_2f0_m5m6_noshield 1 2\n")
    report = out/"netgen.out"
    reference = HERE/"spice/A01_topcell_lvs.spice"
    with (out/"netgen.log").open("w") as stream:
        subprocess.run(["netgen","-batch","lvs",f"{layout_spice} {TOP}",f"{reference} {TOP}",
                        str(setup),str(report)],cwd=out,stdout=stream,stderr=subprocess.STDOUT,
                       check=True,timeout=90)
    text = report.read_text()
    passed = bool(re.search(r"match uniquely|Netlists match",text,re.I) and
                  not re.search(r"property errors|Netlists do not match|pin mismatch",text,re.I))
    result = {"pass":passed, "scope":"Routed macro boundary plus native extraction of new RC cells",
              "abstract_macros":[cell for _,cell,_ in MACROS.values()],"filter_devices_per_cell":counts,
              "gds_sha256":connectivity["gds_sha256"],
              "full_flattened_signoff":False}
    (out/"lvs.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))
    return 0 if passed else 2


if __name__=="__main__":
    raise SystemExit(main())
