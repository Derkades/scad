include <../BOSL2/std.scad>
include <../BOSL2/screws.scad>

$fa = 0.5;
$fs = 0.5;

binnen = false;

h = binnen ? 11.5 : 6;

difference() {
    // moet eigenlijk bolvormig zijn aan de bovenkant
    cyl(r=50/2, h=h, anchor=BOTTOM, chamfer2=1);
    
    if (binnen) {
        cyl(r=15/2, h=h, anchor=BOTTOM);
        cyl(r=32/2, h=h-1.5, anchor=BOTTOM);
    } else {  
        cyl(r=32/2, h=h-2, anchor=BOTTOM);
        
        up(h-2)
        cyl(r=12/2, h=2, anchor=BOTTOM);
       
        up(h-2)
        zrot(45)
        difference() {
            pie_slice(ang=90, l=2, r1=15, r2=17);
            pie_slice(ang=90, l=2, r=9);
        }
    }
    
    up(h)
    for (x = [-18, 18]) {
        right(x)
        screw_hole(spec="M2.5", head="flat", length=h, anchor=TOP);
    }
}