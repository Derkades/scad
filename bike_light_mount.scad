use <lib.scad>;

width = 20;
length = 100;
steer_radius = 25;
steer_wall = 7;
light_hole = 6;
mounting_flat_spot_width = (steer_radius + steer_wall) * 2 + 25;

bolt_size = 6;
light_bolt_length = 30;
light_nut_size = 11;
light_nut_thickness = 8;

difference() {
    union(){
        translate([-width/2, 0, 0]) roundedcube([width, length, width], 3);
        translate([0, width/2, 0]) roundedcylinder(width, steer_radius+steer_wall, 3);
        translate([-mounting_flat_spot_width/2, 0, 0]) cube([mounting_flat_spot_width, width, width]);
    }
    
    // Slice separating the two parts
    translate([-mounting_flat_spot_width/2-1, width/2 - 2, -1]) cube([mounting_flat_spot_width+2, 4, width+2]);
    
    // Cutout for steer rod
    translate([0, width/2, -1]) cylinder(h=width+2, r=steer_radius);
    
     // Bolt holes for mounting to steer rod
    for (x = [-1, 1]) {
        translate([x*mounting_flat_spot_width/2 - x*width/3, width + 1, width/2]) rotate([90, 0, 0]) cylinder(h=width+2, r=bolt_size/2);
    }
    
    // Cutout for light mount
    cutout_y = length - (width - light_nut_size) / 2 - light_nut_thickness;
    cutout_depth = width/2 + light_nut_size/2;
    translate([-light_nut_size/2, cutout_y, width-cutout_depth]) cube([light_nut_size, light_nut_thickness, cutout_depth+1]);
    
    // Bolt hole for light mount
    translate([0, length + 1, width/2]) rotate([90, 0, 0]) cylinder(h=light_bolt_length + 1, r=bolt_size/2);
}