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
 */
 
/* 
 * Modified by Eric Lofgren 2016-07-18 to add external tabs.
 *
 * This is a modification of brentb's Bahtinov mask generator.
 * See his post for details. I added a way to have tabs extend on the outside
 * of my telescope. The number and size of tabs are parametrized in the scad
 * file. Be sure to specify the outer diameter of your telescope to make it
 * fit--the tabs are added beyond the specified diameter.
 * A pull-handle is not necessary and would make printing very difficult,
 * so I just commented it out.
 */
 
/*
 * Modified by Robert Rath 2018-03-12 to
 * 
 * a) Tabulated dimensions to suit a variety of DSLR Lenses.
 * b) Added chamfers to tabs.
 * c) Corrected the maths to allow arbitrary tab thickness.
 *
 * This modification extends Eric Lofgren's modifications to Brent Burton's
 * original Bahtinov mask generator specifically targeting a collection of
 * DSLR lenses rather than a single lens.
 * 
 * A table of lenses and their attributes is the source for mask creation.
 * Simply uncomment the lens you wish to create a mask for or add new
 * lenses to the table as per the layout in the SCAD file.
 *
 * Updated : Robert Rath 2018-03-12 : Added Sigma Sport 150-600mm
 *
 * Please let me know if you add new lenses and I will update this file.
 */

/*
 * Modified by Tim Tait  2020-08-25 to
 * 
 *  - Add PL100-400 f6.3 lens to list
 *  - Add "Customizer" graphical support for Thingiverse and OpenSCAD 2019.5 or later
 *      Selection is done though pulldown lists and entry boxes
 *  - Add "custom" lens option to build mask dynamically from input
 *  - Auto adjust from 1st order to 3rd order Bahtinov is gaps are too small
 *  - rename to "bahtinov_universal.scad"
 *  - Fixed broken central clearance ring option
 *  - Add mask Z thickness option
 *  - Restore "handle" functionality option when retaining ring is disabled
 *  - Remove lens array from scad file, push pre-configured lenses to customizer "presets" stored in JSON file
 */
/*
 * Modified by Tim Tait  2021-11-18 to
 * 
 *  - Change minimum vane count check to be 8 rather than 16
 *  - Change error message for vane count check to be more clear
 *  - Make lenFocalLength a slider
*/

//////////////////////////////////////////////////////////////////////////////
// 
// Customerizer parameters
// 
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
/* [Lens Mask Parameters] */

// Focal Length (mm) (used to calculate size of mask vanes and gaps):
lensFocalLength = 400; // [1:4000]

// Lens Diameter (mm) (OD of front of lens, scope or hood if this will mount over it, ID of optical tube to mount inside):
lensDiameter = 88.5; // 0.5

// Clear Aperture (mm), must be at least 2mm less than lensDiameter (This determines the extent of the slots in the mask. For mounting on Lens: use filter thread size. Scope: use clear aperture. Hood/Dew Shield: inner diameter):
lensAperture = 78;

// The clearance diameter (mm) of the secondary mirror holder, use 0 if none.
centerHoleDiameter = 0; // 0.5

// Retaining Finger Height (mm), 0 if unused (for mounting mask on outside of lens/scope):
ringHeight = 15;

// Handle Height (mm), 0 if unused (for mounting inside of optical tube. Must specify 0 for ringHeight also):
handleHeight = 0;

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

// Handle Diameter (mm) 
handleDiameter = 5; // [4:6]

// Minimum printable Gap/Spoke Width (mm) (Adjust to printer capability, must be at least nozzle dia. If 1st order mask gap/spoke would be less, 3rd order will be used)
minGapWidth = 0.8;  // [0.5:0.1:1.0]

//////////////////////////////////////////////////////////////////////////////

// Old lens data
//
//// Lens Database Details      [diameter, aperture, slot, ringheight, handleheight]
//sigmaArt50mmDetails         = [ 85.3,     74.0,     0.50,  15.0,    0.0 ];
//canon100mmF28LDetails       = [ 76.7,     50.0,     0.50,  15.0,    0.0 ];
//canon70to20mmF28L2Details   = [ 87.9,     76.0,     1.00,  15.0,    0.0 ];
//sigmaSport150to600mmDetails = [117.9,     96.0,     1.50,  15.0,    0.0 ];
//PL100to400mmDetails         = [ 88.5,     75.0,     1.33,  15.0,    0.0 ];

//////////////////////////////////////////////////////////////////////////////
//
// End of Customizer parameters, can't put any after if statements or modules
//
//////////////////////////////////////////////////////////////////////////////

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
echo(centerHoleDiameter=centerHoleDiameter);
echo(gap=gap);
echo(ringHeight=ringHeight);
echo(ringThickness=ringThickness);
echo(ringTabInterference=ringTabInterference);
echo(handleHeight=handleHeight);
echo("*********************");
echo();

// Sanity checks on mask
assert((handleHeight == 0) || (ringHeight == 0), "*** Cannot have ring AND handle *** Set handleHeight to 0 for an outside mounted mask, or set ringHeight to 0 for an inside optical tube mounted mask.");

assert ((outerDiameter + (ringHeight > 0 ? ringThickness : 0) - lensAperture) >= 3, "*** RIM OF MASK IS TOO THIN ***, Try reducing the lensAperture");
assert ((lensAperture - centerHoleDiameter) >= (8 * 2 * gap), "*** LESS THAN 8 VANES ***, Check the centerHoleDiameter and lensAperture. Increase bahtinovFactor if needed.");
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
            // Add center hole margin ring if needed:
            if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
                circle(r=(centerHoleDiameter/2)+minGapWidth);
            }
        }
        // subtract center hole if needed
        if (centerHoleDiameter > 0 && centerHoleDiameter < outerDiameter) {
            circle(r=centerHoleDiameter/2);
        }
    }
}

module pie_slice(r = 10, deg = 30) {
    degn = (deg % 360 > 0) ? deg % 360 : deg % 360;
    //echo(degn=degn);
    difference() {
        circle(r);
        if (degn > 180) intersection_for(a = [0, 180 - degn]) rotate(a) translate([-r, 0, 0]) #square(r * 2);
        else union() for(a = [0, 180 - degn]) rotate(a) translate([-r, 0, 0]) square(r * 2);
    }
}


module retainingring(){
    difference()
    {
        cylinder(h=ringHeight+maskThickness,d=outerDiameter+2*ringThickness);
        translate([0,0,-1])cylinder(h=ringHeight+maskThickness+2,d=outerDiameter);
        for(angle=[0:360/ringPieces:359])
        {
            rotate([0,0,angle])
            linear_extrude(height=ringHeight+maskThickness+2)
            pie_slice(r=outerDiameter/2+2*ringThickness,deg=360/ringPieces-ringPiece);    
        }

        // chamfer the leading edges of the clips 
        translate([0,0,ringHeight+maskThickness-2+(ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2])
        {
            sphere(sqrt(2*((ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2)*((ringThickness/2)+(outerDiameter-sqrt(10*sqrt(2)))/2)));
        }    
    }
}

union() {
    linear_extrude(height=maskThickness) bahtinov2D();
    // add a little handle
    if (handleHeight > 0)
        translate([outerDiameter/2-handleDiameter/2,0,0])
            cylinder(r=handleDiameter/2, h=handleHeight+maskThickness);
    
    //add a retaining ring
    if (ringHeight > 0) 
        rotate([0,0,ringRotation]) retainingring();
}
