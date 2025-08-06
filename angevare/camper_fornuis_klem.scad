include <../BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

// elk klemmetje is net weer even anders, pas de code aan

up(5)
cuboid([20, 10, 10], anchor=BOTTOM+LEFT);

left(10)
cuboid([15, 10, 10], anchor=BOTTOM+RIGHT);

difference() {
    cuboid([10, 10, 35], anchor=BOTTOM+RIGHT);
    
    up(20)
    left(5)
    cyl(r=2.5/2, h=15, anchor=BOTTOM);
}