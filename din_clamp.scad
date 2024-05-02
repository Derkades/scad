include <BOSL2/std.scad>
include <lib.scad>

module din_clamp(height, width) {
    din_height = 35; // Slop provided by spring
    din_thickness = 1.2;
    thickness = 3;
    flex_thickness = 1.5;
    cube([height+flex_thickness*2, thickness, width]);
    
    topclamp_x = height + flex_thickness*3;
    bottomclamp_x = topclamp_x - din_height - flex_thickness;
    
    translate([bottomclamp_x, thickness, 0]) {
        cube([flex_thickness, din_thickness + flex_thickness, width]);
        
        translate([flex_thickness, din_thickness, 0])
        cube([flex_thickness, flex_thickness, width]);
    }
    
    translate([height, -thickness*3, 0]) {
        cube([flex_thickness, thickness*4, width]);
        
        translate([flex_thickness*2, 0, 0])
        difference() {
            bettercylinder(h=width, r=flex_thickness*2);
            bettercylinder(h=width, r=flex_thickness);
            translate([-flex_thickness, 0, 0])
            cube([flex_thickness*2, flex_thickness*2, width]);
        }
        
        translate([flex_thickness*3, 0, 0])
        cube([flex_thickness, thickness*4+din_thickness, width]);
        
        translate([flex_thickness*2, thickness*4+din_thickness, 0]) {
            translate([flex_thickness, 0, 0])
            cube([flex_thickness*3, flex_thickness, width]) {
                position(LEFT)
                xrot(90)
                yrot(-90)
                prismoid([flex_thickness, width], [0, width], height=flex_thickness, shift=[flex_thickness/2, 0]);
            }
            
            translate([flex_thickness*3, -flex_thickness, 0])
            cube([flex_thickness, flex_thickness, width]);
        }
    }
}

din_clamp(40, 30);
    