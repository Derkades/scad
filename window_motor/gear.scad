include <BOSL2/std.scad>
include <BOSL2/gears.scad>

teeth1 = 10;
teeth2 = 90;
diam12 = 3;
teeth3 = 10;
diam3 = 3;
pitch = 2;

spur_gear(circ_pitch=12, teeth=teeth1, thickness=5, shaft_diam=diam12, anchor=BOTTOM);

translate([0, 0, 5])
spur_gear(circ_pitch=pitch, teeth=teeth2, thickness=4, shaft_diam=diam12, anchor=BOTTOM);

d23 = gear_dist(circ_pitch=pitch, teeth1=teeth2, teeth2=teeth3);

translate([d23, 0, 5])
spur_gear(circ_pitch=pitch, teeth=teeth3, thickness=4, shaft_diam=diam3, anchor=BOTTOM);
