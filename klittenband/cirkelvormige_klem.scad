include <../BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

ir = 50;
t1 = 2;
t2 = 5;
h = 15;
r_pin = 5;
r_rope = 2;
chamfer = 1.5;

top = false;
pin = false;

// pin
if (pin) {
    cyl(r=r_pin, h=h, anchor=BOTTOM);
    cuboid([r_pin*3, r_pin*3, t1], anchor=TOP, chamfer=chamfer, edges="Z");
} else {
    // circle
    difference() {
        tube(ir=ir, or=ir+t2, h=h, chamfer=chamfer);
        cuboid([2*(ir+t2), ir+t2, h+t2], anchor=top ? BACK : FRONT);
       
        cuboid([(ir+t2)*2, r_pin*4, h/2], chamfer=-chamfer, anchor=top ? TOP : BOTTOM, edges=top ? BOTTOM+FRONT : TOP+FRONT);
    }

    // clamp
//    w = 20;
//    if (top) {
//        left(ir)
//        cuboid([w-t, t - 0.1, h], anchor=RIGHT+FRONT, chamfer=1, edges="Z");
//    } else {
//        left(ir+w) {
//            cuboid([w, t, h], anchor=LEFT+BACK, chamfer=1, edges=FRONT+LEFT);
//            
//            cuboid([t, t, h], anchor=LEFT+FRONT);
//            
//            back(2*t)
//            cuboid([w/2, t, h], anchor=LEFT+BACK, chamfer=1, edges=[BACK+LEFT, BACK+RIGHT, FRONT+RIGHT]);
//        }    
//    }

    // pin holes
    for (x = [ir, -ir-r_pin*2-t1*2]) {
        right(x)
        difference() {
            cuboid([r_pin*2+t1*2, r_pin*2+t1*2, h/2], anchor=(top ? BOTTOM : TOP)+LEFT, chamfer=chamfer, edges="Z", except=x > 0 ? FRONT+LEFT : FRONT+RIGHT);

            right((r_pin*2+t1*2)/2)
            cyl(r=r_pin, h=h);
        }
    }
    
    // hook hole
    if (!top) {
        fwd(ir+t2/2)
        difference() { 
            cuboid([r_rope*2+t1*2, r_rope*2+t1*2, h/2], chamfer=chamfer, except=BACK, anchor=BACK+TOP);

            fwd(t2/2+t1)
            cyl(r=r_rope, h=h/2, anchor=TOP);
        }
        
    }
}

