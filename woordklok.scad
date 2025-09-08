include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

height = 20;
t = 2;

count = 5;

e = 0.001;
m = 0.05;

// dist = horizontal center-to-center distance between letters
module strip(dist, slot_depth, led_strip_slots) {
    total_width = count * dist;
    difference() {
        cuboid([total_width, height, t], anchor=LEFT);
        
        for (slot_num = [1:5]) {
            right(slot_num * dist - dist/2) {
                back(height/2+e)
                cuboid([t+m, slot_depth+m, t+e], anchor=BACK);
                
                if (led_strip_slots) {
                    right(t)
                    cuboid([t+m, 10, t+e], anchor=BACK);
                }
            }
        }
        
        //fwd(height/2)
        //right(clip_width/2)
        //cuboid([clip_width/2, t, t/2+e], anchor=BOTTOM+RIGHT+FRONT);
    }
}

back(height + 1)
strip(36.3, height * 0.75, false); // horizontal

strip(39.4, height * 0.25, true); // vertical

//module clip() {
//    clip_width = 15;
//    
//    left(t+m)
//    cuboid([t/2, height+t/2, clip_width], anchor=BACK+LEFT);
//    
//    right(t+m)
//    cuboid([t/2, height+t/2, clip_width], anchor=BACK+RIGHT);
//
//    cuboid([t+m*2, t/2, clip_width], anchor=BACK);
//}
//
//clip();