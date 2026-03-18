include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fs = 1;
$fa = 1;

difference() {
//    diff()
    cuboid([100, 70, 12.70], chamfer=2, edges=[BOTTOM, "Z"], anchor=BOTTOM) {
//        edge_profile([BOTTOM])
//        mask2d_chamfer(3); 
    }
//        cuboid([100, 70, 12.70], chamfer=3, edges=BOTTOM, anchor=BOTTOM);
    
    // inner
    up(5.7)
    cuboid([95.5, 65.7, 20], rounding=2, edges="Z", anchor=BOTTOM);
    
    // display housing
    left(2.5)
    up(1.6)
    cuboid([80.5, 57.8, 5], anchor=BOTTOM);
    
    // display user facing
    down(0.01)
    left(12.3/2)
    cuboid([67.5, 51, 2], chamfer=-1, edges=BOTTOM, anchor=BOTTOM);
    
    // pcb/header
    up(3)
    right_half()
    cuboid([95.5, 50.5, 5], anchor=BOTTOM);
        
    // screw holes
    left(7-4.5)
    up(1)
    for (x = [-1, 1])
    for (y = [-1, 1])
    translate([x * 85/2, y * 58.8/2, 0])
    cyl(d=2.5, h=10, anchor=BOTTOM);
    
    // cosmetic "vents"
    down(0.01)
    right(100/2 - 11)
    ycopies(l=49, n=11)
    cuboid([9.3, 2.3, 0.7], chamfer=0.7, edges=TOP, anchor=BOTTOM); 

}