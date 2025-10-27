include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;
bold = 0.2;

cuboid([85.5, 53.9, 0.8], rounding=2.5, edges=[FRONT+LEFT, LEFT+BACK, BACK+RIGHT, FRONT+RIGHT], anchor=TOP);

linear_extrude(0.4) {
    back(10)
    offset(delta=bold)
    text("De Klusjesman", anchor=CENTER+BOTTOM, size=8);

    fwd(5)
    offset(delta=bold)
    text("tegoedbon", anchor=CENTER+BOTTOM, size=6, font=":style=Bold");

    fwd(15)
    offset(delta=bold)
    text("20 uur", anchor=CENTER+BOTTOM, size=6, font=":style=Bold");
}