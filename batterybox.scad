include <libenclosure.scad>

cell = 20.25;
cells_series = 10;
cells_parallel = 4;

handle_length = 100;
handle_screw = "M3";

module xt60(anchor = CENTER) {
    xt60_w = 15.6;
    xt60_h = 8.3;
    xt60_d = 6.5;

    hull() {
        left(xt60_w/4)
        cuboid([xt60_w/2, xt60_h, xt60_d], anchor=anchor);

        right(xt60_w/2 - xt60_h/2)
        cyl(d=xt60_h, h=xt60_d, anchor=anchor);
    }
}

enclosure_part = "box"; // box, lid, both
enclosure_length = cells_series * cell + 20; // clear screw corners
enclosure_width = 71;
enclosure_depth = cells_parallel * cell + 12; // room for BMS
enclosure_thickness = 3;

difference() {
    enclosure();

    // xt60 connector
    left(enclosure_length/2 - 10)
    up(enclosure_thickness/2+0.01)
    translate_side("lid")
    zrot(90)
    xt60(anchor=TOP);

    // handle screw holes
    for (x = [-handle_length/2, handle_length/2])
    right(x)
    translate_side("lid")
    screw_hole(handle_screw, length=enclosure_thickness+0.01);
}

// extra strength
if (enclosure_part == "lid" || enclosure_part == "both")
for (y = [-enclosure_width/2+10, enclosure_width/2-10])
back(y)
down(enclosure_thickness)
translate_side("lid")
cuboid([enclosure_length-20, enclosure_thickness, enclosure_thickness]);
