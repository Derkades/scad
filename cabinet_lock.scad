use </home/robin/git/scad/lib.scad>

// Based on lock.stl created by doganemrehan on Thingiverse: https://www.thingiverse.com/thing:4278028

thickness = 2;

module lock(bump_r, length, width) {
    scale([(1/100) * length, (1/40) * width, (1/2.4) * thickness])
    import("lock_doganemrehan.stl");
    
    translate([bump_r, bump_r])
    bettercylinder(2, bump_r);
}

module stop(height) {
    hollowcylinder(thickness, 2.5, 7.5);
    hollowcylinder(thickness+height, 2.5, 5);
}

lock(2.9, 50, 20);

translate([7.5, -7.5])
stop(thickness + 0.2);

translate([-8, -7.5])
stop(14);

