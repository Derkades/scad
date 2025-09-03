include <BOSL2/std.scad>

length = 110;
width = 54;
height = 30;

cuboid([length+8, width+8, 2], anchor=TOP, chamfer=1, edges="Z");

difference() {
    rect_tube(height, isize=[length, width], wall=4, chamfer=1);

    back(width/2+2)
    cuboid([length - 40, 2, height], anchor=BOTTOM+BACK);

    fwd(width/2+2)
    cuboid([length - 40, 2, height], anchor=BOTTOM+FRONT);
    
    right(length/2)
    cuboid([2, width, height], anchor=BOTTOM+LEFT);
    
    left(length/2)
    cuboid([2, width, height], anchor=BOTTOM+RIGHT);
}