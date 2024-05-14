include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

width = 15;
length = 70;
steer_radius = 25.2 / 2;
steer_wall = 6;
mounting_flat_spot_width = (steer_radius + steer_wall) * 2 + 30;

bolt_spec = "M6";
light_bolt_length = 30;

difference() {
    union(){
        translate([-width/2, 0, 0])
        cube([width, length, width]);

        translate([0, width/2, 0])
        cylinder(h=width, r=steer_radius+steer_wall, $fn=200);

        translate([-mounting_flat_spot_width/2, 0, 0])
        cube([mounting_flat_spot_width, width, width]);
    }

    // Slice separating the two parts
    translate([-mounting_flat_spot_width/2-1, width/2 - 1, -1])
    cube([mounting_flat_spot_width+2, 2, width+2]);

    // Cutout for steer rod
    translate([0, width/2, -1])
    cylinder(h=width+2, r=steer_radius, $fn=100);

    // Bolt holes for mounting to steer rod
    x_offset = mounting_flat_spot_width/2 - width/2;
    countersink_depth = 3;
    for (x = [-x_offset, x_offset]) {
        translate([x, width/2, width/2])
        xrot(90)
        screw_hole(bolt_spec, length=width, counterbore=countersink_depth, head="socket", $fn=32)
        translate([0, 0, -width/2])
        nut_trap_inline(countersink_depth, bolt_spec);
    }

    // Cutout for light mount
    translate([0, length - 6, width/2])
    yrot(-90) xrot(90)
    nut_trap_side(width/2, bolt_spec);

    // Bolt hole for light mount
    translate([0, length + 1, width/2])
    rotate([90, 0, 0])
    screw_hole(bolt_spec, length=40, $fn=32);
}
