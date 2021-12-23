use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

OD = 87 + 0.3;  // outer diameter of the lens hood
ID = 84;        // inner diameter of the lens hood
EXTRA_BORDER = 1.5;
H = 2;

W=1;

//color("grey") translate([0, 0, 3]) linear_extrude(10) donutSlice(84/2, 87/2, 0, 360);
// base
linear_extrude(H) donutSlice(ID/2, OD/2, 0, 360);
translate([0, 0, H/2]) rotate([0, 90, 0]) cylinder(d=W, h=OD, center=true);
translate([0, 0, H/2]) rotate([90, 0, 0]) cylinder(d=W, h=OD, center=true);

/* // raised ring */
linear_extrude(10) donutSlice(OD/2, OD/2 + EXTRA_BORDER, 0, 360);

