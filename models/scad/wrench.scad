// https://www.thingiverse.com/thing:4395626/

use <MCAD/shapes.scad>		// For octagon

$fn = 50;					// So the cylinders are smooth

//nut_diameter = 5.6;			// My M3 nut measured ~5.4, I added a fudge factor
//nut_thickness = 2.31;

// [antocuni] my 1/4" photographic nut
// NOTE: the diameter of the hexagon() is the d of the inscribed circle
// (i.e. measured "face to face", compare to the outscribed circle which is
// vertex-to-vertex)
nut_diameter = 10.90 + 0.2; // add some tolerance
nut_thickness = 5.44;



// Calculate some nice values

wrench_thickness = 1.2 * nut_thickness;
wrench_length = 5.25 * nut_diameter;
wrench_head_extra_d = 1.1 * nut_diameter;	// If your wrench is big, you
										// probably just want this to be 10

// Something to make wrench heads for us

module wrench_head(thickness, nut_d, head_extra, open_ended) {
	difference() {
		translate([0, 0, -thickness / 2]) {
			cylinder(h = thickness, r = (nut_d + head_extra) / 2);
		}

		if (open_ended) {
                hexagon(nut_d, thickness * 1.1);
        }
        else {
           rotate(30) {
 			hexagon(nut_d, thickness * 1.1);
            }
        }

        // XXX the following is wrong: we should use some formula to compute
        // the diameter of the outscribed circle from the inscribed one
        out_d = nut_d * 1.15;
		translate([-out_d/2, 0, -thickness*1.1 / 2]) {
			if (open_ended) {
                cube([out_d, nut_d+head_extra, thickness * 1.1]);
			}
        }
	}
}

// Put us flat on the bed

translate([0, 0, wrench_thickness / 2]) {

	// The handle

	box(nut_diameter, wrench_length, wrench_thickness);

	// Make the closed head

	translate([0, -((wrench_length + wrench_head_extra_d) / 2), 0]) {
		wrench_head(wrench_thickness, nut_diameter, wrench_head_extra_d, false);
	}

	// And the open head

	translate([0, (wrench_length + wrench_head_extra_d) / 2, 0]) {
		wrench_head(wrench_thickness, nut_diameter, wrench_head_extra_d, true);
	}
}
