module NiceSphere(r) {
   sphere(r, $fa=5, $fs=0.5);
}

module CenterCube(size) {
    translate([-size/2, -size/2, -size/2]) cube(size);
}

module Die(size, insetMargin, insetDepth) {
    difference() {
        intersection() {
            CenterCube(size);
            NiceSphere(size*0.7);
        }
        if (insetDepth > 0) {
            cylR = size/2-insetMargin;
            translate([0, 0, size/2-insetDepth]){
                cylinder(h=insetDepth+insetDepth, r=cylR);
            }
            translate([0, 0, -size/2-insetDepth]){
                cylinder(h=insetDepth+insetDepth, r=cylR);
            }
            translate([0, size/2+insetDepth, 0]){
                rotate([90, 0, 0]) cylinder(h=insetDepth+insetDepth, r=cylR);
            }
            translate([0, -size/2+insetDepth, 0]){
                rotate([90, 0, 0]) cylinder(h=insetDepth+insetDepth, r=cylR);
            }
            translate([size/2-insetDepth, 0, 0]){
                rotate([0, 90, 0]) cylinder(h=insetDepth+insetDepth, r=cylR);
            }
            translate([-size/2-insetDepth, 0, 0]){
                rotate([0, 90, 0]) cylinder(h=insetDepth+insetDepth, r=cylR);
            }
        }
    }
    dotSize = 2;
    intersection() {
        union() {
            translate([0,9,0]) NiceSphere(dotSize);

            translate([-3.3, 3.3,-9]) NiceSphere(dotSize);
            translate([ 3.3,-3.3,-9]) NiceSphere(dotSize);

            translate([9,-4,4]) NiceSphere(dotSize);
            translate([9,0,0])  NiceSphere(dotSize);
            translate([9,4,-4]) NiceSphere(dotSize);

            translate([-9,-4,-4])  NiceSphere(dotSize);
            translate([-9,4,4])  NiceSphere(dotSize);
            translate([-9,-4,4]) NiceSphere(dotSize);
            translate([-9,4,-4])  NiceSphere(dotSize);

            translate([0,0,9])  NiceSphere(dotSize);
            translate([-4,4,9])  NiceSphere(dotSize);
            translate([4,-4,9])  NiceSphere(dotSize);
            translate([-4,-4,9]) NiceSphere(dotSize);
            translate([4,4,9]) NiceSphere(dotSize);

            translate([3.3,-9,-5])  NiceSphere(dotSize);
            translate([3.3,-9,0])  NiceSphere(dotSize);
            translate([3.3,-9,5])  NiceSphere(dotSize);
            translate([-3.3,-9,-5])  NiceSphere(dotSize);
            translate([-3.3,-9,0]) NiceSphere(dotSize);
            translate([-3.3,-9,5])  NiceSphere(dotSize);
        }
        CenterCube(size);
    }
}

Die(20, 1, 1);
