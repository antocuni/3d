$fa = 1;
$fs = 0.4;

translate([-20, 0, 0])
rotate([0, 30, 0]) rotate([90, 0, 0]) rotate_extrude(angle=60) translate([20, 0, 0])
import("profile.svg");

translate([1, -1, -12.5]) cube([2, 9, 25]);

