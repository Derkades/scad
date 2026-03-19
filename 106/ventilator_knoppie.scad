include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 1;
$fs = 1;

cuboid([6.5, 15, 4], rounding=3, edges="Z", anchor=BOTTOM);
difference() {
    cuboid([1.9, 9.4, 8], chamfer=0.5, edges=[BOTTOM, "Z"], anchor=TOP);
    down(2)
    cuboid([1.9, 2.5, 6], chamfer=-0.5, edges=BOTTOM, anchor=TOP); 
}