include <BOSL2/std.scad>

x1 = 19.5;
x2 = 23;
y = 1.6;
z = 20;
shell = 1;

difference() {
    prismoid([x1+shell*2, y+shell*2], [x2+shell*2, y+shell*2], z+shell);
    
    translate([0, 0, shell]) 
    prismoid([x1, y], [x2, y], z+0.001);
}
