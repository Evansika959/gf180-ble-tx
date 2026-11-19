"""Assemble the six-metal A01 integration using the existing macro masks."""
import argparse
from collections import defaultdict
import hashlib
import heapq
import json
from pathlib import Path

import klayout.db as db

from design import (C1_UM, C2_COUNT, C2_LENGTH_UM, C2_TILES, C2_WIDTH_UM, HERE, MACROS, PORTS, REPO,
                    R_LENGTH_UM, TOP)

DBU = .001
GRID = 5
METALS = (34, 36, 42, 46, 81, 53)
VIAS = (35, 38, 40, 41, 82)
SPACING = (300, 300, 300, 300, 350, 650)
WIDTH = (450, 450, 450, 450, 520, 800)
CUT = 260
VIA_SPACING = 280
VIA5_TO_M4 = 1200
FILL = {"VDD", "VSS", "VDD_VCO"}
CHANNEL_PITCH = 4000
MACRO_BOTTOM = 152.


def units(um):
    return round(um / DBU / GRID) * GRID


def rect(a, b, width):
    half = width // 2
    return db.Box(min(a[0], b[0]) - half, min(a[1], b[1]) - half,
                  max(a[0], b[0]) + half, max(a[1], b[1]) + half)


def pin(name, level, x, y):
    return {"pin": name, "level": level, "xy": [units(x), units(y)]}


def put(layout, cell, layer, xmin, ymin, xmax, ymax, datatype=0):
    cell.shapes(layout.layer(layer, datatype)).insert(db.Box(*map(units, (xmin, ymin, xmax, ymax))))


def label(layout, cell, name, level, x, y):
    cell.shapes(layout.layer(METALS[level], 10)).insert(db.Text(name, db.Trans(x, y)))


