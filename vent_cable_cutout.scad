use <lib.scad>

height = 50;
outer_radius = 120 / 2;
wall = 1.5;
cable_radius = 20 / 2;

difference() {
    bettercylinder(height, outer_radius);
    
    translate([0, 0, -1])
    bettercylinder(height+2, outer_radius-wall);
    
    translate([-outer_radius, 0, height/2])
    rotate([0, 90, 0])
    bettercylinder(wall + 2, cable_radius);
    
    translate([-outer_radius, -cable_radius, height/2])
    cube([wall+2, cable_radius*2, height/2+1]);
}