include <BOSL2/std.scad>

module screw_mount(hole_r, t) {
    difference() {
        cube([hole_r*4, hole_r*4, t], anchor=BOTTOM);
        cylinder(h=t, r=hole_r, anchor=BOTTOM);
    }

    for (y = [-hole_r*2+t/2, hole_r*2-t/2]) {
        translate([0, y, t])
        prismoid(size1=[hole_r*4, t], size2=[0, t], shift=[-hole_r*2, 0], h=hole_r*3);
    }
}

h = 40;
ol = 100;
ow = 50;
t = 2;
cutout_width = 25;
screw_r = 4;

difference() {
    cube([ol, ow, h], anchor=BOTTOM);

    translate([0, 0, -t])
    cube([ol-t*2, ow-t*2, h], anchor=BOTTOM);

    // Right cutout
    translate([ol/2-t/2, 0, 0])
    cube([t, cutout_width, cutout_width], anchor=BOTTOM);

    // Top cutout
    translate([-ol/2+cutout_width, ow/2-t/2, 0])
    cube([cutout_width, t, cutout_width], anchor=BOTTOM);
}

// Screw mount bottom left
translate([-ol/2+screw_r*2, -ow/2-screw_r*2, 0])
rotate([0, 0, -90])
screw_mount(screw_r, t);

// Screw mount top right
translate([ol/2-screw_r*2, ow/2+screw_r*2, 0])
rotate([0, 0, 90])
screw_mount(screw_r, t);
