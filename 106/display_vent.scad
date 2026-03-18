include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 1;
$fs = 1;

module translate_screw_holes() {
    left(1.5)
    for (x = [-1, 1])
    for (y = [-1, 1])
    translate([x * 85/2, y * 58.8/2, 0])
    children();
}

t = 1.2;
pcb_t = 2.2; // incl protruding header pins
plate_t = t+pcb_t;

difference() {
    rect_tube(size=[93.5, 59.8], wall=t, h=35, rounding=6) {
        // clips
        for (x = [-1, 1])
        right(x*41.5/2)
        for (pos = [BACK, FRONT])
        position(BOTTOM+pos)
        up(21.5)
        half_of(pos)
        xrot(45)
        cuboid([8, 2.5, 2.5]); 
    }
    
    translate_screw_holes()
    cyl(d1=10, d2=3, h=20, anchor=BOTTOM);
}

difference() {
    cuboid([100, 70, plate_t], rounding=5, edges="Z", anchor=TOP);
    
    cuboid([88, 53, plate_t], rounding=3, edges="Z", anchor=TOP);
    
    translate_screw_holes()
    screw_hole("M3", length=plate_t, anchor=TOP);
    
    // pcb
    down(t)
    right_half()
    cuboid([95, 53, pcb_t], anchor=TOP);   
}
