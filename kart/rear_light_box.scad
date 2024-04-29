include <../BOSL2/std.scad>

iw = 100;
ih = 52 + 2;
h = 10;
wall = 2;

difference() {
    cuboid([iw+wall*2, ih+wall*2, h], anchor=BOTTOM);
    
    translate([0, 0, wall])
    cuboid([iw, ih, h], anchor=BOTTOM);
    
    // tie wrap and cable  holes
    for (x = [-iw/3, 0, iw/3]) {
        translate([x, -ih/2, 0])
        #cuboid([6, 1.7, wall], anchor=BOTTOM+FRONT);
    }
}