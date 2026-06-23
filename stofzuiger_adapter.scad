include <BOSL2/std.scad>

$fa = 0.5;
$fs = 0.5;

id = 33.5;
od = 35.9;

tube(id=id, od=od, h=20, anchor=BOTTOM, ochamfer2=(od-id)/3);
tube(id=id, od=od+4, h=2, anchor=TOP);