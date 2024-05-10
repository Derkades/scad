use <lib.scad>

/*
For best results while still being easy to remove, print with the following support settings in PrusaSlicer:
Supports: enabled
Style: Snug
Pattern: Honeycomb
Top interface layers: 0
*/

cards = 5; // <- adjust this
cash_holder = true;
cards_width = 53.98 + 0.2;
cards_length = 85.6 + 0.5;
card_height = 0.76 + 0.25;
cards_height = cards * card_height;
wall = 1.5;
edge = 4;
rounding = 3;
bump = 0.75;
bump_offset = 0.6;

difference() {
    roundedcube([cards_width+wall*2, cards_length+wall, cards_height+wall*2], rounding, only_sides=true);

    // slot for cards
    translate([wall, wall, wall])
    roundedcube([cards_width, cards_length-wall, cards_height], rounding, only_sides=true);

    // window
    translate([wall+edge, wall+edge, -1])
    roundedcube([cards_width-edge*2, cards_length-edge*2-wall, cards_height+wall*2+2], rounding, only_sides=true);

    // opening for cards to slide out
    translate([wall, -1, wall])
    cube([cards_width, edge+2, cards_height]);
}

if (cash_holder) {
    translate([rounding, cards_length/2+rounding/2, 0])
    roundedcube([cards_width/2-rounding, cards_length/2-rounding, wall], rounding, only_sides=true);
}

// bumps
for (x = [wall, wall+cards_width]) {
    translate([x, cards_length * bump_offset, wall])
    bettercylinder(cards_height, bump);
}
