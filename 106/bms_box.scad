include <../libenclosure.scad>
include <BOSL2/screws.scad>
use <../din_clamp.scad>

enclosure_part = "lid"; // box, lid, both
enclosure_length = 84;
enclosure_width = 58;
enclosure_depth = 35;
enclosure_thickness = 2;

render_din = false; // set enclosure_part to an invalid value to only render din
din_clamp_fwd = 5;
din_clamp_height = enclosure_width + enclosure_thickness*2 - din_clamp_fwd*2 + 1;
din_clamp_width = enclosure_length/2;
din_clamp_thickness = 3;

module gx16_4() {
    cyl(h=enclosure_thickness+0.1, d=15.3);
    
    for (a = [0, 120, 240])
    zrot(a)
    fwd(24/2)
    screw_hole("M3", length=enclosure_thickness+0.1);
}

difference() {
    if (render_din) {
        fwd(din_clamp_fwd)
        zrot(-90)
        xrot(-90)
        din_clamp(din_clamp_height, din_clamp_width, din_clamp_thickness);
    } else {
        enclosure();
    }
    
    // CAN connectors
    translate_side("lid")
    for (x = [-1, 1])
    right(x * enclosure_length/4)
    gx16_4();
    
    // Power connector
    translate_side("right")
    zrot(90)
    xrot(90)
    gx16_4();
        
    // status led
    translate_side("lid")
    back(enclosure_width/3)
    cyl(h=enclosure_thickness+0.01, d=3.1);
    
    // screw holes to fix box to din rail clamp
    translate_side("bottom")
    for (x = [-1, 1])
    for (y = [-1, 1])
    translate([x*din_clamp_width/4, y*enclosure_width/4, 0]) {
        down(din_clamp_thickness + enclosure_thickness/2)
        zflip()
        screw_hole("M3", length=20, head="flat", anchor=TOP);
        
        nut_trap_inline(enclosure_thickness+0.01, "M3");
    }
    
    // screw holes for ZEVA BMS
    bms_x_dist = 62;
    bms_y_dist = 48.5;
    translate_side("bottom")
    for (x = [-bms_x_dist/2, bms_x_dist/2])
    for (y = [-bms_y_dist/2, bms_y_dist/2])
    translate([x, y, 0])
    zflip()
    screw_hole("M3", head="flat", length=enclosure_thickness+0.01);
}