include <../BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

h = 4.5 + 3;

cuboid([14, 14, 1.45], anchor=BOTTOM);
cyl(r=6/2, h=3.5, anchor=BOTTOM);
cyl(r=3.5/2, h=15, anchor=BOTTOM);

up(h)
cyl(r=4.45/2, r2=4/2, h=15-h, anchor=BOTTOM);

up(15)
cyl(r1=4/2, r2=0, h=2.5, anchor=BOTTOM); 