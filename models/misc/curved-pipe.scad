// all values are in mm
$fa = 1;
$fs = 0.4;

R_wheel = 80.5;
D_thread = 5;
R_thread = D_thread/2;
thickness = 3;

module pipe(angle, tolerance) {
    rotate([90, 0, 0]) rotate_extrude(angle=angle) translate([R_wheel, 0, 0])
    difference() {
        outer = R_thread + tolerance + thickness/2;
        circle(r = outer);
        circle(r = R_thread + tolerance);
    }    
}

pipe(angle=2, tolerance=0.2);

translate([-10, 0, 0])
pipe(angle=4, tolerance=0.2);

translate([-20, 0, 0])
pipe(angle=6, tolerance=0.2);

translate([-30, 0, 0])
pipe(angle=2, tolerance=0.3);

translate([-40, 0, 0])
pipe(angle=4, tolerance=0.3);

module clock_hand(angle, length=R) {
    LINEW = 1;
    color("white")
    rotate([0, angle, 0]) translate([0, -LINEW/2, -LINEW/2]) cube([length, LINEW, LINEW]);
}
