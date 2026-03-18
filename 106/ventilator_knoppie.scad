include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 1;
$fs = 1;

cuboid([6.5, 15, 4], rounding=3, edges="Z", anchor=BOTTOM);
difference() {
    cuboid([2.1, 9.6, 8], chamfer=0.5, edges="Z", anchor=TOP);
    down(2)
    cuboid([2.1, 2.3, 6], anchor=TOP); 
}