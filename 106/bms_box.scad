include <../libenclosure.scad>
include <BOSL2/screws.scad>
use <../din_clamp.scad>

enclosure_part = "box"; // box, lid, both
enclosure_length = 95;
enclosure_width = 58;
enclosure_depth = 35;
enclosure_thickness = 2;

render_din = false;
din_clamp_fwd = 5;
din_clamp_height = enclosure_width + enclosure_thickness*2 - din_clamp_fwd*2 + 1;
din_screw_dist = enclosure_length/4;
din_clamp_width = din_screw_dist + enclosure_width/4;
din_clamp_thickness = 3;

bms_x_dist = 62;
bms_y_dist = 48.5;
bms_x_offset = -(enclosure_length - 82.6) / 2;
bms_screw_height = 5;

module gx16() {
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
        
        translate_side("bottom")
        up(enclosure_thickness/2)
        right(bms_x_offset)
        xcopies(bms_x_dist)
        ycopies(bms_y_dist)
        cyl(d=8, h=bms_screw_height, anchor=BOTTOM);
    }
    
    // CAN connectors
    translate_side("lid")
    xcopies(enclosure_length/2)
    gx16();
    
    // Power and signals connector
    translate_side("right")
    zrot(90)
    xrot(90)
    gx16();
        
    // status led
    translate_side("lid")
    back(enclosure_width/3)
    cyl(h=enclosure_thickness+0.01, d=3.1);
    
    // screw holes to fix box to din rail clamp
    translate_side("bottom")
    xcopies(din_screw_dist)
    ycopies(enclosure_width/2) {
        down(din_clamp_thickness + enclosure_thickness/2)
        zflip()
        screw_hole("M3", length=20, head="flat", anchor=TOP);
        
        nut_trap_inline(enclosure_thickness+0.01, "M3");
    }
    
    // screw holes for ZEVA BMS
    translate_side("bottom")
    right(bms_x_offset)
    xcopies(bms_x_dist)
    ycopies(bms_y_dist) {
        up(enclosure_thickness/2 + bms_screw_height/2)
        screw_hole("M3", length=bms_screw_height);
        
        nut_trap_inline(enclosure_thickness+0.01, "M3", anchor=CENTER);
    }
}