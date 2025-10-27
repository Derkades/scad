include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

t = 2;
d = 43.4;
h = 15;

d_kabel = 6;
d_slang = 14;
opening_afstand = 15;

difference() {
    cyl(d=d, h=t, anchor=TOP);

    left(opening_afstand/2)
    cyl(d=d_kabel, h=t, anchor=TOP);

    right(opening_afstand/2)
    cyl(d=d_slang, h=t, anchor=TOP);
}

tube(od=d, id=d-t*2, h=h, anchor=BOTTOM);

up(h)
tube(id=d, od=d+t*2, h=t, anchor=TOP);
