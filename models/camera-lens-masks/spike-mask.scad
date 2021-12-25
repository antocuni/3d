use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

D = 58;
R = D/2;

//"bigger" mask: more robust but I think it looses a bit of light because it
// covers a small part of the lens
/*
R3 = R+0.5;
R2 = R-0.8;
R1 = R-1.7;
R0 = R-2.5;
*/

// slightly smaller mask which doesn't cover any part of the lens (apart the
// cross section, obviously
R3 = R+0.5;
R2 = R-0.6;
R1 = R-1.4;
R0 = R-2;

H = 2.5;
W = 1; // cross section of the cross

ANGLE = 6;

difference() {
    linear_extrude(H) donutSlice(R1, R3, 0, 360);

    for(i=[0:3]) {
        translate([0, 0, -0.1]) linear_extrude(H+1) {
            a = i*120 + ANGLE;
            donutSlice(R1-0.01, R2+0.01, a, a+20);
            donutSlice(R1-0.01, R3+0.01, a-3, a+0.1);
        }
    }
    
}

for(i=[0:5]) {
    a = i*60 + ANGLE;
    linear_extrude(4.6) donutSlice(R2, R, a, a+15);
 }


linear_extrude(H) donutSlice(R0, R1, 0, 360);


translate([0, 0, H/2]) {
    cube([R0*2, W, H], center=true);
    cube([W, R0*2, H], center=true);
}

