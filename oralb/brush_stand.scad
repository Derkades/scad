include <../BOSL2/std.scad>

/* [Module counts] */
// Number of toothbrush attachments
attachments = 6;
// Number of toothbrushes
brushes = 1;
// Number of chargers
chargers = 1;

/* [Base parameters] */
// Thickness, except for charger which must always be 4
base_t = 2;
// Width (Y) of base
base_w = 40;

/* [Brush stand parameters] */
// Width (X) of brush
brush_w = 30;
// Whether to add a raised section for the brush to stand on
brush_raised = true;

module attachment_stand_part(height, cyl_r, top=false) {
    t = 2;
    cyl_h = 9;
    pillar_r = 3.5;
    cyl_y = -4.2;
    cyl_z = height + 8;
    cyl_xrot = 90+45;
    
    difference() {
        union() {
            // Pillar
            cylinder(r=pillar_r, h=height+10, $fn=50);
            
            // Holder outer cylinder
            translate([0, cyl_y, cyl_z]) xrot(cyl_xrot)
            cylinder(r=cyl_r+t, h=cyl_h, $fn=50, anchor=CENTER);
        }
        
        translate([0, cyl_y, cyl_z]) xrot(cyl_xrot) {
            // Holder inner cylinder
            cylinder(r=cyl_r, h=cyl_h+0.001, $fn=50, anchor=CENTER);
            
            // Remove top part
            translate([0, (cyl_r+t)/2, 0])
            cuboid([(cyl_r+t)*2, cyl_r+t, cyl_h+0.001]);

            if (top) {
                // Round cutout at top of holder for brush
                down(cyl_h)
                xrot(90)
                cylinder(r=14/2, h=10, $fn=50);
            } else {
                // Cut of rest of pillar
                translate([0, 0, -cyl_h])
                cuboid([(cyl_r+t)*2, (cyl_r+t)*2, cyl_h]);
            }
        }
    }
}

module attachment_stand(wx, wy, t) {    
    cuboid([wx, wy, t], anchor=BOTTOM);
    
    translate([0, -13, 0])
    attachment_stand_part(10, 10.5/2);
    
    translate([0, 14, 0])
    attachment_stand_part(34, 9/2, top=true);
}

module brush_stand() {
    h = 11;
    width_y = 9;

    hull() {
        // Back (wide side)
        back(width_y/2)
        intersection() {
            fwd(7.5)
            cylinder(r=7.5, h=h, $fn=50);
            
            fwd(1.2)
            cuboid([7.5, 2, h], anchor=BOTTOM+FRONT);
        }
        
        // Front (narrow side)
        fwd(width_y/2)
        intersection() {
            back(7)
            cylinder(r=7, h=h, $fn=50);
            
            cuboid([5.5, 1, h], anchor=BOTTOM+FRONT);
        }
    }
    
    if (brush_raised)
    cylinder(r=15, h=base_t*2, $fn=100);
    
    // Base
    cuboid([brush_w, base_w, base_t], anchor=BOTTOM);
}

module charger_stand() {
    t = 4;
    back = 33.5;
    back_width = 30.5;
    cyl_r = 23.4;
    cyl_yscale = 1.30;
    offset_front = 8;
    
    back(-offset_front)
    difference() {
        union() {
            // Outer cylinder
            yscale(cyl_yscale)
            cylinder(h=t, r=cyl_r+t, $fn=200);
            
            cuboid([back_width + 2*t, back+t, t], anchor=BOTTOM+FRONT);
            
            // Cable bridge
            up(4)
            back(back)
            cuboid([15, t, t], anchor=BOTTOM+FRONT);
             
            // Connection to left part
            back(offset_front)
            left(cyl_r + t)
            cuboid([20, base_w, base_t], anchor=BOTTOM);
        }
        
        // Inner cylinder
        yscale(cyl_yscale)
        cylinder(h=t+0.01, r=cyl_r, $fn=200);
        
        // Back cutout
        cuboid([back_width, back, t+0.01], anchor=BOTTOM+FRONT);
           
        // Cable cutout
        back(back)
        cuboid([6, 6, 6], anchor=BOTTOM+FRONT);
    }
}

module base() {
    // Attachments
    attachment_width = 18;
    
    if (attachments > 0)
    for (i = [1:attachments]) {
        x = i * attachment_width - attachment_width/2;
        right(x)
        attachment_stand(wx=attachment_width, wy=base_w, t=base_t);
    }
    
    // Brushes    
    brush_offset = attachments * attachment_width;
    if (brushes > 0)
    for (i = [1:brushes]) {
        x = brush_offset + i * brush_w - brush_w/2;
        right(x)
        brush_stand();
    }
    
    // Chargers
    charger_l = 23.4*2 + 4*2;
    charger_offset = brush_offset + brushes * brush_w;
    
    if (chargers > 0)
    for (i = [1:chargers]) {
        x = charger_offset + i * charger_l - charger_l/2;
        right(x)
        charger_stand();
    }
}

base();
