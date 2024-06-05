use <din_clamp.scad>

module din_clamp_pcb(pcb_height, pcb_width, top_stop=true, bottom_stop=true) {
    stop_width = 2;
    pcb_thickness_max = 1.65; // positive slop
    pcb_thickness_min = 1.55; // negative slop
    
    din_clamp(pcb_height+stop_width, pcb_width);
    
    if (top_stop)
    translate([pcb_height, -pcb_thickness_max-stop_width, 0])
    cube([stop_width, stop_width, pcb_width]);
       
    if (bottom_stop)
    translate([0, -pcb_thickness_min, 0])
    cube([stop_width, pcb_thickness_min, pcb_width]);
}

// STM32F401 development board. USB-C port at the bottom.
// din_clamp_pcb(53.5, 21.5);

// LM2596S module
din_clamp_pcb(44, 21.5, top_stop=false);