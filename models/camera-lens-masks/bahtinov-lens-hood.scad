/********************************************************
   bahtinov mask for the Canon ET-60 lens hood
  ********************************************************/

use <MCAD/2Dshapes.scad>

// +0.8 makes it very loose, so that we can remove it easily without turning
// the hood and loose focus
OD = 87 + 0.8;  // outer diameter of the lens hood
EXTRA_BORDER = 1.5;
H = 2;

// raised ring
linear_extrude(10) donutSlice(OD/2, OD/2 + EXTRA_BORDER, 0, 360);
// mask
color("red") linear_extrude(H) bahtinov2D();



// based on https://www.thingiverse.com/thing:4581618
/********************************************************/
/* OpenSCAD 2019.5 or later Required!                   */
/********************************************************/

/*                                                 -*- c++ -*-
 * A Bahtinov mask generator fo DSLR lenses.
 * Units in mm,
 *
 * Copyright 2013-2018, Brent Burton, Eric Lofgren, Robert Rath
 * License: CC-BY-SA
 *
 * Updated: Brent Burton 2014-06-23
 * Modified by Eric Lofgren 2016-07-18
 * Modified by Robert Rath 2018-03-12
 * Updated : Robert Rath 2018-03-12
 * Modified by Tim Tait  2020-08-25
 * Modified by Tim Tait  2021-11-18
*/

$fn=200;


// Focal Length (mm) (used to calculate size of mask vanes and gaps):
lensFocalLength = 300;

outerDiameter = OD; // diameter of the whole mask
aperture      = 78;   // diameter of the circle with the bahtinov bars

// compute the size of the bars
bahtinovFactor = 150; // use 150 to 200
// Minimum printable Gap/Spoke Width (mm) (Adjust to printer capability, must be at least nozzle dia. If 1st order mask gap/spoke would be less, 3rd order will be used)
minGapWidth = 0.8;  // [0.5:0.1:1.0]

// Calculate mask results
gap1x = (lensFocalLength / bahtinovFactor) / 2;          // 1st order slots
gap3x = (3 * lensFocalLength / bahtinovFactor) / 2;      // 3rd order slots in case 1x too small
echo(gap1x=gap1x);
echo(gap3x=gap3x);

if (gap1x < minGapWidth)
    echo("Using 3rd order bahtinov mask");
else
    echo("Using 1st order bahtinov mask");
// Can't set "variables" inside of if statement, so do this instead:
gap = gap1x < minGapWidth ? gap3x : gap1x;  // use 3rd order as first would be too thin

/* create a series of bars covering roughly one half of the
 * scope aperture. Located in the +X side.
 */
module bars(gap, width, num=5) {
    num = round(num);
    for (i=[-num:num]) {
        translate([width/2,i*2*gap]) square([width,gap], center=true);
    }
}

module bahtinovBars(gap,width) {
    numBars = aperture/2 / gap / 2 -1;
    // +X +Y bars
    intersection() {
        rotate([0,0,30]) bars(gap, width, numBars);
        square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // +X -Y bars
    intersection() {
        rotate([0,0,-30]) bars(gap, width, numBars);
        translate([0,-outerDiameter/2]) square([outerDiameter/2, outerDiameter/2], center=false);
    }
    // -X bars
    rotate([0,0,180]) bars(gap, width, numBars);
}

module bahtinov2D() {
    width = aperture/2;
    
    difference() {                          // overall plate minus center hole
        union() {
            difference() {                  // trims the mask to aperture size
                circle(r=aperture/2+1);
                bahtinovBars(gap,width);
            }
            difference() {                  // makes the outer margin
                circle(r=outerDiameter/2);
                circle(r=aperture/2);
            }
            // Add horizontal and vertical structural bars:
            square([gap,2*(aperture/2+1)], center=true);
            translate([aperture/4,0]) square([aperture/2+1,gap], center=true);
        }
    }
}
