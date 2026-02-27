include <BOSL2/std.scad>
use <din_clamp.scad>

module din_clamp_pcb(pcb_height, pcb_width, top_stop=true, bottom_stop=true) {
    stop_width = 2;
    pcb_thickness = 1.6;
    
    din_clamp(pcb_height+stop_width, pcb_width);
    
    if (bottom_stop)
    right(pcb_height/2)
    fwd(pcb_thickness + 0.5)
    cuboid([stop_width, stop_width, pcb_width], anchor=BACK);
       
    if (top_stop)
    left(pcb_height / 2)
    cuboid([stop_width, pcb_thickness - 0.5, pcb_width], anchor=BACK);
}

// STM32F401 development board. USB-C port at the bottom.
din_clamp_pcb(53.5, 21.5);

// LM2596S module
// din_clamp_pcb(44, 21.5, top_stop=false);