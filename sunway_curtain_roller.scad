include <BOSL2/std.scad>
include <BOSL2/gears.scad>

// Ball part
c1_h = 6;
c1_r = 16.5/2;
ball_n = 10;
ball_r = 4.5/2;
ball_center_offset = 8.5;
 
difference() {
    cylinder(r=c1_r, h=c1_h, $fn=50);
     
    for (ball_deg = [1:360/ball_n:360]) {
        x = cos(ball_deg) * ball_center_offset;
        y = sin(ball_deg) * ball_center_offset;
        translate([x, y, 0])
        #cylinder(r=ball_r, h=c1_h, $fn=20);
    }
}

// Smooth part
c2_r = 5;
c2_h = 7.8;

up(c1_h)
cylinder(r=c2_r, h=c2_h, $fn=50);

// Gear part
// https://www.engineersedge.com/gear_formula.htm
gear_h = 8;
gear_teeth = 12;
gear_circ_pitch = (c2_r*2*PI - 5.6) / gear_teeth; // ?

up(c1_h + c2_h)
spur_gear(gear_circ_pitch, gear_teeth, thickness=gear_h, anchor=BOTTOM);

// Pin part
c3_r = 4.6/2;
c3_h = 3.75;
up(c1_h + c2_h + gear_h)
cylinder(r=c3_r, h=c3_h, $fn=50);