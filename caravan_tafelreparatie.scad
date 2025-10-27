include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

w1 = 48;
w2 = 80;
d = 30;
h = 4;

$fs = 0.5;
$fa = 0.5;

difference() {
    cuboid([w2, d, h], chamfer=3, edges="Z");
    
    for (x = [-w1/2-1, w1/2+1]) {
        right(x)
        cuboid([2, d/2, h], anchor=FRONT);
    }
    
    for (x = [-w2/2+d/4, w2/2-d/4]) {
        right(x)
        back(d/4)
        screw_hole("M3.5", head="flat", length=h);
    }
    
    for (x = [-w2/5, w2/5]) {
        right(x)
        fwd(d/4)
        screw_hole("M3.5", head="flat", length=h);
    }
}