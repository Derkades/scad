include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

d = 10;

difference() {
    down(d/2)
    linear_extrude(d)
    import("ampelmann.svg", center=true);
    
    down(d/2-0.5)
    linear_extrude(d+1)
    import("ampelmann_inner.svg", center=true);
}