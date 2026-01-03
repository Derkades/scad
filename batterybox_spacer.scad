include <BOSL2/std.scad>;

h = 5;
l = 20 - 0.1;
w = 71 - 0.1;

difference() {
    cuboid([l, w, h], chamfer=2, edges="Z");

    // allow extracting using a hook
    cuboid([l/2, 10, h+0.01], chamfer=2, edges="Z");
    cuboid([l/2, 20, h/2+0.01], chamfer=2, edges="Z", anchor=TOP);
}
