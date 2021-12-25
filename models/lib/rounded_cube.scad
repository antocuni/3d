use <vendored/rounded_square.scad>

$fa = 1;
$fs = 0.4;

// cube with rounded CORNERS
module rounded_cube(dim, center=false, corners=[1, 1, 1, 1]) {
    x = dim[0];
    y = dim[1];
    z = dim[2];
    tz = center ? -z/2 : 0;
    translate([0, 0, tz]) linear_extrude(z)
        rounded_square([x, y], corners=corners, center=center);
}

// cube with rounded EDGES
// XXX: make it possible to change the radius
module _rounded_cube_edges_centered(size) {
    x = size[0];
    y = size[1];
    z = size[2];
    translate([-0.5, 0.5, -0.5])
    minkowski() {
        cube([x-9, y-9, z-9], center=true);
        rotate([90, 0, 0]) cylinder(r=2,h=1);
        rotate([0, 90, 0]) cylinder(r=2,h=1);
        cylinder(r=2,h=1);
    }
}

module rounded_cube_edges(size, center=false) {
    if (center)
        _rounded_cube_edges_centered(size);
    else
        translate([size[0]/2, size[1]/2, size[2]/2])
            _rounded_cube_edges_centered(size);
}
