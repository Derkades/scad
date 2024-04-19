include <BOSL2/std.scad>
include <BOSL2/screws.scad>

bolt = true;

spec = "M20";
bolt_lengh = 40;
scale = 3;

scale([scale, scale, scale])

if (bolt) {
    rotate([180, 0, 0])
    screw(spec, length=bolt_lengh, anchor=TOP, head="hex");
} else {
    nut(spec, anchor=BOTTOM, $slop=0.2);
}