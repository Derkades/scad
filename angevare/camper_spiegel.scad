include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fs = .5;
$fa = .5;

intersection() {
    cuboid([20, 20, 6], anchor=FRONT+LEFT, rounding=4, edges="Z");
    difference() {
        pie_slice(h=6, r=20, ang=90, anchor=CENTER);
        
        translate([6, 6, 0])
        cuboid([20, 20, 3.6], anchor=FRONT+LEFT);
        
        translate([4, 4, 0])
        screw_hole("M3", length=6, head="flat");
    }
}