"""Extract metal connectivity from the final GDS and compare it with the LVS source."""
import hashlib
import json
from pathlib import Path

import klayout.db as db

from assemble_layout import METALS, VIAS
from design import HERE, PORTS, REPO, TOP, logical_lines, subckt


def check():
    cfg = json.loads((HERE/"lvs_config.json").read_text())
    root = str(REPO)
    resolve = lambda value: Path(value.replace("$UPRJ_ROOT", root).replace("$TOP_LAYOUT", TOP))
    gds = resolve(cfg["LAYOUT_FILE"])
    reference, = map(resolve, cfg["LVS_SPICE_FILES"])
    spec = json.loads((gds.parent/"assembly.json").read_text())
    gds_hash = hashlib.sha256(gds.read_bytes()).hexdigest()
    if gds_hash != spec["gds_sha256"]:
        raise ValueError("GDS hash differs from the assembly manifest")
    assert cfg["TOP_SOURCE"] == TOP and cfg["TOP_LAYOUT"] == "$TOP_SOURCE"
    assert not cfg["LVS_IGNORE"] and subckt(reference, TOP) == PORTS

    layout = db.Layout()
    layout.read(str(gds))
    top = layout.cell(TOP)
    assert top is not None and [c.name for c in layout.top_cells()] == [TOP]
    actual_instances = sorted((i.cell.name, i.trans.disp.x, i.trans.disp.y)
                              for i in top.each_inst())
    expected_instances = sorted((p["cell"], *p["delta_dbu"])
                                for p in spec["placement"].values())
    assert actual_instances == expected_instances
    extract = db.LayoutToNetlist(TOP, layout.dbu)

    def region(layer):
        return db.Region(top.begin_shapes_rec(layout.layer(layer,0))).merged()

    metals = [region(num) for num in METALS]
    for i,metal in enumerate(metals):
        extract.register(metal, f"M{i+1}")
        extract.connect(metal)
    fuse = region(75)
    for i,gds_layer in enumerate(VIAS):
        cuts = region(gds_layer)
        if i == 4:
            # A contact inside FuseTop lands on the capacitor's top electrode.
            # These cuts are separate from transfer vias between M5 and M6.
            cuts = cuts.not_interacting(fuse)
        extract.register(cuts, f"V{i+1}")
        extract.connect(cuts, metals[i])
        extract.connect(cuts, metals[i+1])
    extract.extract_netlist()

    def node(p):
        found = extract.probe_net(metals[p["level"]],db.Point(*p["xy"]))
        if found is None:
            raise ValueError(f"Terminal has no metal at {p}")
        return found.cluster_id

    # Check actual top label positions so metadata cannot hide a port error.
    physical_ports = {}
    for i,layer in enumerate(METALS):
        for shape in top.each_shape(layout.layer(layer,10)):
            if shape.is_text():
                text=shape.text
                if text.string in physical_ports:
                    raise ValueError(f"Duplicate top pin label {text.string}")
                physical_ports[text.string] = {"level":i,"xy":[text.trans.disp.x,text.trans.disp.y]}
    assert physical_ports == spec["pins"]

    expected = {}
    active = False
    for line in logical_lines(reference):
        parts = line.split()
        if parts[:2] == [".subckt",TOP]:
            active = True
        elif active and parts[0].lower() == ".ends":
            break
        elif active and parts[0][0].upper() == "X":
            name = parts[0][1:]
            expected[name] = (parts[-1],dict(zip(subckt(reference, parts[-1]), parts[1:-1], strict=True)))
    assert {cell for name,(cell,_) in expected.items() if name in ("tx","divider","prescaler","vco","pfd","pump")} == set(cfg["EXTRACT_ABSTRACT"])
    assert set(cfg["LVS_NOFLATTEN"]) == set(cfg["EXTRACT_ABSTRACT"])
    assert set(expected) == set(spec["placement"])

    partitions = {}
    points = {}
    pin_nodes = {}
    macro_nodes = {}
    for net,p in physical_ports.items():
        pin_nodes[net] = node(p)
        partitions.setdefault(net,set()).add(pin_nodes[net])
        points[f"TOP.{net}"] = net
    for terminal in spec["terminals"]:
        name, pin = terminal["block"],terminal["pin"]
        cell, mapping = expected[name]
        placed = spec["placement"][name]
        assert cell == placed["cell"]
        net = mapping[pin]
        assert terminal["net"] == net
        selection = terminal["selected_pin"]
        dx, dy = placed["delta_dbu"]
        labels = layout.cell(cell).each_shape(layout.layer(METALS[selection["level"]],10))
        assert any(s.is_text() and s.text.string == pin and
                   [s.text.trans.disp.x+dx,s.text.trans.disp.y+dy] == selection["xy"] for s in labels)
        physical_net = node(selection)
        macro_nodes.setdefault(name,{})[pin] = physical_net
        partitions.setdefault(net,set()).add(physical_net)
        points[f"{name}.{pin}"] = net
    opens = {net:sorted(ids) for net,ids in partitions.items() if len(ids)>1}
    cluster_to_net = {}
    shorts = {}
    for net, ids in partitions.items():
        for i in ids:
            if i in cluster_to_net:shorts.setdefault(i,[cluster_to_net[i]]).append(net)
            else:cluster_to_net[i]=net
    report = {"pass": not opens and not shorts,"scope":"All external and macro-interface metal nets",
              "pins":len(physical_ports),"macro_terminals":len(spec["terminals"]),
              "nets":len(partitions),"opens":opens,"shorts":shorts,"connections":points,
              "gds_sha256":gds_hash}
    print(json.dumps({k:v for k,v in report.items() if k!="connections"},indent=2))
    output = HERE/"runs"
    output.mkdir(exist_ok=True)
    (output/"connectivity.json").write_text(json.dumps(report,indent=2)+"\n")
    if not report["pass"]:raise SystemExit(2)
    names = {idx:net for net,idx in pin_nodes.items()}
    top_lines = [f".subckt {TOP} {' '.join(PORTS)}"]
    for key, (cell, mapping) in expected.items():
        nets = [names.get(macro_nodes[key][p],f"physical_{macro_nodes[key][p]}") for p in mapping]
        top_lines.append(f"X{key} {' '.join(nets)} {cell}")
    return report, top_lines+[f".ends {TOP}"]


if __name__ == "__main__":
    check()
