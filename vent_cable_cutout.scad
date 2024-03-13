use <lib.scad>

height = 30;
inner_radius = 130 / 2;
wall = 5;
cable_radius = 20 / 2;

difference() {
    bettercylinder(height, inner_radius + wall);
    
    translate([0, 0, -1])
    bettercylinder(height+2, inner_radius);
    
    translate([-inner_radius-wall, 0, height/2])
    rotate([0, 90, 0])
    bettercylinder(wall + 2, cable_radius);
    
    translate([-inner_radius-wall, -cable_radius, height/2])
    cube([wall+2, cable_radius*2, height/2+1]);
}