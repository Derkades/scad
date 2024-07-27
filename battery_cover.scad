include <BOSL2/std.scad>
include <BOSL2/screws.scad>

iw = 67; 
id = 60.5;
h = 8; // zonder plexiglas
h = ; // met plexiglas
t = 1;
hole = true;

difference() {
    cuboid([iw+2*t, id+2*t, h+t]);
    
    up(t/2) cuboid([iw, id, h]);
    
    if (hole) {
        down(h/2)
        #cuboid([iw-h, id-h, t]);
    }
}