include <BOSL2/std.scad>

$fa = 0.2;
$fs = 0.2;

t = 2.5; // dikte
t2 = 5; // h balk achtige versteviging
t3 = 10; // opening
wx = 54;
wy = 48.5;
h = 20;
mirror_x = 0; // 0 = rechts, 1 = links

// verbinding
l = 35;
w = 20;

mirror([mirror_x, 0, 0]) {
    difference() {
        cuboid([wx+2*t, wy+2*t, h], anchor=BOTTOM, rounding=2, edges="Z") {
            back(t)
            position(BOTTOM+FRONT+LEFT)
            difference() {
                cuboid([w+2*t, l+2*t, h/2], anchor=BOTTOM+BACK+LEFT, rounding=2, edges=[FRONT+LEFT, FRONT+RIGHT]);
                right(t) fwd(t)
                cuboid([w, l, h/2], anchor=BOTTOM+BACK+LEFT);
            }

            // versteviging
            position(BOTTOM)
            cuboid([wx+t*2+t2*2, wy+t*2+t2*2, t], anchor=BOTTOM, rounding=10, edges="Z");
        }

        // binnenkant
        cuboid([wx, wy, h], anchor=BOTTOM, chamfer=6, edges=[LEFT+FRONT,LEFT+BACK]);
        // opening
        cuboid([wx, wy-2*t-2*t3, h], anchor=BOTTOM+RIGHT);
    }
}
