include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

cyl(h=2, d=25, anchor=TOP);
difference() {
    cyl(h=15, d1=20, d2=16, anchor=BOTTOM);
    cyl(h=15, d=14, anchor=BOTTOM);  
}