include <BOSL2/std.scad>

/*
For best results while still being easy to remove, print with the following support settings in PrusaSlicer:
Supports: Supports enforcers only
Style: Organic
Top interface layers: 0
Paint-on supports:
  Tool type: smart fill
  Left click on bottom side of overhanging section
*/

$fa = 0.5;
$fs = 0.5;

cards = 4; // <- adjust this
cash_holder_v1 = false;
cash_holder_v2 = true;
recess = false;
recess_offset = 10;
recess_diameter = 20;
cards_width = 53.98 + 0.5;
cards_length = 85.6 + 0.5;
card_height = 0.76 + 0.25;
cards_height = cards * card_height;
wall = 1.6;
edge = 6;
rounding = 3;
bump_r = 0.4;
bump_offset = 10;

holder_width = cards_width + wall*2;
holder_length = cards_length + wall*2;
holder_height = cards_height + wall*2;

SIDES = [LEFT+FRONT, RIGHT+FRONT, LEFT+BACK, RIGHT+BACK];

difference() {
    // outer shell
    cuboid([holder_width, cards_length+wall, holder_height], rounding=rounding, edges=[LEFT, RIGHT, BACK]);

    // slot for cards
    fwd(wall)
    cuboid([cards_width, cards_length+wall, cards_height], rounding=rounding, edges=[BACK+LEFT, BACK+RIGHT]);

    // window
    cuboid([cards_width-edge*2, cards_length-edge*2, cards_height+wall*2+0.1], rounding=rounding, edges=SIDES);

    if (recess) {
        left(recess_offset)
        fwd(holder_length/2 + 7)
        cyl(d=recess_diameter, h=holder_height, anchor=BOTTOM);
    }
}

if (cash_holder_v1)
down(holder_height/2)
cuboid([cards_width/2-rounding, cards_length/2-rounding, wall], rounding=rounding, edges=[FRONT+LEFT], anchor=LEFT+FRONT+BOTTOM);

if (cash_holder_v2)
down(holder_height/2-wall/2)
cuboid([cards_width-rounding, cards_length/2-rounding, wall/2], anchor=FRONT+TOP, chamfer=wall/2, edges=TOP+FRONT);

// bumps
for (x = [-cards_width/2, +cards_width/2]) {
    right(x)
    back(bump_offset)
    cyl(h=cards_height, r=bump_r);
}
