use <lib.scad>

module hook(height, width, hook) {
    union() {
        cube([width, width, height]);

        difference() {
            translate([hook, 0, 0])
            rotate([-90, 0, 0])
            bettercylinder(width, hook);

            translate([0, -1, 0])
            cube([hook*2, width+2, hook]);

            translate([hook, -1, 0])
            rotate([-90, 0, 0])
            bettercylinder(width+2, hook - width);
        }

        translate([hook*2 - width/2, 0, 0])
        rotate([-90, 0, 0])
        bettercylinder(width, width/2);
    }
}

hook(100, 20, 50);
