include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fs = 0.5;
$fa = 0.5;

size = 0.8;

t = size * 9;
t_front = 0.4; // front is on the bottom
t_back = 1.4;

d_led = 4; // led diameter

difference() {
    down(t/2)
    linear_extrude(t)
    scale(size)
    import("ampelmann.svg", center=true);
    
    down(t/2-t_front)
    linear_extrude(t-t_front-t_back)
    scale(size)
    import("ampelmann_inner.svg", center=true);
    
    up(t/2-t_back/2) {
        // bottom left
        translate([-14*size, -23*size, 0])
        cyl(d=d_led, h=t_back+0.01);
    
        // bottom right
        translate([24*size, -22*size, 0])
        cyl(d=d_led, h=t_back+0.01);
    
        // middle
        translate([1*size, 0*size, 0])
        cyl(d=d_led, h=t_back+0.01);
        
        // top
        translate([0*size, 21*size, 0])
        cyl(d=d_led, h=t_back+0.01);
    }
}