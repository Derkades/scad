include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fa = 0.5;
$fs = 0.5;


difference() {
    union() {
        left(5)
        cuboid([35, 10, 5], anchor=TOP+LEFT, rounding=5, edges="Z");
        cyl(r=5, h=5, anchor=TOP);

        down(5)
        cyl(r=5, h=33, anchor=TOP);
    }
    
    screw_hole("M4", head="flat", length=33+5, anchor=TOP);
}
