include <BOSL2/std.scad>
include <BOSL2/gears.scad>

$fa = 0.5;
$fs = 0.5;

rack(pitch=19/6, teeth=10, thickness=7, anchor=BOTTOM);

difference() {
    cuboid([75, 10, 5], rounding=5, edges="Z", anchor=BOTTOM);    
    cuboid([30, 7, 5.01], anchor=BOTTOM);
    
    xcopies(66)
    cyl(d=2.5, h=5.01, anchor=BOTTOM);
}