include <../BOSL2/std.scad>

$fa = 0.2;
$fs = 0.2;

h = 7;
t = 2.5;
l = 35;
w = 20;

rect_tube(h, [w+2*t, l+2*t], [w, l], rounding=2);
cuboid([w, t, h], anchor=BOTTOM);