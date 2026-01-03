include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

length = 100; // distance between screws
w = 15;
t = 8;
h = 17;

screw_spec = "M3";
$slop = 0.1;

for (x = [-length/2, length/2])
right(x)
difference() {
    up(t)
    cuboid([t, w, h+t], anchor=TOP, chamfer=t/2, edges=x > 0 ? TOP+RIGHT : TOP+LEFT);
    
    down(h - 3)
    zrot(x > 0 ? 180 : 0)
    nut_trap_side(t/2, screw_spec);
    
    down(h)
    screw_hole(screw_spec, length=h/2, anchor=BOTTOM);
}

cuboid([length-t, w, t], anchor=BOTTOM, chamfer=t/2, edges=[BOTTOM+BACK, BOTTOM+FRONT]);