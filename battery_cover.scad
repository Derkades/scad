include <BOSL2/std.scad>
include <BOSL2/screws.scad>

iw = 67.1; 
id = 60.6;
h = 8; // zonder plexiglas
//h = 10; // met plexiglas
t = 2;
hole = true;

difference() {
    cuboid([iw+2*t, id+2*t, h+t]);
    
    up(t/2) cuboid([iw, id, h]);
    
    if (hole) {
        down(h/2)
        cuboid([iw-h*2, id-h*2, t]);
    }
}