def build_filter_cells(layout, resistor_template):
    # The original straight high-poly resistor is 28 um between the markers.
    # Lengthen the poly and marker by translating their right boundaries.
    res = layout.create_cell("PLL_RZ")
    capcell = layout.cell(resistor_template)
    assert capcell is not None
    extension = units(R_LENGTH_UM-28.)
    for li in layout.layer_indexes():
        info = layout.get_info(li)
        if info.datatype not in (0, 5):
            continue
        for p in db.Region(capcell.begin_shapes_rec(li)).merged().each():
            if not p.is_box():
                raise ValueError("Expected the audited rectangular RZ template")
            box = p.bbox()
            # Snap the inherited Metal1 edge outward to the manufacturing grid.
            box = db.Box((box.left//GRID)*GRID, (box.bottom//GRID)*GRID,
                         -(-box.right//GRID)*GRID, -(-box.top//GRID)*GRID)
            res.shapes(li).insert(db.Box(box.left+(extension if box.left>0 else 0),box.bottom,
                                         box.right+(extension if box.right>0 else 0),box.top))
    rpins = [pin("P",0,-14.37,-.08),pin("N",0,14.29+R_LENGTH_UM-28.,-.08),
             pin("B",0,-15.74,-.08)]
    for p in rpins:
        label(layout,res,p["pin"],p["level"],*p["xy"])

    def cap(name, width, length, count):
        cell = layout.create_cell(name)
        pitch=width+5.
        end=(count-1)*pitch+width
        for tile in range(count):
            x0=tile*pitch
            for layer, datatype in [(53,0),(75,0)]:
                put(layout,cell,layer,x0,0,x0+width,length,datatype)
            put(layout,cell,117,x0,0,x0+width,.1,10)
            put(layout,cell,117,x0-.6,-.6,x0+width+.6,length+.6,5)
            put(layout,cell,81,x0-.6,-.6,x0+width+.6,length+.6)
            mid=round((x0+width/2)/.005)*.005
            # Keep the M5 plates separate. Each bottom connection rises to
            # M6 outside its FuseTop edge, then joins the common M6 bus.
            put(layout,cell,81,mid-.72,length-.1,mid+.72,length+3.)
            put(layout,cell,53,mid-.66,length+1.65,mid+.66,length+4.7)
            for dx in (-.39,.39):
                put(layout,cell,82,mid+dx-.13,length+2.2-.13,mid+dx+.13,length+2.2+.13)
            put(layout,cell,53,mid-.55,-3.6,mid+.55,.2)
            n=int((width-1.12)//.76)+1
            for i in range(n):
                x=x0+.56+.76*i
                for y in (.56,1.32,length-1.32,length-.56):
                    put(layout,cell,82,x-.13,y-.13,x+.13,y+.13)
        put(layout,cell,53,-3.8,-3.75,end,-2.45)
        put(layout,cell,53,width/2-.67,length+4.1,end+3.8,length+5.4)
        pins=[pin("TOP",5,-3.10,-3.10),pin("BOTTOM",5,end+3.1,length+4.75)]
        for p in pins:
            label(layout,cell,p["pin"],p["level"],*p["xy"])
        return cell,pins

    return res,rpins,cap("PLL_C1",C1_UM,C1_UM,1),cap("PLL_C2_UNIT",C2_WIDTH_UM,C2_LENGTH_UM,C2_TILES)


def import_macros(layout):
    duplicate = db.LoadLayoutOptions()
    duplicate.cell_conflict_resolution = db.LoadLayoutOptions.RenameCell
    inputs = {}
    for key,(relative,cellname,mapping) in MACROS.items():
        path=REPO/relative
        if layout.cell(cellname) is not None:
            raise ValueError(f"Conflicting macro name {cellname}")
        layout.read(str(path),duplicate)
        cell=layout.cell(cellname)
        pins=[]
        for level,layer in enumerate(METALS):
            for shape in cell.each_shape(layout.layer(layer,10)):
                if shape.is_text() and shape.text.string in mapping:
                    point=shape.text.trans.disp
                    pins.append({"pin":shape.text.string,"level":level,"xy":[point.x,point.y]})
        if set(mapping)-{p["pin"] for p in pins}:
            raise ValueError(f"{key} missing GDS pins: {set(mapping)-{p['pin'] for p in pins}}")
        inputs[key]=(cell,pins,mapping)
    return inputs


class Router:
    """Escape each macro pin to M6. Connect vertical drops using M5 tracks."""

    def __init__(self, layout, top, terminals):
        self.layout=layout
        self.top=top
        self.width=WIDTH
        self.native=[db.Region(top.begin_shapes_rec(layout.layer(m,0))).merged() for m in METALS]
        self.cuts=[db.Region(top.begin_shapes_rec(layout.layer(v,0))) for v in VIAS]
        self.owned=[defaultdict(db.Region) for _ in METALS]
        self.added=[defaultdict(db.Region) for _ in METALS]
        for t in terminals:
            for p in t["pins"]:
                z=p["level"]
                point=tuple(p["xy"])
                owned=self.native[z].interacting(db.Region(rect(point,point,2)))
                if owned.is_empty():
                    raise ValueError(f"No pin metal at {t['block']}.{t['pin']} {p}")
                self.owned[z][t["net"]]+=owned

    def foreign(self, z, net, window):
        mine=self.owned[z][net]+self.added[z][net]
        native=(self.native[z] & window)-mine
        for name,reg in self.added[z].items():
            if name!=net:
                native+=reg & window
        return native.merged()

    def trace(self, z, net, a, b, width=None):
        box=rect(a,b,width or self.width[z])
        self.top.shapes(self.layout.layer(METALS[z],0)).insert(box)
        self.added[z][net].insert(box)

    def via(self, z, xy):
        cut=rect(xy,xy,CUT)
        self.top.shapes(self.layout.layer(VIAS[z],0)).insert(cut)
        self.cuts[z].insert(cut)

    def close_same_net_gaps(self):
        # Both parts of a sub-rule gap can belong to the same net through a
        # different routing layer. Only fill such gaps next to a new route,
        # and keep the required edge clearance from all foreign conductors.
        for z in range(6):
            spacing = (230,280,280,280,280,460)[z]
            radius = ((spacing//2)//GRID+1)*GRID
            for net, routes in tuple(self.added[z].items()):
                if routes.is_empty():continue
                own = (self.owned[z][net]+routes).merged()
                candidates = (own.sized(radius).sized(-radius)-own).interacting(routes.sized(radius))
                for poly in candidates.each():
                    window = db.Region(poly.bbox().enlarged(spacing+GRID))
                    foreign = self.foreign(z,net,window)
                    patch = db.Region(poly)
                    if (patch.sized(spacing-GRID) & foreign).is_empty():
                        self.top.shapes(self.layout.layer(METALS[z],0)).insert(poly)
                        self.added[z][net].insert(poly)

    def access(self, p, net, track, endpoint_width):
        x0,y0=p["xy"]
        start=(x0,y0,p["level"])
        step=200
        radius=4200
        lo=(x0-radius,y0-radius);hi=(x0+radius,y0+radius)
        window=db.Region(db.Box(lo[0]-1200,lo[1]-1200,hi[0]+1200,hi[1]+1200))
        blockers=[self.foreign(z,net,window).sized(SPACING[z]) for z in range(6)]
        blockers[4]+=(self.mim_bottom & window).sized(1250)
        cut_blockers=[(cuts & window).sized(VIA_SPACING) for cuts in self.cuts]
        if track is not None:
            trunk_window=db.Region(db.Box(lo[0]-1400,track-1800,hi[0]+1400,hi[1]+1500))
            trunk=self.foreign(5,net,trunk_window).sized(SPACING[5])
            track_m5=self.foreign(4,net,trunk_window).sized(SPACING[4])

        def clear(reg,box):
            return (reg & db.Region(box)).is_empty()

        def goal(x,y,z):
            return z==5 and (track is None or (
                clear(trunk,rect((x,y),(x,track),endpoint_width))
                and clear(track_m5,rect((x,track),(x,track),self.width[4]))))

        if not clear(blockers[start[2]],rect(start,start,self.width[start[2]])):
            return None
        costs={start:0}
        previous={}
        queue=[(0,0,start)]
        while queue:
            _,g,node=heapq.heappop(queue)
            if costs[node]!=g:continue
            x,y,z=node
            if goal(x,y,z):
                path=[node]
                while path[-1] in previous:path.append(previous[path[-1]])
                return list(reversed(path))
            moves=[(x+dx,y+dy,z) for dx,dy in ((step,0),(-step,0),(0,step),(0,-step))]
            if z<5:moves.append((x,y,z+1))
            for dest in moves:
                ex,ey,ez=dest
                if abs(ex-x0)>radius or abs(ey-y0)>radius:continue
                ascent=ez>z
                if not clear(blockers[ez],rect(node,dest,self.width[ez])):continue
                if ascent and not clear(cut_blockers[z],rect(node,node,CUT)):continue
                if ascent and z==4:
                    # Via5 must not land within the plate-transition exclusion of a MIM.
                    if not clear(self.fuse_near,rect(node,node,CUT)):continue
                cost=g+(3 if ascent else 1)
                if cost>=costs.get(dest,1e9):continue
                costs[dest]=cost
                previous[dest]=node
                heapq.heappush(queue,(cost+3*(5-ez),cost,dest))
        return None

    def run(self, terminals):
        fuse=db.Region(self.top.begin_shapes_rec(self.layout.layer(75,0)))
        self.fuse_near=fuse.sized(VIA5_TO_M4)
        self.mim_bottom=self.native[4].interacting(fuse)
        grouped=defaultdict(list)
        for t in terminals:
            grouped[t["net"]].append(t)
        order=sorted(grouped,key=lambda net: (net not in PORTS,net in FILL,net))
        track={net:4000+i*CHANNEL_PITCH for i,net in enumerate(order)}
        for net,y in track.items():
            if y>=units(MACRO_BOTTOM)-4000:
                raise ValueError("More nets than reserved routing tracks")
        # Constrained pins first. TX output and configuration buses already
        # provide multiple microns of separation on the macro edges.
        selected=defaultdict(list)
        pin_locations={}
        for t in sorted(terminals,key=lambda t:(len(t["pins"]),t["block"],t["pin"])):
            net=t["net"]
            endpoint_width=1000 if net in FILL else self.width[5]
            # A one-terminal port needs only a local M6 landing. Routing it
            # across the macro adds antenna exposure and unnecessary loading.
            local_port=net in PORTS and len(grouped[net])==1
            y=None if local_port else track[net]
            path=None
            for p in sorted(t["pins"],key=lambda p:(-p["level"],p["xy"][1])):
                path=self.access(p,net,y,endpoint_width)
                if path is not None:break
            if path is None:
                raise RuntimeError(f"No safe pin escape for {t['block']}.{t['pin']} on {net}")
            print(f"{t['block']}.{t['pin']} -> {net}",flush=True)
            for a,b in zip(path,path[1:]):
                z=a[2]
                self.trace(z,net,a,b)
                if z!=b[2]:
                    self.trace(b[2],net,b,b)
                    self.via(z,a)
            x,top_y,_=path[-1]
            if local_port:
                label(self.layout,self.top,net,5,x,top_y)
                pin_locations[net]={"level":5,"xy":[x,top_y]}
            else:
                self.trace(5,net,(x,top_y),(x,y),endpoint_width)
                self.via(4,(x,y))
                selected[net].append((x,y))
            t["selected_pin"]=p
        for net,points in selected.items():
            y=track[net];xs=[x for x,_ in points]
            # Add short dedicated pad extensions for the chip interface.
            external=net in PORTS
            x0=min(xs)-(2000 if external else 0)
            x1=max(xs)
            self.trace(4,net,(x0,y),(x1,y),1800 if net in FILL else 650)
            if external:
                label(self.layout,self.top,net,4,x0,y)
                pin_locations[net]={"level":4,"xy":[x0,y]}
        self.close_same_net_gaps()
        return pin_locations


def assemble(destination):
    layout=db.Layout()
    layout.dbu=DBU
    inputs=import_macros(layout)
    top=layout.create_cell(TOP)
    cap_template="Poly_Resistor_30K"
    res,rpins,(c1,c1_pins),(c2,c2_pins)=build_filter_cells(layout,cap_template)
    terminals=[]
    placement={}

    def place(key, cell, pins, mapping, x, y):
        box=cell.bbox()
        dx,dy=units(x)-box.left,units(y)-box.bottom
        trans=db.Trans(dx,dy)
        top.insert(db.CellInstArray(cell.cell_index(),trans))
        placement[key]={"cell":cell.name,"delta_dbu":[dx,dy],
                        "bbox_um":[v*DBU for v in (box.left+dx,box.bottom+dy,box.right+dx,box.top+dy)]}
        for name,net in mapping.items():
            copies=[{**p,"xy":[p["xy"][0]+dx,p["xy"][1]+dy]} for p in pins if p["pin"]==name]
            terminals.append({"block":key,"pin":name,"net":net,"pins":copies})

    for name,x,y in [("tx",5,152),("divider",284,152),("prescaler",345,152),
                     ("vco",388,152),("pfd",438,152),("pump",458,152)]:
        place(name,*inputs[name],x,y)
    place("res",res,rpins,{"P":"VCTRL","N":"LF_RZ","B":"VSS"},478,148)
    place("c1",c1,c1_pins,{"TOP":"VSS","BOTTOM":"VCTRL"},518,152)
    for i in range(C2_COUNT):
        # Align the two rows so their equal-net vertical trunks can share lanes.
        place(f"c2_{i}",c2,c2_pins,{"TOP":"VSS","BOTTOM":"LF_RZ"},
              562+122*(i%4),152+110*(i//4))
    router=Router(layout,top,terminals)
    pins=router.run(terminals)
    # Drop the unused empty source top cell, leaving one GDS entry point.
    for orphan in list(layout.top_cells()):
        if orphan.cell_index()!=top.cell_index():
            layout.delete_cell(orphan.cell_index())
    destination.mkdir(parents=True,exist_ok=True)
    gds=destination/f"{TOP}.gds"
    layout.write(str(gds))
    metadata={"top":TOP,"dbu_um":DBU,"pdk":"gf180mcuE","bbox_um":str(top.dbbox()),
              "gds_sha256":hashlib.sha256(gds.read_bytes()).hexdigest(),
              "placement":placement,"pins":pins,"terminals":terminals,
              "sources":{k:{"path":f,"sha256":hashlib.sha256((REPO/f).read_bytes()).hexdigest()}
                         for k,(f,_,_) in MACROS.items()}}
    (destination/"assembly.json").write_text(json.dumps(metadata,indent=2)+"\n")


if __name__=="__main__":
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out",type=Path,default=HERE/"gds")
    assemble(parser.parse_args().out)
