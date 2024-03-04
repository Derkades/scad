use <lib.scad>

module die(size, insetMargin, insetDepth) {
    difference() {
        intersection() {
            centercube(size);
            bettersphere(size*0.7);
        }
        if (insetDepth > 0) {
            cylR = size/2-insetMargin;
            translate([0, 0, size/2-insetDepth])
            bettercylinder(insetDepth+insetDepth, cylR);

            translate([0, 0, -size/2-insetDepth])
            bettercylinder(insetDepth+insetDepth, cylR);

            translate([0, size/2+insetDepth, 0])
            rotate([90, 0, 0])
            bettercylinder(insetDepth+insetDepth, cylR);

            translate([0, -size/2+insetDepth, 0])
            rotate([90, 0, 0])
            bettercylinder(insetDepth+insetDepth, cylR);

            translate([size/2-insetDepth, 0, 0])
            rotate([0, 90, 0])
            bettercylinder(insetDepth+insetDepth, cylR);

            translate([-size/2-insetDepth, 0, 0])
            rotate([0, 90, 0]) bettercylinder(insetDepth+insetDepth, cylR);
        }
    }
    dotSize = 2;
    offsetEdge = size / 2 - 1;
    offset1 = size / 6;
    offset2 = size / 5;
    offset3 = size / 4;
    intersection() {
        union() {

            translate([0, offsetEdge, 0]) bettersphere(dotSize);

            translate([-offset1, offset1, -offsetEdge]) bettersphere(dotSize);
            translate([offset1, -offset1, -offsetEdge]) bettersphere(dotSize);

            translate([offsetEdge, -offset2, offset2]) bettersphere(dotSize);
            translate([offsetEdge, 0, 0])  bettersphere(dotSize);
            translate([offsetEdge, offset2, -offset2]) bettersphere(dotSize);

            translate([-offsetEdge, -offset2, -offset2])  bettersphere(dotSize);
            translate([-offsetEdge, offset2, offset2])  bettersphere(dotSize);
            translate([-offsetEdge, -offset2, offset2]) bettersphere(dotSize);
            translate([-offsetEdge, offset2, -offset2])  bettersphere(dotSize);

            translate([0, 0, offsetEdge])  bettersphere(dotSize);
            translate([-offset2, offset2, offsetEdge])  bettersphere(dotSize);
            translate([offset2, -offset2, offsetEdge])  bettersphere(dotSize);
            translate([-offset2, -offset2, offsetEdge]) bettersphere(dotSize);
            translate([offset2, offset2, offsetEdge]) bettersphere(dotSize);

            translate([offset1, -offsetEdge, -offset3])  bettersphere(dotSize);
            translate([offset1, -offsetEdge, 0])  bettersphere(dotSize);
            translate([offset1, -offsetEdge, offset3])  bettersphere(dotSize);
            translate([-offset1, -offsetEdge, -offset3])  bettersphere(dotSize);
            translate([-offset1, -offsetEdge, 0]) bettersphere(dotSize);
            translate([-offset1, -offsetEdge, offset3])  bettersphere(dotSize);
        }
        centercube(size);
    }
}

die(20, 1, 1);
