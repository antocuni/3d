include <MCAD/shapes.scad>

module miniwrench() {
    SX = 30;
    SY = 10;
    SZ = 5;

    nut_d = 10.90 + 0.1; // 1/4" nut

    difference() {
        union() {
            translate([0, -SY/2, 0]) cube([SX, SY, SZ]);
            translate([SX, 0, 0]) cylinder(d=SY, h=SZ);
            cylinder(d=SY*2, h=SZ);
        }
        translate([0, 0, 0]) hexagon(nut_d, SZ*3);
        translate([-8, 0, 0]) cube([SY, 100, 100], center=true);
    }

}

miniwrench();
