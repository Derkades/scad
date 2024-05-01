include <BOSL2/std.scad>

id = 25;
od = id + 3;
h = 15;
cutout = 3;
stand = 5;

difference() {
    union() {
        translate([0, -od/2, 0])
        cube([od/2, stand, h], anchor=BOTTOM);
        
        tube(h, or=od/2, ir=id/2, anchor=BOTTOM, $fn=500);
    }
    
    cube([id-cutout, id-cutout, h], anchor=BOTTOM+FRONT);
    
    translate([0,-id/2,h/2])
    rotate([90,0,0])
    cylinder(h=15, d=4, center=true, $fn=50);
    
    translate([0,-id/2,h/2])
    rotate([90,0,0])
    cylinder(h=5, d1=10, d2=4, center=true, $fn=50);
}