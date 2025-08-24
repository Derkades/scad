include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

cyl(d=150, h=2, anchor=TOP);

difference() {
    union() {
        cuboid([70, 10, 5], anchor=BOTTOM);
        cuboid([10, 70, 5], anchor=BOTTOM);
    }
    
    cuboid([70, 4, 5], anchor=BOTTOM);
    cuboid([4.2, 70, 5], anchor=BOTTOM);
}