include <BOSL2/std.scad>

$fs = 0.5;
$fa = 0.5;

difference() {
   union() {
cyl(r=45/2, h=2, anchor=BOTTOM);
up(2)
cyl(r=33.5/2, h=1.5, anchor=BOTTOM);
   }

   cyl(r=20/2, h=4, anchor=BOTTOM);

}
