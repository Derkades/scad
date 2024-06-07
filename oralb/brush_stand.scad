include <../BOSL2/std.scad>

brushes = 1;
attachments = 6;
chargers = 1;

module attachment_stand_part(height, cyl_r, top=false) {
    t = 2;
    cyl_h = 9;
    pillar_r = 3.5;
    cyl_y = -4.2;
    cyl_z = height + 8;
    cyl_xrot = 90+45;
    
    difference() {
        union() {
            cylinder(r=pillar_r, h=height+10, $fn=50);
            
            translate([0, cyl_y, cyl_z]) xrot(cyl_xrot)
            cylinder(r=cyl_r+t, h=cyl_h, $fn=50, anchor=CENTER);
        }
        
        translate([0, cyl_y, cyl_z]) xrot(cyl_xrot) {
            cylinder(r=cyl_r, h=cyl_h+0.001, $fn=50, anchor=CENTER);
            
            translate([0, (cyl_r+t)/2, 0])
            cuboid([(cyl_r+t)*2, cyl_r+t, cyl_h+0.001]);
            
            translate([0, 0, -cyl_h])
            cuboid([(cyl_r+t)*2, (cyl_r+t)*2, cyl_h]);
            
            if (top)
            down(cyl_h)
            xrot(90)
            cylinder(r=14/2, h=10, $fn=50);
        }
    }
}

module attachment_stand() {   
    translate([0, -13, 0])
    attachment_stand_part(10, 10.5/2);
    
    translate([0, 14, 0])
    attachment_stand_part(34, 9/2, top=true);
}

module base() {
    t = 2;
    attachment_l = 20;
    
    for (i = [1:attachments]) {
        x = i * attachment_l - attachment_l/2;
        translate([x, 0, t/2])
        attachment_stand();
    }
    
    base_w = 40;
    base_l = attachments * attachment_l;
    
    cuboid([base_l, base_w, t], anchor=LEFT);
}

//base();

difference() {
    cuboid([55, 75, 12], anchor=BOTTOM);
   
    yscale(1.25)
    cylinder(h=15, r=24, $fn=50);

    back(28)
    cuboid([31, 10, 10], anchor=BOTTOM);

    back(39)
    cuboid([6, 10, 7], anchor=BOTTOM);
}
