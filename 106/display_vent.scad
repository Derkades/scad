include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 1;
$fs = 1;

module translate_screw_holes() {
    right(1.5)
    for (x = [-1, 1])
    for (y = [-1, 1])
    translate([x * 85/2, y * 58.8/2, 0])
    children();
}

t = 1.2;
pcb_t = 2.2; // incl protruding header pins
plate_t = t+pcb_t;
clip_height = 10;
clip_w = 8;

clip_depth = 21.5; // distance from outside to inside start of clip
depth = clip_depth + clip_height + 5;

diff()
rect_tube(size=[93.5, 59.8], wall=t, h=35, rounding=6) {
    // clips
    for (x = [-1, 1])
    right(x*41.5/2) {
        align([FRONT, BACK], inside=true, overlap=-0.01) {
            cuboid([clip_w+2, t+0.02, clip_depth+clip_height]);
            
            tag("keep")
            down(1)
            cuboid([clip_w, t+0.02, clip_depth+clip_height]);
        }
        
        position(BOTTOM)
        up(clip_depth + clip_height/2)
        attach([FRONT, BACK], FRONT)
        wedge([clip_w, 4, clip_height]) {
            attach(BOTTOM+BACK, FWD+LEFT, inside=true)
            rounding_edge_mask(clip_w+0.01, 2);
        }
    }
    
    tag("remove")
    position(BOTTOM)
    translate_screw_holes()
    cyl(d1=10, d2=3, h=20, anchor=BOTTOM);
    
    // allow pressing can cable clip with a screw driver to release it
    up(3)
    tag("remove")
    position(BOTTOM+BACK)
    back(0.01)
    cuboid([8, t+0.02, 10], anchor=BACK+BOTTOM, chamfer=2, edges="Y");
}

difference() {
    cuboid([100, 70, plate_t], rounding=5, edges="Z", anchor=TOP);
    
    up(0.01)
    cuboid([88, 53, plate_t+0.02], rounding=3, edges="Z", anchor=TOP);
    
    translate_screw_holes()
    screw_hole("M3", length=plate_t, anchor=TOP);
    
    // pcb
    down(t)
    left_half()
    cuboid([96, 53, pcb_t], anchor=TOP);   
}
