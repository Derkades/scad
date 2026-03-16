include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

difference() {
    union() {
        //tube(h=1.2, od=10, id=5,, anchor=TOP);
        tube(h=6.2, od=7, id=5.4, anchor=BOTTOM);
        
        for (z = [0, 1, 2])
        up(z*2)
        for (y = [-1, 1])
        back(y*2.5)
        cuboid([3, 0.5, 1], anchor=BOTTOM);
    }
    
    cuboid([20, 2, 50], anchor=LEFT);
}