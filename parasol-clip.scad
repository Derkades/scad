include <BOSL2/std.scad>
include <BOSL2/screws.scad>

t = 8.2;
r = 16/2;
h = 45;

p1 = r*1.5;
p2 = t;

$fs = 1;
$fa = 1;

difference() {
    union() {
        cyl(r=r, h=t);
        
        left(r)
        xrot(90)
        prismoid(size1=[p1, t], size2=[p2, t], shift=[-p1/2+p2/2, 0], height=h, anchor=BOTTOM+LEFT);
    }
    translate([-1.5, -1.5, 0])
    screw_hole("M5", length=t);
}

fwd(h+t)
cuboid([r*2, t, t], anchor=FRONT, rounding=5, edges=[LEFT+FRONT]);