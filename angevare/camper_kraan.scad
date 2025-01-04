include <../BOSL2/std.scad>

$fs = 0.5;
$fa = 0.5;

difference() {
   union() {
cyl(r=40/2, h=1, anchor=BOTTOM);
up(1)
cyl(r=33.5/2, h=0.3, anchor=BOTTOM);
   }
   
   cyl(r=20/2, h=2, anchor=BOTTOM);

}