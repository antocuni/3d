$fa = 1;
$fs = 0.4;

THICKNESS = 3; // total thickness
PLATE_THICKNESS = 0.4;

module text_spritzy(z=0, thickness=1) {
    X = 35;
    Y = 12.57028;
    color("white")
    translate([-X/2, -Y/2, z])
        linear_extrude(thickness)
        resize([X, Y, 0], auto=true)
        import("spritzy.svg");
}

module text_gughi(z=0, thickness=1) {
    X = 29.45763;
    Y = 12.60285;
    color("white")
    translate([-X/2, -Y/2, z])
        linear_extrude(thickness)
        resize([X, Y, 0], auto=true)
        import("gughi.svg");
}


module hole() {
    color("black") translate([0, 15, -0.1])
        cylinder(d=5, h=10);
}

module bottom() {
    T = THICKNESS - PLATE_THICKNESS - 0.2; // 0.2 is the label
    difference() {
        color("white") cylinder(d=40, h=T);
        hole();
    }
}

module top() {
    HT = THICKNESS - PLATE_THICKNESS; // hole thickness
    difference() {
        color("red") cylinder(d=42, h=THICKNESS);
        translate([0, 0, -0.001])
            cylinder(d=40.5, h=HT);

        //translate([0, 0, -1]) text_spritzy(z=0, thickness=10);
        translate([0, 0, -1]) text_gughi(z=0, thickness=10);
        hole();
    }
}


$t=1;

//bottom();
translate([0, 0, 0]) top();
