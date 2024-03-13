use <lib.scad>

cards_width = 40;
cards_length = 70;
cards = 6;
card_height = 1;
cards_height = cards * card_height;
wall = 1;
wall2 = 4;
rounding = 3;
bump = 1;
bump_offset = 0.75;

difference() {
    roundedcube([cards_width+wall*2, cards_length+wall*2, cards_height], rounding, only_sides=true);

    translate([wall, wall, wall])
    roundedcube([cards_width, cards_length, cards_height-wall*2], rounding, only_sides=true);

    translate([wall+wall2, wall+wall2, -1])
    roundedcube([cards_width-wall2*2, cards_length-wall2*2, cards_height+2], rounding, only_sides=true);

    // opening on one side
    translate([wall, -1, wall])
    cube([cards_width, wall2+2, cards_height - wall*2]);
}

// bumps
for (x = [wall, wall+cards_width]) {
    translate([x, cards_length * bump_offset, 0])
    bettercylinder(cards_height, bump);
}
