use <MCAD/2Dshapes.scad>
use <gear_with_nud.scad>

$fa = 1;
$fs = 0.4;

H=3;
BEARING_H=1.3;

module fakewheel() {
    difference() {
        linear_extrude(H) donutSlice(5, 14, 0, 360);
        translate([0, 0, H-BEARING_H+0.0001])
            axial_bearing_inset();
    }
}


D=11;
translate([32, 0, 0])
difference() {
    fakewheel();
    // hole=1.7, pin=1.4 works. But I need to try with polyhole
    translate([ D, 0, -0.1]) cylinder(h=H+0.2, r=1.7);
    translate([-D, 0, -0.1]) cylinder(h=H+0.2, r=1.7);
    translate([ 0, D, -0.1]) cylinder(h=H+0.2, r=1.7);
    translate([ 0,-D, -0.1]) cylinder(h=H+0.2, r=1.7);
}

union() {
    fakewheel();
    translate([ D, 0, 0]) cylinder(h=H+3, r=1.4);
    translate([-D, 0, 0]) cylinder(h=H+3, r=1.4);
    translate([ 0, D, 0]) cylinder(h=H+3, r=1.4);
    translate([ 0,-D, 0]) cylinder(h=H+3, r=1.4);
}
