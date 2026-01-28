include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

t = 2;
h = 25-t*2;

module bottom() {
    hull() {
        cuboid([82.7, t, t], anchor=BACK+TOP);
        cuboid([60, 45, t], anchor=FRONT+TOP);
    }
}

module middle() {
    difference() {
        hull() {
            cuboid([82.7, t, h], anchor=BACK);
            cuboid([60, 45, h], anchor=FRONT);
        }
        hull() {
            cuboid([82.7-t*2, 0.01, h + 0.01], anchor=BACK);
            cuboid([60-t*2, 45-t, h + 0.01], anchor=FRONT);
        }
        
        // holes for copper lugs
        c_to_c_distance = 8/2 + 18.5/2;
        down(.5)
        for (x = [-c_to_c_distance, c_to_c_distance])
        right(x)
        cuboid([18.5, t+0.01, 9.4], anchor=BACK, rounding=1, edges="Y");
    }
    
    circ_w = 36;
    circ_d = 20;
    circ_id = 17.2;
    circ_h = 10;
    down(circ_d/2-h/2+t*1.5)
    fwd(circ_h/2)
    xrot(90) {
        for (x1 = [-circ_w/2, circ_w/2])
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
}

down(h/2)
bottom();
middle();