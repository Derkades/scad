include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

difference() {
    union() {
        cuboid([14*2, 14*2, 7], anchor=BOTTOM);
        up(7)
        cyl(r=20/2, h=10, anchor=BOTTOM);
    }
    cyl(r=5/2, h=20, anchor=BOTTOM);
    up(7)
    cyl(r=10/2, h=20, anchor=BOTTOM);
}