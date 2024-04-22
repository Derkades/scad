use <din_clamp.scad>

module din_clamp_pcb(pcb_height, pcb_width) {
    stop_width = 2;
    pcb_thickness_max = 1.65; // positive slop
    pcb_thickness_min = 1.5; // negative slop
    
    din_clamp(pcb_height+stop_width, pcb_width);
    
    translate([pcb_height, -pcb_thickness_max-stop_width, 0])
    cube([stop_width, stop_width, pcb_width]);
    
    translate([0, -pcb_thickness_min, 0])
    cube([stop_width, pcb_thickness_min, pcb_width]);
}

// STM32F401 development board. USB-C port at the bottom.
// TODO dimensions
din_clamp_pcb(40, 15);
