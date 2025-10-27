include <BOSL2/std.scad>

e = 0.01;

xt60_w = 15.6;
xt60_h = 8.3;
xt60_d = 6.5;

display_w = 45.1;
display_h = 26.5;

text_d = 0.4;

enclosure_inner_length = display_w + 2*22;
enclosure_inner_width = display_h + 10;
enclosure_inner_depth = 21;

enclosure_thickness = 2;

cover_thickness = enclosure_thickness;

part = "enclosure"; // [enclosure:Enclosure, cover:Cover, both:Enclosure and Cover]

module custom_remove() {       
    cuboid_hole("right", xt60_h, xt60_w);
    cuboid_hole("left", xt60_h, xt60_w);

    cuboid_hole("lid", display_w, display_h);
    
    fwd(enclosure_thickness/2+e)
    translate_side("front")
    text3d("XT60 voltmeter", anchor=TOP, h=text_d, size=8, center=true);
}

module custom_add() {
    left(xt60_d/2)
    translate_side("right")
    difference() {
        cuboid([xt60_h+2, xt60_w+2, xt60_d]);
        cuboid([xt60_h, xt60_w, xt60_d+e]);
    }
    
    right(xt60_d/2)
    translate_side("left")
    difference() {
        cuboid([xt60_h+2, xt60_w+2, xt60_d]);
        cuboid([xt60_h, xt60_w, xt60_d+e]);
    }
}

print_part();

module print_part() {
	if (part == "enclosure" || part == "both") {
		box2(enclosure_inner_length,enclosure_inner_width,enclosure_inner_depth,enclosure_thickness,enclosure_thickness/2-0.10,cover_thickness);
        custom_add();
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
        custom_remove();
	}
}

module box2(in_x, in_y, in_z, shell, top_lip, top_thickness) {
    difference() {
        union() {
            bottom(in_x, in_y, in_z, shell);
            sides(in_x, in_y, in_z, shell);
        }
		screws(in_x, in_y, in_z, shell);
        custom_remove();
	}
	lid_top_lip2(in_x, in_y, in_z, shell, top_lip, top_thickness);
}

module punch_hole(cylinder, rotate, translate_coords) {
	translate(translate_coords)
    rotate(rotate)
    cylinder(h = cylinder[1], r=cylinder[0], center = false, $fn=32);
}

module translate_side(side) {
    up(enclosure_inner_depth/2 + enclosure_thickness)  // center vertically
    if (side == "right") {
        right(enclosure_inner_length/2+enclosure_thickness/2)
        yrot(90)
        children();
    } else if (side == "left") {
        left(enclosure_inner_length/2+enclosure_thickness/2)
        yrot(90)
        children();
    } else if (side == "lid") {
        up(enclosure_inner_depth/2+enclosure_thickness/2)
        children();
    } else if (side == "front") {
        fwd(enclosure_inner_width/2+enclosure_thickness/2)
        xrot(90)
        children();
    }
}

module cuboid_hole(side, width, height) {
    translate_side(side)
    cuboid([width, height, enclosure_thickness+e], anchor=CENTER);
}

module round_hole(side, radius) {
    translate_side(side)
    xrot(-90)
    cyl(h=enclosure_thickness, r=radius, $fn=32);
}