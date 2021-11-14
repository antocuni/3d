use <MCAD/2Dshapes.scad>
use <MCAD/polyholes.scad>

$fa = 1;
$fs = 0.4;

D=25;
TOL=0.2;
linear_extrude(2) donutSlice(12/2+TOL, D/2, 0, 360);
translate([0, 0, 2-0.0001]) linear_extrude(8.2) donutSlice(22/2+TOL, D/2, 0, 360);

//polyhole(r=5, h=10);
