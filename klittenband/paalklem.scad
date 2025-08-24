include <../BOSL2/std.scad>

$fa = 0.2;
$fs = 0.2;

t = 3; // dikte
t2 = 10; // h balk achtige versteviging
t3 = 5; // opening
wx = 70;
wy = 70;
h = 20;
mirror_x = 1; // 0 = rechts, 1 = links

// verbinding
l = 35;
w = 20;

mirror([mirror_x, 0, 0]) {
    difference() {
        union() {
            cuboid([wx, wy, h], anchor=BOTTOM, rounding=2, edges="Z");
            
            // versteviging
            cuboid([wx+t2*2, wy+t2*2, t], anchor=BOTTOM, rounding=10, edges="Z");
        }
        
        cuboid([wx-2*t, wy-2*t, h], anchor=BOTTOM);
        cuboid([wx, wy-2*t-2*t3, h], anchor=BOTTOM+RIGHT);
    }

    left(wx/2 - 20/2)
    fwd(wy/2 + 35/2)
    rect_tube(h/2, [w+2*t, l+2*t], [w, l], rounding=2);
}
