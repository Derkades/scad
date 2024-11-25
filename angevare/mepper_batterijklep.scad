include <BOSL2/std.scad>

// klopt niet helemaal, en aangepast sinds vorige print

cuboid([27.8, 54, 1.2], anchor=BOTTOM);
cuboid([25.9, 54, 0.8], anchor=TOP);

back(54/2) down(0.8)
cuboid([29, 5, 0.8], anchor=BOTTOM+BACK);

fwd(54/2)
cuboid([7.5, 5, 1.2], anchor=TOP+BACK);