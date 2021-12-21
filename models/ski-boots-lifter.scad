use <lib/rounded_cube.scad>

$fa = 1;
$fs = 0.4;

module lifter(L, W, H, wall, floor=false) {
    corners=[2, 2, 2, 2];
    difference() {
        rounded_cube([L, W, H], center=true, corners=corners);
        rounded_cube([L-wall, W-wall, H+1], center=true, corners=corners);
    }

    if (floor) {
        h_floor = 2;
        translate([0, 0, -H/2 - h_floor/2])
         difference() {
            rounded_cube([L, W, h_floor], center=true, corners=corners);
            rounded_cube([L-wall-4, W-wall-4, h_floor+1], center=true, corners=corners);
        }
    }
    
}

lifter(20, 30, 30, 6);
lifter(27, 37, 30, 6, floor=true);
