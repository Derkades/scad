include <BOSL2/std.scad>
include <BOSL2/screws.scad>

screw_dist = 103;
length = screw_dist + 20;
width = 20;
thick = 5;
height = 31;
grab_length = 30;

difference() {
        cube([length, width, thick], anchor=BOTTOM);
       
    
    for (x = [-screw_dist/2, screw_dist/2])
    translate([x, 0, thick/2])
    screw_hole("M3", length=thick, $fn=20);
}

cube([thick, width, height], anchor=BOTTOM);

translate([-grab_length/2+thick/2, 0, height])
cube([grab_length, width, thick], anchor=BOTTOM);
    
for (y = [-width/2+thick/2, width/2-thick/2]) {
    // tall triangles
    prism1_h = height;
    translate([thick/2, y, thick*2])
    prismoid(size1=[prism1_h, thick], size2=[0, thick], h=prism1_h, shift=[-prism1_h/2, 0], anchor=BOTTOM+LEFT);

    // short triangles
    board_thickness = 18;
    prism2_h = prism1_h - thick*2 - board_thickness;
    translate([-thick/2, y, thick*2])
    prismoid(size1=[prism2_h, thick], size2=[0, thick], h=prism2_h, shift=[prism2_h/2, 0], anchor=BOTTOM+RIGHT);
    
    translate([-grab_length/2+thick/2, y, height+thick])
    cube([grab_length, thick, thick], anchor=BOTTOM);
}

difference() {
    cube([length, width, thick*2], anchor=BOTTOM);
    
    cube([length-thick*2, width-thick*2, thick*2], anchor=BOTTOM);
}