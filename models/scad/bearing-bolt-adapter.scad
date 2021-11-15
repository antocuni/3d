use <MCAD/2Dshapes.scad>
include <misc_libs/screw_holes.scad>

$fa = 1;
$fs = 0.4;

function in2mm(inches) = inches * 25.4;

BEARING_D = 8;
BEARING_H = 7;
BOLT_D = in2mm(1/4) + 0.1; // tolerance


WASHER_D = 17;
WASHER_IN_D = 8;
WASHER_H = 1.5;
module washer() {
    color("grey") linear_extrude(height=WASHER_H)
        donutSlice(WASHER_IN_D/2, WASHER_D/2, 0, 360);
}

module bearing_adapter() {
    h = BEARING_H + WASHER_H;
    linear_extrude(height=h) donutSlice(BOLT_D/2, BEARING_D/2, 0, 360);
}

HEAD_H = 3.85;
module head() {
    difference() {
        cylinder(d=WASHER_D, h=HEAD_H);
        translate([0, 0, -0.001]) cylinder(d1=14, d2=BOLT_D, h=HEAD_H+0.002);
    }
}

head();
//translate([0, 0, HEAD_H]) washer();
translate([0, 0, HEAD_H]) bearing_adapter();
