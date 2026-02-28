include <libenclosure.scad>

e = 0.01;

xt60_w = 15.6;
xt60_h = 8.3;
xt60_d = 6.5;

display_w = 45.1;
display_h = 26.5;

enclosure_part = "both";
enclosure_length = display_w + 2*22;
enclosure_width = display_h + 10;
enclosure_depth = 21;
enclosure_thickness = 2;

difference() {
    enclosure();
    
    for (side = ["left", "right"])
    translate_side(side)
    cuboid([enclosure_thickness+e, xt60_w, xt60_h]);
    
    translate_side("lid")
    cuboid([display_w, display_h, enclosure_thickness+e]);
    
    fwd(enclosure_thickness/2+e)
    translate_side("front")
    xrot(90)
    text3d("XT60 voltmeter", anchor=TOP, h=0.4, size=8, center=true);
}

module xt60_support() {
    difference() {
        cuboid([xt60_d, xt60_w+2, xt60_h+2]);
        cuboid([xt60_d+e, xt60_w, xt60_h]);
    }
}

translate_side("right")
left(xt60_d/2)
xt60_support();

translate_side("left")
right(xt60_d/2)
xt60_support();
