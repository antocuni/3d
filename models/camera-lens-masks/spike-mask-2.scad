use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

D = 62 + 4.30 + 2;
R = D/2;
H = 2;

difference() {
    union() {
        linear_extrude(H) donutSlice(R-1, R, 0, 360);
        linear_extrude(H+5) donutSlice(R-1, R, -5, 5);
        linear_extrude(H+5) donutSlice(R-1, R, 175, 185);

        linear_extrude(H+5) donutSlice(R-1, R, 85, 95);
        linear_extrude(H+5) donutSlice(R-1, R, 265, 275);
        
    }

    translate([0, 0, H+2.5]) rotate([0, 90, 0]) cylinder(d=W, h=D+10, center=true);
    translate([0, 0, H+2.5]) rotate([90, 0, 0]) cylinder(d=W, h=D+10, center=true);
}


W=1.5;
translate([0, 0, W/2]) {
    //cube([D, W, W], center=true);
    //cube([W, D, W], center=true);
}


translate([0, 0, W/2]) rotate([0, 90, 0]) cylinder(d=W, h=D, center=true);
translate([0, 0, W/2]) rotate([90, 0, 0]) cylinder(d=W, h=D, center=true);


