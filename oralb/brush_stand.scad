include <BOSL2/std.scad>

// a = attachment
// b = brush
// c = charger
configuration = "caaaac";

/* [Base parameters] */
// Thickness, except for charger which must always be 4
base_t = 2;
// Width (Y) of base
base_w = 40;

/* [Attachment stand parameters] */
attachment_w = 35;

/* [Brush stand parameters] */
// Width (X) of brush
brush_w = 40;
// Whether to add a raised section for the brush to stand on
brush_raised = true;

$fa = 0.5;
$fs = 0.5;

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
            cylinder(r=pillar_r, h=height+10);

            // Holder outer cylinder
            translate([0, cyl_y, cyl_z]) xrot(cyl_xrot)
            cylinder(r=cyl_r+t, h=cyl_h, anchor=CENTER);
        }

        translate([0, cyl_y, cyl_z]) xrot(cyl_xrot) {
            // Holder inner cylinder
            cylinder(r=cyl_r, h=cyl_h+0.001, anchor=CENTER);

            // Remove top part
            translate([0, (cyl_r+t)/2, 0])
            cuboid([(cyl_r+t)*2, cyl_r+t, cyl_h+0.001]);

            if (top) {
                // Round cutout at top of holder for brush
                down(cyl_h)
                xrot(90)
                cylinder(r=14/2, h=10);
            } else {
                // Cut off rest of pillar
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
    h = 10;
    width_y = 8.5;

    translate([0, 0, brush_raised ? base_t*2 : base_t])
    hull() {
        // Back (wide side)
        back(width_y/2)
        intersection() {
            fwd(7.5)
            cylinder(r=7.5, h=h);

            fwd(1.2)
            cuboid([7.5, 2, h], anchor=BOTTOM+FRONT);
        }

        // Front (narrow side)
        fwd(width_y/2)
        intersection() {
            back(7)
            cylinder(r=7, h=h);

            cuboid([5.5, 1, h], anchor=BOTTOM+FRONT);
        }
    }

    if (brush_raised)
    cylinder(r=35/2, h=base_t*2);

    // Base
    cuboid([brush_w, base_w, base_t], anchor=BOTTOM);
}

module charger_stand(left_connection, right_connection) {
    t = 4;
    back = 33.5;
    back_width = 30.5;
    cyl_r = 23.4;
    cyl_yscale = 1.30;
    offset_front = 15;

    right(2)
    back(-offset_front)
    difference() {
        union() {
            // Outer cylinder
            yscale(cyl_yscale)
            cylinder(h=t, r=cyl_r+t);

            cuboid([back_width + 2*t, back+t, t], anchor=BOTTOM+FRONT);

            // Cable bridge
            up(4)
            back(back)
            cuboid([15, t, t], anchor=BOTTOM+FRONT);

            // Connection to left and right part
            back(offset_front) {
                if (left_connection) {
                    left(cyl_r + t + 3)
                    cuboid([15, base_w, base_t], anchor=BOTTOM+LEFT);
                }
                if (right_connection) {
                    right(cyl_r + t + 3)
                    cuboid([15, base_w, base_t], anchor=BOTTOM+RIGHT);
                }
            }

        }

        // Inner cylinder
        yscale(cyl_yscale)
        cylinder(h=t+0.01, r=cyl_r);

        // Back cutout
        cuboid([back_width, back, t+0.01], anchor=BOTTOM+FRONT);

        // Cable cutout
        back(back)
        cuboid([6, 6, 6], anchor=BOTTOM+FRONT);
    }
}

module base(offset, index) {
    if (index < len(configuration)) {
        c = configuration[index];
        if (c == "a") {
            right(offset + attachment_w/2)
            attachment_stand(wx=attachment_w, wy=base_w, t=base_t);
            base(offset + attachment_w, index + 1);
        } else if (c == "b") {
            right(offset + brush_w/2)
            brush_stand();
            base(offset + brush_w, index + 1);
        } else if (c == "c") {
            charger_w = 23.4*2 + 4*2 + 2;
            right(offset + charger_w/2)
            charger_stand(index > 0, index < len(configuration) - 1);
            base(offset + charger_w, index + 1);
        }
    }
}

base(0, 0);
