module bettersphere(r) {
   sphere(r, $fs=0.25);
}

module bettercylinder(h, r) {
   cylinder(h=h, r=r, $fs=0.25);
}

module roundedcube(dims, rounding, only_sides=false) {
    if (only_sides) {
        translate([rounding, rounding, 0]) {
            minkowski() {
                bettercylinder(1, rounding);
                cube(dims - [2*rounding, 2*rounding, 1]);
            }
        }
    } else {
        translate([rounding, rounding, rounding]) {
            minkowski() {
                cube(dims - [2*rounding, 2*rounding, 2*rounding]);
                bettersphere(rounding);
            }
        }
    }
}

//roundedcube([20, 50, 30], 3, only_sides=false);

module roundedcylinder(h, r, rounding) {
    translate([0, 0, rounding]) {
        minkowski()  {
            cylinder(h = h - 2*rounding, r = r - rounding);
            bettersphere(rounding);
        }
    }
}

//roundedcylinder(50, 20, 5);
