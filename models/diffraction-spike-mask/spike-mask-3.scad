use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

OD = 87 + 0.8;  // outer diameter of the lens hood
ID = 84 + 0.3;        // inner diameter of the lens hood
EXTRA_BORDER = 1.5;
H = 2;

W=1;

//color("grey") translate([0, 0, 3]) linear_extrude(10) donutSlice(84/2, 87/2, 0, 360);
// base
linear_extrude(H) donutSlice(ID/2, OD/2, 0, 360);

// cross using cylinder
//translate([0, 0, H/2]) rotate([0, 90, 0]) cylinder(d=W, h=OD, center=true);
//translate([0, 0, H/2]) rotate([90, 0, 0]) cylinder(d=W, h=OD, center=true);

// cross using cubes
translate([0, 0, W/2]) {
    cube([OD, W, W], center=true);
    cube([W, OD, W], center=true);
}

/* // raised ring */
linear_extrude(10) donutSlice(OD/2, OD/2 + EXTRA_BORDER, 0, 360);

