include <../libenclosure.scad>

enclosure_part = "lid"; // box, lid, both
enclosure_length = 143;
enclosure_width = 37;
enclosure_depth = 24; 
enclosure_thickness = 1.6;

difference() {
    enclosure();
    
    up(12)
    translate_side("left")
    cuboid([enclosure_thickness, 6.5, 6], rounding=1, edges="X");
}
