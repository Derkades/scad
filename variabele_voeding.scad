include <BOSL2/std.scad>

enclosure_inner_length = 115;
enclosure_inner_width = 55;
enclosure_inner_depth = 40;

enclosure_thickness = 1.2;

cover_thickness = enclosure_thickness;

part = "enclosure"; // [enclosure:Enclosure, cover:Cover, both:Enclosure and Cover]

module make_holes() {
    right(40) {
        back(15) round_hole("lid", 7/2);
        fwd(15) round_hole("lid", 7/2);
        back(18.5) round_hole("lid", 1);
        fwd(18.5) round_hole("lid", 1);
    }
    
    cuboid_hole("right", 8.15, 15.45);

    left(10)
    cuboid_hole("lid", 75, 39);    
}

print_part();

module print_part() {
	if (part == "enclosure" || part == "both") {
		box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
        
        left(8/2)
        translate_side("right")
        difference() {
            cuboid([8.15+2, 8, 15.45+2]);
            cuboid([8.15, 8, 15.45]);
        }
	}
    
    if (part == "cover" || part == "both") {
		lid2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2+0.10,cover_thickness);
	}
}

module screws(in_x, in_y, in_z, shell) {
	sx = in_x/2 - 4;
	sy = in_y/2 - 4;
	sh = shell + in_z - 12;
	nh = shell + in_z - 4;

	translate([0,0,0]) {
		translate([sx , sy, sh]) cylinder(r=1.7, h = 15, $fn=32);
		translate([sx , -sy, sh ]) cylinder(r=1.7, h = 15, $fn=32);
		translate([-sx , sy, sh ]) cylinder(r=1.7, h = 15, $fn=32);
		translate([-sx , -sy, sh ]) cylinder(r=1.7, h = 15, $fn=32);
	
	
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
   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
		translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=shell, $fn=32);
	}
}

module sides(in_x, in_y, in_z, shell) {
	translate([0,0,shell])
	difference() {
		hull() {
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=in_z, $fn=32);
		}
	
		hull() {
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell,h=in_z+1, $fn=32);
		}
	}
	
	intersection() {
		translate([-in_x/2, -in_y/2, shell]) cube([in_x, in_y, in_z+2]);
		union() {
			translate([-in_x/2 , -in_y/2,shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
			translate([-in_x/2 , -in_y/2,shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
		
			translate([in_x/2 , -in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
			translate([in_x/2 , -in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
		
			translate([in_x/2 , in_y/2,  shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
			translate([in_x/2 , in_y/2,  shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
		
			translate([-in_x/2 , in_y/2, shell + in_z -6]) cylinder(r=9, h = 6, $fn=64);
			translate([-in_x/2 , in_y/2, shell + in_z -10]) cylinder(r1=3, r2=9, h = 4, $fn=64);
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
	   	 	translate([-in_x/2+shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
			translate([+in_x/2-shell, -in_y/2+shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
			translate([+in_x/2-shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
			translate([-in_x/2+shell, in_y/2-shell, 0]) cylinder(r=shell*2,h=top_thickness, $fn=32);
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

module lid2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
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
        make_holes();
	}
}

module box2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
    difference() {
        union() {
            bottom(in_x, in_y, in_z, shell);
            sides(in_x, in_y, in_z, shell);
        }
		screws(in_x, in_y, in_z, shell);
        make_holes();
	}
	lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
}

module punch_hole(cylinder, rotate, translate_coords) {
	translate(translate_coords)
    rotate(rotate)
    cylinder(h = cylinder[1], r=cylinder[0], center = false, $fn=32);
}

module translate_side(side) {
    if (side == "right") {
        translate([enclosure_inner_length/2+enclosure_thickness/2, 0, enclosure_inner_depth/2])
        xrot(90)
        zrot(90)
        children();
    } else if (side == "lid") {
        translate([0, 0, enclosure_inner_depth+enclosure_thickness*1.5])
        xrot(90)
        children();
    }
}

module cuboid_hole(side, width, height) {
    translate_side(side)
    #cuboid([width, enclosure_thickness, height]);
}

module round_hole(side, radius) {
    translate_side(side)
    xrot(-90)
    #cyl(h=enclosure_thickness, r=radius, $fn=32);
}

//module hole(side, radius, offset) {
//	// side is "[length/width]_[1/2]"
//	// radius is hole radius
//	// offset is [horizontal, height] from the [center, bottom] of the side, or from the [center, center] of the lid.
//
//	if (side == "right") {
//		rotate = [90,0,90];
//		translate_coords = [enclosure_thickness+1, offset[0], offset[1]];
//		length = enclosure_inner_length/2;
//		punch_hole([radius, length], rotate, translate_coords);
//	}
//	if (side == "left") {
//        rotate = [90,0,270];
//        translate_coords = [-(enclosure_thickness+1), offset[0], offset[1]];
//        length = enclosure_inner_length/2;
//        punch_hole([radius, length], rotate, translate_coords);
//	}
//	if (side == "front") {
//		rotate = [90,0,0];
//		translate_coords = [offset[0], -(enclosure_thickness+1), offset[1]];
//		length = enclosure_inner_width/2;
//		punch_hole([radius, length], rotate, translate_coords);
//	}
//	if (side == "back") {
//		rotate = [90,0,180];
//		translate_coords = [offset[0], enclosure_thickness+1, offset[1]];
//		length = enclosure_inner_width/2;
//		punch_hole([radius, length], rotate, translate_coords);
//	}
//	if (side == "lid") {
//		rotate = [0,0,0];
//		translate_coords = [offset[0], offset[1], enclosure_inner_depth-cover_thickness];
//		length = enclosure_inner_depth/2;
//		punch_hole([radius, length], rotate, translate_coords);
//	}
//    if (side == "bottom") {
//		rotate = [0,0,0];
//		translate_coords = [offset[0], offset[1], 0];
//		length = enclosure_thickness;
//		punch_hole([radius, length], rotate, translate_coords);
//	}
//}