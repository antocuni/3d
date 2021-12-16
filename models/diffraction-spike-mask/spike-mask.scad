use <MCAD/2Dshapes.scad>

$fa = 1;
$fs = 0.4;

D = 58;
R = D/2;

R3 = R+0.5;
R2 = R-1.5;
R1 = R-3;
R0 = R-5;

H = 1.8;

difference() {
    linear_extrude(H) donutSlice(R1, R3, 0, 360);

    for(i=[0:3]) {
        translate([0, 0, -0.1]) linear_extrude(H+1) {
            a = i*120;
            donutSlice(R1-0.01, R2+0.01, a, a+30);
            donutSlice(R1-0.01, R3+0.01, a-3, a+0.1);
        }
    }
    
}

for(i=[0:5])
    linear_extrude(4.6) donutSlice(R2, R, i*60, i*60+15);


linear_extrude(H) donutSlice(R0, R1, 0, 360);

W = 1.5;
translate([0, 0, W/2]) {
    cube([R0*2, W, W], center=true);
    cube([W, R0*2, W], center=true);
}

