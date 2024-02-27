module heart(h, s) {
    cube([s, s, h]);
    translate([s/2, s, 0]) cylinder(r=s/2, h=h);
    translate([s, s/2, 0]) cylinder(r=s/2, h=h);
}

heart(2, 10);
