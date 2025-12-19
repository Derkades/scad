include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

length = 100;
w = 15;
t = 8;
h = 20;

screw_spec = "M3";
$slop = 0.1;

for (x = [-length/2, length/2])
right(x)
difference() {
    cuboid([t, w, h], anchor=TOP);
    
    down(h - 3)
    zrot(x > 0 ? 180 : 0)
    nut_trap_side(t/2, screw_spec);
    
    down(h)
    screw_hole(screw_spec, length=h/2, anchor=BOTTOM);
}

cuboid([length+t, w, t], anchor=BOTTOM, chamfer=t/2, edges=[TOP+LEFT, TOP+RIGHT]);