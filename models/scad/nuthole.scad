use <MCAD/nuts_and_bolts.scad>;
include <MCAD/units.scad>;

// with my printer, tolerance=0.1 seems to work well

$fa = 1;
$fs = 0.4;

H=5;
NUT_H = 3.85;

difference() {
    cylinder(h=H, r=8);
    translate([0, 0, H-NUT_H+0.0001])
        resize([0, 0, NUT_H])
        nutHole(M5, tolerance=0.1);
}
