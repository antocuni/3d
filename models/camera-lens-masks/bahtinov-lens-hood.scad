// based on https://www.thingiverse.com/thing:4581618
// modified and adapted by antocuni

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



// Focal Length (mm) (used to calculate size of mask vanes and gaps):
lensFocalLength = 400; // [1:4000]

// Lens Diameter (mm) (OD of front of lens, scope or hood if this will mount over it, ID of optical tube to mount inside):
lensDiameter = 88.5; // 0.5

// Clear Aperture (mm), must be at least 2mm less than lensDiameter (This determines the extent of the slots in the mask. For mounting on Lens: use filter thread size. Scope: use clear aperture. Hood/Dew Shield: inner diameter):
lensAperture = 78;

// Retaining Finger Height (mm), 0 if unused (for mounting mask on outside of lens/scope):
ringHeight = 15;


// Bahtinov Factor, use 150 to 200
bahtinovFactor = 150; // [150:200]

//////////////////////////////////////////////////////////////////////////////
/* [Mask Options] */

// Retaining fingers offset (mm) from lens diameter. (0 makes fingers inner face flush against lensDiameter. Postive values to fit inside, negative values to fit outside):
ringTabInterference = -1.2;     // -1.2 to oversize and use 1mm felt pads on fingers

// The Z thickness (mm) of the mask:
maskThickness = 2; //

// The thickness (mm) of the retaining fingers:
ringThickness = 1.6; //

// The number of retaining fingers:
ringPieces = 3; // 

// The Angle (deg) of the each retaining fingers (use 360/ringPieces for a solid ring):
ringPiece = 30; // 

// The Rotation (deg) of the retaining tabs with respect to the mask:
ringRotation = 0;


// Minimum printable Gap/Spoke Width (mm) (Adjust to printer capability, must be at least nozzle dia. If 1st order mask gap/spoke would be less, 3rd order will be used)
minGapWidth = 0.8;  // [0.5:0.1:1.0]






outerDiameter = ringHeight > 0 ? lensDiameter - ringTabInterference : lensDiameter;
aperture      = lensAperture;

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

echo();
echo("**********************");
echo("*** Key Parameters ***");
echo("**********************");
echo(outerDiameter=outerDiameter);
echo(aperture=aperture);
echo(gap=gap);
echo(ringHeight=ringHeight);
echo(ringThickness=ringThickness);
echo(ringTabInterference=ringTabInterference);
echo("*********************");
echo();

// Sanity checks on mask

assert ((outerDiameter + (ringHeight > 0 ? ringThickness : 0) - lensAperture) >= 3, "*** RIM OF MASK IS TOO THIN ***, Try reducing the lensAperture");
assert (gap >= minGapWidth, "*** UNABLE TO MAKE SLOT WIDTH THICK ENOUGH ***, Mask may not be printable, you can try to  decrease the minGapWidth setting if you think it wise.");

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

$fn=200;
module bahtinov2D() {
    width = aperture/2;
    
    difference() {                          // overall plate minus center hole
        union() {
            difference() {                  // trims the mask to aperture size
                circle(r=aperture/2+1);
                bahtinovBars(gap,width);
            }
            difference() {                  // makes the outer margin
                circle(r=outerDiameter/2+(ringHeight == 0 ? 0 : ringThickness));  // Re-written to make the ringThickness independent.
                circle(r=aperture/2);
            }
            // Add horizontal and vertical structural bars:
            square([gap,2*(aperture/2+1)], center=true);
            translate([aperture/4,0]) square([aperture/2+1,gap], center=true);
        }
    }
}




bahtinov2D();
//#cylinder(d=outerDiameter, h=1);
