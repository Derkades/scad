include <BOSL2/std.scad>;

$fa = 0.2;
$fs = 0.2;

difference() {
    cuboid([60, 10, 2], rounding=4, edges="Z", anchor=BOTTOM); 
    
    right(25)
    #cyl(h=2, r=3, anchor=BOTTOM);
}
translate([-26, -2.5, 2]) linear_extrude(0.2) text("+31600000000", 5);
