use <lib.scad>

length = 125;
width = 105;

wall = 4;
height = 20;
rounding = 10;

outer_length = length + wall*2;
outer_width = width + wall*2;

mount_length = length / 1.5;
mount_height = 40;
mount_thick = 13;

screw_r = 5 / 2;
screw_head_r = 9 / 2;

difference() {
    union() {
        roundedcube([outer_length, outer_width, height], rounding, true);
    
        translate([(outer_length-mount_length)/2, -mount_thick+wall, -mount_height+height])
        cube([mount_length, mount_thick, mount_height]);
    }
    
    translate([wall, wall, 0])
    roundedcube([length, width, height], rounding, true);
    
    translate([(outer_length-mount_length)/2, -mount_thick+wall, -mount_height+height]) {
        for (x = [mount_length * (1/4), mount_length * (3/4)]) {
            translate([x, mount_thick, (mount_height) / 2])
            rotate([90, 0, 0]) {
                cylinder(h=wall, r1=screw_head_r, r2=screw_r);
                bettercylinder(h=mount_thick, r=screw_r);
            }
        }
    }
}
