include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

inner = 29 / 2;
outer = 60 / 2;
height = 25;
wall = 2;
connect_width = 3;
opening = 16;
opening_width = 20;
bottom_height = wall*4;
bottom_opening = 5;
bottom_opening_width = 40;

difference() {
    union() {
        difference() {
            cylinder(r1=outer+wall, r2=inner+wall, h=height);
            cylinder(r1=outer, r2=inner, h=height);
        }

        cylinder(r=inner, h=wall);
        translate([0, 0, bottom_height/2])
        tube(ir=inner, or=inner+wall, h=bottom_height);

        translate([-outer, -connect_width/2, 0])
        cube([outer*2, connect_width, wall]);

        translate([-connect_width/2, -outer, 0])
        cube([connect_width, outer*2, wall]);
    }

    for (a = [45, 135, 225, 315]) {
        translate([outer*cos(a), outer*sin(a), 0])
        zrot(360 - a)
        rotate([90, 0, 0])
        translate([0, 0, -opening_width/2])
        cylinder(r=opening, h=opening_width);

        translate([outer*cos(a), outer*sin(a), 0])
        zrot(360 - a)
        rotate([90, 0, 0])
        translate([0, 0, -bottom_opening_width/2])
        cylinder(r=bottom_opening, h=bottom_opening_width);
    }
}
