include <BOSL2/std.scad>

$fs = 0.5;
$fa = 0.5;

difference() {
    down(3)
    cuboid([45, 25, 5], anchor=BOTTOM+RIGHT);
    
    left(2)
    cuboid([89.2, 20.2, 2.01], anchor=BOTTOM+RIGHT);
    
    left(2+29)
    cyl(d=6.1, h=3, anchor=TOP);
}
