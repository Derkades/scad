include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fa = 0.5;
$fs = 0.5;

w = 178;
w2 = 20;
h = 50;
t = 3;

cuboid([w, w2, t], anchor=TOP);

down(t) {
    left(w/2)
    cuboid([t, w2, h+t], anchor=BOTTOM+RIGHT);

    right(w/2)
    cuboid([t, w2, h+t], anchor=BOTTOM+LEFT);
}

up(h) {
    left(w/2)
    difference() {
        cuboid([w2, w2, t*2], anchor=TOP+RIGHT);

        left(w2/2+t/2)
        yrot(180)
        screw_hole("M4", head="flat", length=t*2, anchor=BOTTOM);
    }

    right(w/2)
    difference() {
        cuboid([w2, w2, t*2], anchor=TOP+LEFT);

        right(w2/2+t/2)
        yrot(180)
        #screw_hole("M4", head="flat", length=t*2, anchor=BOTTOM);
    }
}
