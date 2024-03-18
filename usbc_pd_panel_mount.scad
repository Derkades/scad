use <lib.scad>

panel_w = 50;
panel_h = 3;
panel_r = 10;

module_l = 50;
module_w = 20;
module_port_h = 10; // distance between port bottom and module bottom

module_plate_t = 2;
module_plate_support_w = 5;
module_plate_support_t = 4;

screw_offset = panel_w / 2 - panel_r;
screw_r1 = 5; // screw head
screw_r2 = 2; // screw thread

module usbc_cutout() {
    usbc_h = 3;
    usbc_w = 10;
    usbc_l = 10;
    
    hull(){
        for (x = [-usbc_w/2, usbc_w/2]) {
            translate([x, 0, -0.001])
            bettercylinder(usbc_l, usbc_h/2 + 0.002);        
        }
    }
}
 
difference() {    
    translate([-panel_w/2, -panel_w/2, 0])
    roundedcube([panel_w, panel_w, panel_h], panel_r, only_sides=true);
    
    // screw holes
    for (x = [screw_offset, -screw_offset]) {
        for (y = [screw_offset, -screw_offset]) {
            translate([x, y, -0.001])
            cylinder(h=panel_h + 0.002, r1=screw_r1, r2=screw_r2);
        }
    }
    
    usbc_cutout();
}

translate([0, module_port_h, module_l/2+panel_h])
cube([module_w, module_plate_t, module_l], center=true);

translate([0, module_port_h + module_plate_t, module_l/4+panel_h])
cube([module_plate_support_w, module_plate_support_t, module_l / 2], center=true);