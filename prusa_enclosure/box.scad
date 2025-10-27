include <BOSL2/std.scad>
include <BOSL2/screws.scad>

w = 80;
d = 50;
h = 30;
t = 2;
hole_dist = 60;

difference() {
    cuboid([w, d, h]);

    up(t) cuboid([w - 2*t, d - 2*t, h]);

    for (x = [-hole_dist/2, hole_dist/2])
    translate([x, d/2-t/2, h/2-10])
    xrot(90)
    #screw_hole("M3", length=t+0.01, $fn=25);
}
