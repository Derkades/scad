include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

cyl(d=100, h=2, anchor=TOP);

difference() {
    union() {
        cuboid([60, 7, 4], anchor=BOTTOM);
        cuboid([7, 60, 4], anchor=BOTTOM);
    }
    
    cuboid([60, 3.1, 4], anchor=BOTTOM);
    cuboid([3.1, 60, 4], anchor=BOTTOM);
}