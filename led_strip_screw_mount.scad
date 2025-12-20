include <BOSL2/std.scad>
include <BOSL2/screws.scad>

$fa = 0.5;
$fs = 0.5;

led_w = 12;
led_t = 3;
w = 8;
t = 1.5;

down(led_t/2)
back(led_w/2)
cuboid([w, led_w*0.8, t], anchor=TOP+BACK);

up(led_t/2)
cuboid([w, led_w, t], anchor=BOTTOM);

back(led_w/2)
cuboid([w, t, t*2+led_t], anchor=FRONT, chamfer=1, edges=[BACK+TOP,BACK+BOTTOM]);

fwd(led_w/2+w/2)
up(led_t/2+t)
difference() {
    block_t = t*2+led_t;
    cuboid([w, w, block_t], chamfer=2, edges=BACK+BOTTOM, anchor=TOP);
    screw_hole("M3", length=block_t+0.01, head="flat", anchor=TOP);
}