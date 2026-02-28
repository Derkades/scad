include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

module din_clamp(height, width, thickness=3) {
    din_height = 35; // Slop provided by spring
    din_thickness = 1.2;
    flex_thickness = 1.5;
    
    cuboid([height, thickness, width], anchor=FRONT);
    
    // top din rail clamp
    right(height/2 + flex_thickness*2.5 - din_height)
    back(thickness)
    cuboid([flex_thickness, din_thickness + flex_thickness, width], anchor=FRONT) {
        position(RIGHT+BACK)
        cuboid([flex_thickness, flex_thickness, width], anchor=BACK+LEFT); 
    }

    // bottom din rail clamp (flexible)
    clamp_length = thickness * 4;
    right(height/2 + flex_thickness/2)
    fwd(clamp_length - thickness) {
        cuboid([flex_thickness, thickness*4, width], anchor=FRONT);
        
        right(flex_thickness*1.5)
        front_half()
        tube(h=width, ir=flex_thickness, or=flex_thickness*2);
        
        right(flex_thickness*3)
        cuboid([flex_thickness, thickness*4+din_thickness, width], anchor=FRONT);
        
        back(clamp_length + din_thickness)
        right(flex_thickness * 4)
        cuboid([flex_thickness*3, flex_thickness, width], anchor=FRONT) {
            position(LEFT)
            xrot(90)
            yrot(-90)
            prismoid([flex_thickness, width], [0, width], height=flex_thickness, shift=[flex_thickness/2, 0]);
            
            position(RIGHT+FRONT)
            cuboid([flex_thickness, flex_thickness, width], anchor=BACK+RIGHT);
        }
    }
}

din_clamp(40, 30);
    