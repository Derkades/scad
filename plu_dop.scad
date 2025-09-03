include <BOSL2/std.scad>

$fs = 0.5;
$fa = 0.5;
ir = 2.8;
or = 5.7;
t = or - ir;
h = 26;
hole = 2;

difference() {
    union() {
        cyl(h=h/2+t, r=or, anchor=BOTTOM);
        tube(h=h, ir=ir, or=or, anchor=BOTTOM);
    }

    up(h/2-hole/2)
    yrot(90)
    cyl(r=hole, h=or*2);
}