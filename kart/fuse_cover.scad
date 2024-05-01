include <../BOSL2/std.scad>

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

h = 30;
ol = 85;
ow = 35;
t = 2;
cutout_width = 15;
cutout_top_distance_from_left = 5;
cutout_height = cutout_width + h / 4;
screw_r = 2.5;

difference() {
    cube([ol, ow, h], anchor=BOTTOM);

    translate([0, 0, -t])
    cube([ol-t*2, ow-t*2, h], anchor=BOTTOM);

    // Left and right cutout
    for (x = [ol/2-t/2, -ol/2+t/2]) {
    translate([x, 0, 0])
    cube([t, cutout_width, cutout_height], anchor=BOTTOM);
    }

    // Top cutout
    //translate([-ol/2+cutout_width/2+cutout_top_distance_from_left, ow/2-t/2, 0])
    //cube([cutout_width, t, cutout_height], anchor=BOTTOM);
}

// Screw mounts right
for (y = [ow/2-screw_r*2, -ow/2+screw_r*2]) {
    translate([ol/2+screw_r*2, y, 0])
    screw_mount(screw_r, t);
}

// Screw mounts left
for (y = [ow/2-screw_r*2, -ow/2+screw_r*2]) {
    translate([-ol/2-screw_r*2, y, 0])
    zrot(180)
    screw_mount(screw_r, t);
}
