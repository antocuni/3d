// params for lego-compatible wheels are taken from here:
// https://github.com/miklasiu/lego_gears/

use <MCAD/2Dshapes.scad>
use <MCAD/nuts_and_bolts.scad>;
include <MCAD/units.scad>;
use <gears/gears.scad> // https://github.com/chrisspen/gears
$fa = 1;
$fs = 0.4;

BEARING_H=1.3;
module axial_bearing_inset(tolerance=0.4) {
    // https://www.amazon.it/gp/product/B075F76KHN/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1
    inner_r = 8.3/2;
    outer_r = 16/2;
    height = BEARING_H;
    linear_extrude(height) donutSlice(inner_r-(tolerance), outer_r+(tolerance), 0, 360);
}

module gear_with_nut(TEETH=24, H=8, NUT_H=3.85) {
    difference() {
        spur_gear(1, TEETH, H, 0, pressure_angle=20, helix_angle=0, optimized=false);

        translate([0, 0, -0.0001])
            axial_bearing_inset();

        translate([0, 0, H-BEARING_H+0.0001])
            axial_bearing_inset();

        translate([0, 0, (H-NUT_H)/2])
            nutHole(M5, tolerance=0.1);

        translate([0, 0, -0.5])
            cylinder(H+1, d=7);
    }


}


gear_with_nut();


//test_axial_bearing_inset();
//test_double_axial_bearing_inset();

module test_axial_bearing_inset() {
    H=3;
    difference() {
        cylinder(h=H, r=10);
        translate([0, 0, H-1.3+0.0001]) axial_bearing_inset();
    }
}

module test_double_axial_bearing_inset() {
    H=4;
    difference() {
        cylinder(h=H, r=10);
        translate([0, 0, -0.00001]) axial_bearing_inset();
        translate([0, 0, H-1.3+0.0001]) axial_bearing_inset();
        
    }
    
}
