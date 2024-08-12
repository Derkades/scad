include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <BOSL2/rounding.scad>

$fa = 1;
$fs = 1;

plate_thickness = 5;

difference() {
    cuboid([120, 120, plate_thickness]);

    for (x = [-50, 50]) {
        for (y = [-50, 50]) {
            translate([x, y, 0])
            screw_hole("M4", length=plate_thickness);
        }
    }
    
    for (x = [-20, 20]) {
        translate([x, 0, 0])
        screw_hole("M4", length=plate_thickness, head="flat");
    }
    
    for (a = [0, 90, 180, 270]) {
        zrot(a)
        back(60)
        xrot(90)
        prismoid(size1=[80, plate_thickness], size2=[0, plate_thickness], h=25);
    }
}