use <lib.scad>

length = 125;
width = 105;

wall = 3;
height = 10;
rounding = 10;

extra_length = length / 1.5;
extra_height = 40;
extra_thick = 13;

screw_r = 5 / 2;
screw_head_r = 9 / 2;

difference() {
    roundedcube([length, width, height], rounding, true);
    
    translate([wall, wall, 0])
    roundedcube([length-wall*2, width-wall*2, height], rounding, true);
}

translate([(length-extra_length)/2, -extra_thick+wall, -extra_height+height])
difference() {
    cube([extra_length, extra_thick, extra_height]);
    
    for (x = [extra_length * (1/4), extra_length * (3/4)]) {
        translate([x, extra_thick, (extra_height) / 2])
        rotate([90, 0, 0]) {
            cylinder(h=wall, r1=screw_head_r, r2=screw_r);
            bettercylinder(h=extra_thick, r=screw_r);
        }
    }
}