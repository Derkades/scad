use <lib.scad>
use <hook.scad>

module hook_panel_mount(height, width, hook, panel_thickness) {
    hook(height-width/2, width, hook);

    translate([width/2, 0, height - width/2])
    rotate([-90, 0, 0])
    bettercylinder(width, width/2);

    translate([-panel_thickness - width/2, 0, height])
    rotate([-90, 0, 0])
    cube([panel_thickness + width, width, width]);

    hull() {
        for (offset = [0.5*width, 2.5*width]) {
            translate([-panel_thickness - width/2, 0, height - offset])
            #rotate([-90, 0, 0])
            bettercylinder(width, width/2);
        }
    }
}

hook_panel_mount(50, 12, 20, 10.7);
