use <lib.scad>;

difference() {
    roundedcube([53, 20, 3], 4, only_sides=true);  
    translate([46,10, -1]) bettercylinder(5, r=3);
}
translate([3, 3, 3]) linear_extrude(3) text("Piet", 15);
