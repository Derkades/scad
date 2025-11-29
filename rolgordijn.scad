include <BOSL2/std.scad>;
include <BOSL2/screws.scad>;

$fa = 0.5;
$fs = 0.5;

wall = 2;
h = 30;

fixed_r = 20 / 2;

ball_r = 4.7/2;
ball_slop = 0.3;
balls_r_inner = 51/2;
balls_r_outer = balls_r_inner + ball_r + ball_slop;

module rotating() {
    balls_n = 28;

    spacer_h = 13;

    tube_r = 32/2;
    tube_ridge_r = 36.1/2;
    ridge_r = tube_ridge_r - tube_r;
    
    difference() {
        union() {
            up(ball_r + wall) {
                down(ball_r + ball_slop)
                cyl(r=balls_r_outer, h=wall-ball_slop, anchor=TOP);
                
                cyl(r=balls_r_inner, h=ball_r*2 + 2*ball_slop);
                
                up(ball_r + ball_slop)
                cyl(r=balls_r_outer, h=wall-ball_slop, anchor=BOTTOM);
            }
            
            cyl(r=tube_r+ridge_r*2, h=spacer_h, anchor=BOTTOM);

            cyl(r=tube_r, h=h, anchor=BOTTOM);
            
            for (ridge = [0:11]) {
                zrot(360/12 * ridge)
                right(tube_r)
                cyl(r=ridge_r, h=h, anchor=BOTTOM);
            } 
        }
        
    //    cyl(d1=21.5, d2=14.7, h=20.8, anchor=BOTTOM);
        
        cyl(r=fixed_r + 0.1, h=h+0.01, anchor=BOTTOM);
        
        up(ball_r + wall)
        for (ball = [0:balls_n-1]) {
            zrot(360/balls_n * ball)
            right(balls_r_inner)
            sphere(r=ball_r, anchor=CENTER);
        }
    }
}

module fixed() {
    ball_lock_h = 2*wall+2*ball_r+ball_slop*2;
    
    down(0.1)
    difference() {
        union() {
            cyl(r=fixed_r+wall, h=wall, anchor=TOP);
            
            cyl(r=fixed_r, h=h, anchor=BOTTOM);
            
            zrot(110)
            difference() {
                down(wall)
                pie_slice(r=balls_r_outer + 0.1 + wall, h=ball_lock_h, ang=170, anchor=BOTTOM);
                pie_slice(r=balls_r_outer + 0.1, h=ball_lock_h, ang=170, anchor=BOTTOM);
            }
        }
        
        down(wall) {
            cuboid([9.6+0.1, 2.95+0.1, h+wall+0.01], anchor=BOTTOM);
            cuboid([fixed_r*2+0.01, 3.2, 4], anchor=BOTTOM);
        }        
    }
}

fixed();
//rotating();