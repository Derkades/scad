include <BOSL2/std.scad>
include <BOSL2/screws.scad>

iw = 67; 
id = 60.5;
h = 8;
t = 1;

difference() {
    cuboid([iw+2*t, id+2*t, h+t]);
    
    up(t) cuboid([iw, id, h]);
}