include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

$fa = 1;
$fs = 1;

difference() {
    cyl(h=15, r=32/2, anchor=BOTTOM, chamfer2=3);
    cyl(h=15, r=21/2, anchor=BOTTOM);
    nut_trap_inline(spec="M16", h=6, anchor=BOTTOM);
}