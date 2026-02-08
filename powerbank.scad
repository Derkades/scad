include <libenclosure.scad>

e = 0.01;

xt60_w = 16.4; // loose fit so other connector can fit inside
xt60_h = 8.6; // loose fit so other connector can fit inside

display_w = 45.1;
display_h = 26.5;

enclosure_part = "both";
enclosure_length = 118; // x
enclosure_width = 100; // y
enclosure_depth = 69;
enclosure_thickness = 2;

pcb_offset = 12.5; // offset center of PCB to center of left side panel (determines position of display)
pcb_t = 1.6; // does NOT include margin as it is used for other calculations
pcb_l = 80; // does NOT include margin as it is used for other calculations
pcb_h = 25; // does NOT include margin as it is used for other calculations
pcb_components_w = 76;

bat_dim_x = 101.2; // x (includes margin)
bat_dim_y = 81; // y (includes margin)
bat_dim_z = 67.1; // z (includes margin)
bat_support_t = enclosure_thickness;

support_length = enclosure_length - bat_dim_x - bat_support_t;

module xt60(d) {
    hull() {
        down(xt60_w/4)
        cuboid([xt60_h, d, xt60_w/2]);

        up(xt60_w/2 - xt60_h/2)
        xrot(90)
        cyl(d=xt60_h, h=d);
    }
}

difference() {
    enclosure();
    
    translate_side("lid")
    left(enclosure_length/2 + enclosure_thickness/2 - pcb_offset) {
        // button
        back(pcb_l/2 - 75.4)
        left(3)
        cyl(d=2.8, l=enclosure_thickness+0.01);
        
        // DC in
        back(pcb_l/2 - 67.5)
        left(5.9)
        cyl(d=7.7, l=enclosure_thickness+0.01);
        
        // lightning
        back(pcb_l/2 - 50.2 - 9.8/2)
        right(2.5)
        cuboid([3.7, 10.4, enclosure_thickness+0.01]);
        
        // usb B micro
        back(pcb_l/2 - 51 - 7.6/2)
        left(pcb_t/2 + 2.3/2)
        cuboid([2.7, 7.7, enclosure_thickness+0.01], chamfer=0.7, edges=[FRONT+RIGHT,BACK+RIGHT]);
        
        // usb C
        back(pcb_l/2 - 38.4 - 9.3/2)
        left(4.9 - 3.2/2 - pcb_t/2)
        cuboid([3.5, 9.3, enclosure_thickness+0.01], rounding=1, edges="Z");
        
        // usb A
        back(pcb_l/2 - 21 - 13.1/2)
        left(8.15 - 5.6/2 - pcb_t/2)
        cuboid([6, 13.8, enclosure_thickness+0.01]);

        // usb A
        back(pcb_l/2 - 3 - 13.1/2)
        left(8.15 - 5.6/2 - pcb_t/2)
        cuboid([6, 13.8, enclosure_thickness+0.01]);
    }
    
    // display
    translate_side("left")
    up(enclosure_depth/2 - 1.5 - 8/2)
    fwd(pcb_l/2 - 18.2 - 12/2)
    cuboid([enclosure_thickness+0.01, 12.4, 8.6]);
    
    // xt60 hole
    translate_side("front")
    left(enclosure_length/2 - support_length/2)
    xt60(enclosure_thickness+0.1);
}

if (enclosure_part == "box" || enclosure_part == "both") {
    // pcb support
    top_offset = 5; // leave room to insert nut and for wires
    translate_side("left")
    difference() {
        for (s = [-1, 1])
        fwd(s * pcb_l/2)
        right(support_length/2+enclosure_thickness/2)
        down(top_offset/2)
        cuboid([support_length, 2*pcb_t, enclosure_depth-top_offset]);
        
        // pcb
        up(enclosure_depth/2 - (pcb_h+0.2)/2)
        right(pcb_offset)
        #cuboid([pcb_t+0.4, pcb_l+0.4, pcb_h+0.2]);
    
        fwd(pcb_l/2)
        right(support_length/2+enclosure_thickness/2)
        xt60(2*pcb_t+0.01);
    }
    
    // hold battery in place
    translate_side("right") {
        // near pcb
        down(top_offset/2)
        left(bat_dim_x + enclosure_thickness/2 + bat_support_t/2)
        cuboid([bat_support_t, enclosure_width, enclosure_depth-top_offset]);
    
        // other two sides
        down(enclosure_depth/4)
        left(bat_dim_x/2 + enclosure_thickness/2)
        for (s = [-1, 1])
        fwd(s * bat_dim_y/2 + bat_support_t/2)
        cuboid([bat_dim_x, bat_support_t, enclosure_depth/2]);
    }
    
    // xt60 support
    xt60_support_length = (enclosure_width - pcb_l)/2;
    translate_side("front")
    left(enclosure_length/2 - support_length/2)
    back(xt60_support_length/2+enclosure_thickness/2)
    difference() {
        cuboid([xt60_h+2, xt60_support_length, xt60_w+2]);
        xt60(xt60_support_length+0.01);
    }
}

translate_side("right")
left(enclosure_thickness/2)
%cuboid([bat_dim_x, bat_dim_y, bat_dim_z], anchor=RIGHT);
