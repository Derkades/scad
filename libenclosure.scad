include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

// these variables are expected to be defined:
// enclosure_part (box, lid, both)
// enclosure_length (inner)
// enclosure_width (inner)
// enclosure_depth (inner)
// enclosure_thickness
// length, width, depth are inner dimensions

$fa = 0.5;
$fs = 0.5;

module enclosure() {
	if (enclosure_part == "box" || enclosure_part == "both") {
		box(enclosure_length, enclosure_width, enclosure_depth, enclosure_thickness, enclosure_thickness/2-0.10, enclosure_thickness);
	}
    
    if (enclosure_part == "lid" || enclosure_part == "both") {
		lid(enclosure_length, enclosure_width, enclosure_depth, enclosure_thickness, enclosure_thickness/2+0.10, enclosure_thickness);
	}
}

module screws(in_x, in_y, in_z, shell) {
	sx = in_x/2 - 4;
	sy = in_y/2 - 4;
	sh = shell + in_z - 12;
	nh = shell + in_z - 4;

	translate([0,0,0]) {
		translate([sx , sy, sh]) cylinder(r=1.7, h = 15);
		translate([sx , -sy, sh ]) cylinder(r=1.7, h = 15);
		translate([-sx , sy, sh ]) cylinder(r=1.7, h = 15);
		translate([-sx , -sy, sh ]) cylinder(r=1.7, h = 15);
		
		translate([-sx , -sy, nh ]) rotate([0,0,-45]) 
			translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
		translate([sx , -sy, nh ]) rotate([0,0,45]) 
			translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
		translate([sx , sy, nh ]) rotate([0,0,90+45]) 
			translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
		translate([-sx , sy, nh ]) rotate([0,0,-90-45]) 
			translate([-5.75/2, -5.6/2, -0.7]) cube ([5.75, 10, 2.8]);
	}
}

module bottom(in_x, in_y, in_z, shell) {
	hull() {
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell);
	}
}

module sides(in_x, in_y, in_z, shell) {
	translate([0,0,shell])
	difference() {
		hull() {
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z);
		}
	
		hull() {
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1);
		}
	}
	
	intersection() {
		translate([-in_x/2, -in_y/2, shell]) cube([in_x, in_y, in_z+2]);
		union() {
			translate([-in_x/2 , -in_y/2,shell + in_z -6]) cylinder(r=9, h = 6);
			translate([-in_x/2 , -in_y/2,shell + in_z -10]) cylinder(r1=3, r2=9, h = 4);
		
			translate([in_x/2 , -in_y/2, shell + in_z -6]) cylinder(r=9, h = 6);
			translate([in_x/2 , -in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4);
		
			translate([in_x/2 , in_y/2,  shell + in_z -6]) cylinder(r=9, h = 6);
			translate([in_x/2 , in_y/2,  shell + in_z -10]) cylinder(r1=3, r2=9, h = 4);
		
			translate([-in_x/2 , in_y/2, shell + in_z -6]) cylinder(r=9, h = 6);
			translate([-in_x/2 , in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4);
		}
	}
}

module lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness) {

	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);

	translate([0,0,shell+in_z])

	difference() {
		hull() {
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness);
		}		
        
		translate([0, 0, -1]) linear_extrude(height = top_thickness + 2) polygon(points = [
			[cxm+5, cym],
			[cxm, cym+5],
			[cxm, cyp-5],
			[cxm+5, cyp],
			[cxp-5, cyp],
			[cxp, cyp-5],
			[cxp, cym+5],
			[cxp-5, cym]]);
	}
}

module lid(in_x, in_y, in_z, shell, top_lip, top_thickness) {
	cxm = -in_x/2 - (shell-top_lip);
	cxp = in_x/2 + (shell-top_lip);
	cym = -in_y/2 - (shell-top_lip);
	cyp = in_y/2 + (shell-top_lip);	

	difference() {
		translate([0, 0, in_z+shell]) 
        linear_extrude(height = top_thickness ) 
        polygon(points = [
			[cxm+5, cym],
			[cxm, cym+5],
			[cxm, cyp-5],
			[cxm+5, cyp],
			[cxp-5, cyp],
			[cxp, cyp-5],
			[cxp, cym+5],
			[cxp-5, cym]]);
	
		screws(in_x, in_y, in_z, shell);
	}
}

module box(in_x, in_y, in_z, shell, top_lip, top_thickness) {
    difference() {
        union() {
            bottom(in_x, in_y, in_z, shell);
            sides(in_x, in_y, in_z, shell);
        }
		screws(in_x, in_y, in_z, shell);
	}
	lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
}

module translate_side(side) {
    up(enclosure_depth/2 + enclosure_thickness)  // center vertically
    if (side == "right") {
        right(enclosure_length/2+enclosure_thickness/2)
        children();
    } else if (side == "left") {
        left(enclosure_length/2+enclosure_thickness/2)
        children();
    } else if (side == "lid") {
        up(enclosure_depth/2+enclosure_thickness/2)
        children();
    } else if (side == "front") {
        fwd(enclosure_width/2+enclosure_thickness/2)
        children();
    }
}