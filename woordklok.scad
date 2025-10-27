include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

height = 20;
t = 2;
slots = 2;
type = "horizontal"; // horizontal / vertical / both

e = 0.001;
m = 0.05;

// dist = horizontal center-to-center distance between letters
module strip(dist, slot_depth, led_strip_slots) {
    total_width = slots * dist;
    difference() {
        cuboid([total_width, height, t], anchor=LEFT);
        
        for (slot_num = [1:slots]) {
            right(slot_num * dist - dist/2) {
                back(height/2+e)
                cuboid([t+m, slot_depth+m, t+e], anchor=BACK);
                
                if (led_strip_slots) {
                    right(t)
                    cuboid([t+m, 10, t+e], anchor=BACK);
                }
            }
        }
    }
}

if (type == "horizontal" || type == "both") {
    back(height + 1)
    strip(36.3, height * 0.75, false); // horizontal
}

if (type == "vertical" || type == "both") {
    strip(39.4, height * 0.25, true); // vertical
}
