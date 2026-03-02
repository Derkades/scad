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
		box(enclosure_length, enclosure_width, enclosure_depth, enclosure_thickness);
	}
    
    if (enclosure_part == "lid" || enclosure_part == "both") {
		lid(enclosure_length, enclosure_width, enclosure_depth, enclosure_thickness);
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
    cuboid([in_x+2*shell, in_y+2*shell, shell], rounding=shell*2, edges="Z", anchor=BOTTOM);
}

module sides(in_x, in_y, in_z, shell) {
    up(shell)
    rect_tube(in_z, [in_x+2*shell, in_y+2*shell], [in_x, in_y], rounding=shell*2, anchor=BOTTOM);
	
	intersection() {
		translate([-in_x/2, -in_y/2, shell]) cube([in_x, in_y, in_z+2]);
		union() {
            for (x = [-in_x/2, in_x/2])
            for (y = [-in_y/2, in_y/2])
            translate([x, y, in_z-shell/2]) {
                cyl(r=9, h=6);
                
                down(6/2+4/2)
                cyl(r1=3, r2=9, h=4);
            }
		}
	}
}

module lid_top_lip(in_x, in_y, in_z, t) {
    difference() {
        up(in_z+t)
        bottom(in_x, in_y, in_z, t);
        
        up(in_z+t-0.01)
        cuboid([in_x+t+0.1, in_y+t+0.1, t+0.02], chamfer=t*2, edges="Z", anchor=BOTTOM);
    }
}

module lid(in_x, in_y, in_z, t) {
    difference() {
        up(in_z+t)
        cuboid([in_x+t-0.1, in_y+t-0.1, t], chamfer=t*2, edges="Z", anchor=BOTTOM);
        
        screws(in_x, in_y, in_z, t);  
    }
}

module box(in_x, in_y, in_z, shell) {
    difference() {
        union() {
            bottom(in_x, in_y, in_z, shell);
            sides(in_x, in_y, in_z, shell);
        }
		screws(in_x, in_y, in_z, shell);
	}
	lid_top_lip(in_x, in_y, in_z, shell);
}

module translate_side(side) {
    up(enclosure_depth/2 + enclosure_thickness)  // center vertically
    if (side == "right") {
        if (enclosure_part == "box" || enclosure_part == "both")
        right(enclosure_length/2+enclosure_thickness/2)
        children();
    } else if (side == "left") {
        if (enclosure_part == "box" || enclosure_part == "both")
        left(enclosure_length/2+enclosure_thickness/2)
        children();
    } else if (side == "lid") {
        if (enclosure_part == "lid" || enclosure_part == "both")
        up(enclosure_depth/2+enclosure_thickness/2)
        children();
    } else if (side == "front") {
        if (enclosure_part == "box" || enclosure_part == "both")
        fwd(enclosure_width/2+enclosure_thickness/2)
        children();
    } else if (side == "bottom") {
        if (enclosure_part == "box" || enclosure_part == "both")
        down(enclosure_depth/2+enclosure_thickness/2)
        children();
    }
}