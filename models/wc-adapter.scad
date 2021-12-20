$fa = 1;
$fs = 0.4;

CLEARANCE = 0.3;

H = 9;
OUT_D = 16;
IN_D = 6;

difference() {
    union() {
        cylinder(d=OUT_D, h=H);
        translate([0, 0, -3]) cylinder(d=28, h=3);
    }   
    translate([0, 0, -4]) cylinder(d=IN_D+CLEARANCE, h=H*2);
}
