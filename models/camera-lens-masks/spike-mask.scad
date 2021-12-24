use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

D = 58;
R = D/2;

R3 = R+0.5;
R2 = R-0.8;
R1 = R-1.7;
R0 = R-2.5;

H = 1.8;

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

W = H;
translate([0, 0, W/2]) {
    cube([R0*2, W, W], center=true);
    cube([W, R0*2, W], center=true);
}

