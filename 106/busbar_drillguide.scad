include <BOSL2/std.scad>

$fs = 0.5;
$fa = 0.5;

l = 66;
w = 20.2;
t = 1.2;

difference() {
    right(t)
    down(3)
    cuboid([l+t, w+2*t, 5], anchor=BOTTOM+RIGHT);
    
    cuboid([l+0.01, w, 2.01], anchor=BOTTOM+RIGHT);
    
    // save filament
    left(t)
    cuboid([l-12-t, w-2*t, 5], anchor=TOP+RIGHT);
        
    left(60)
    cyl(d=6.1, h=3, anchor=TOP);
}
