include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

t = 2;
w_bottom = 82.7;
height = 25;

original_fuse_support = true;

module main_shape(h) {
    hull() {
        cuboid([w_bottom, t, h], anchor=FRONT);
        
        back(t)
        cuboid([60, 45, h], anchor=FRONT, rounding=2, edges="Z");
    }
}

module middle() {
    difference() {
        main_shape(height);
        
        back(t)
        scale([56/60, 41/45, 2])
        main_shape(height);
        
        // holes for copper lugs
        c_to_c_distance = 8/2 + 18.5/2;
        for (x = [-c_to_c_distance, c_to_c_distance])
        translate([x, t/2, -0.5])
        cuboid([18.5, t+0.01, 9.4], rounding=1, edges="Y");
    }
    
    down(height/4)
    if (original_fuse_support) {
        original_fuse_w = 47.8;
        for (x = [-original_fuse_w/2-t/2, original_fuse_w/2+t/2])
        right(x)
        cuboid([t, 45, height/2], anchor=FRONT);
        
        back(40+t)
        cuboid([original_fuse_w, 4, height/2], anchor=FRONT);
    }
    
    circ_w = 36;
    circ_d = 20;
    circ_id = 17.2;
    circ_h = 10;
    circ_down = -circ_d/2+height/2;
    down(circ_down)
    fwd(circ_h/2)
    xrot(90) {
        for (x1 = [-circ_w/2+0.01, circ_w/2-0.01])
        difference() {
            hull() {
                for (x2 = [x1+circ_w/2-circ_d/2, x1-circ_w/2+circ_d/2])
                right(x2)
                cyl(d=circ_d, h=circ_h);
            }        

            hull() {
                for (x2 = [x1+circ_w/2-circ_d/2, x1-circ_w/2+circ_d/2])
                right(x2)
                cyl(d=circ_id, h=circ_h+0.01);
            }       
        }
    }
    
    // clips
    down(circ_down) {
        left(w_bottom/2-1/2)
        cuboid([1, 15, 12], anchor=BACK) {
            position(RIGHT+FRONT)
            cuboid([1, 4, 12], anchor=FRONT+LEFT, chamfer=1, edges=[BACK+RIGHT, FRONT+RIGHT]);
        }
        
        right(w_bottom/2-1/2)
        cuboid([1, 15, 12], anchor=BACK) {
            position(LEFT+FRONT)
            cuboid([1, 4, 12], anchor=FRONT+RIGHT, chamfer=1, edges=[BACK+LEFT, FRONT+LEFT]);
        }
    }
}

down(height/2-t/2)
main_shape(t);

middle();