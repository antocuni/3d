$fa = 1;
$fs = 0.4;

// all values are in mm
R_wheel = 50;
R_thread = 2 + 0.2; // 2mm of radius, 4mm diameter, M4 screw
thickness = 10;

module wheel() {
    rotate([90, 0, 0]) rotate_extrude() translate([R_wheel, 0, 0])
    difference() {
        outer = R_thread + thickness/2;
        circle(r = outer);
        circle(r = R_thread);
        translate([0, -outer, 0]) square(outer*2);
    }
}

module cage() {
    rotate([90, 0, 0]) rotate_extrude(angle=8) translate([R_wheel, 0, 0])
    difference() {
        outer = R_thread + thickness/2;
        circle(r = outer);
        circle(r = R_thread);
    }    
}

union() {
    wheel();
    cage();
}
