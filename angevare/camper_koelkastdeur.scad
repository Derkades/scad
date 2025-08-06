include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

$fa = 0.5;
$fs = 0.5;


difference() {
    union() {
        hull() {
            cuboid([30, 10, 5], anchor=TOP+LEFT);
            cyl(r=5, h=5, anchor=TOP+RIGHT);
        }

        cyl(r=5, h=33, anchor=BOTTOM+RIGHT);
    }
    
    left(2.5)
    cyl(r=2.5, h=100, anchor=RIGHT);
    
    left(5)
    cyl(r1=4, r2=0, h=5, anchor=RIGHT+TOP);
}