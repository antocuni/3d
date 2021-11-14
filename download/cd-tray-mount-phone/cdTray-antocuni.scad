// CD tray mount for cell phone

// Author: Philippe Vanhaesendonck
// License: CC BY-NC-SA
// Based on original work from:
//  http://www.thingiverse.com/thing:644402


// OpenSCAD stuff
delta       = 0.1;    // Small delta used for differences
offset      = 1.0;    // Bigger offset
$fa         = 3;      // Min segment angle for facets
$fs         = 0.5;    // Min segment size

// Cell phone size (Nexus 4)
g_l = 75;            // Length
g_h = 30;            // Height 
g_w = 10;             // Width
g_u = 25;             // Heigth of the USB hole

h_w = 3;              // Wall thickness
h_b = 6;              // 'Border' size

// Holder design -- polygon points
p_holder = [
  [-g_l / 2 - h_w    , 0],
  [ g_l / 2 + h_w    , 0],
  [ g_l / 2 + h_w    , g_h + h_w],
  [ g_l / 2          , g_h + h_w],
  [ g_l / 2 - h_b    , g_h + h_w - h_b],
  [ g_l / 2 - h_b    , 2 * h_b + h_w],
  [ g_l / 2 - 2 * h_b, h_b + h_w],
  [-g_l / 2 + 2 * h_b, h_b + h_w],
  [-g_l / 2 + h_b    , 2 * h_b + h_w],
  [-g_l / 2 + h_b    , g_h + h_w - h_b],
  [-g_l / 2          , g_h + h_w],
  [-g_l / 2 - h_w    , g_h + h_w]  
];

// CD insert size
cd_l = 120;           // Length (width)
cd_h = 38;            // Height (depth)
cd_c = 8;             // Chamfer (at the end)
cd_w = 2;             // Width

// Polygon for the insert
p_cd = [
  [0           , -cd_l / 2],
  [-cd_h + cd_c, -cd_l / 2],
  [-cd_h       , -cd_l / 2 + cd_c],
  [-cd_h       ,  cd_l / 2 - cd_c],
  [-cd_h + cd_c,  cd_l / 2],
  [0           ,  cd_l / 2]  
];

// Draw holder
module holder() {
  difference() {
    // Holder 'volume'
    linear_extrude(height = g_w + 2 * h_w, convexity = 5)
      offset(delta=2, chamfer=true) 
        offset(delta=-2) 
          polygon(points = p_holder,
            paths = [
              [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            ]);
    // Phone 'pocket'
    translate([-g_l / 2, h_w, h_w])
      cube([g_l, g_h, g_w]);
    // USB clearance
    /* translate([g_l / 2 - delta, h_w + g_u, h_w]) */
    /*   cube([h_w + delta * 2, g_h, g_w]); */

    translate([-6, -h_w, g_w/2])
         cube([12, h_w*3, 6]);
  }
}


// Draw insert
module cd_insert() {
  linear_extrude(height = cd_w, convexity = 3)
    polygon(points = p_cd,
      paths = [
        [0, 1, 2, 3, 4, 5, 6]
      ]);
}


// Draw all parts
rotate([90, 0, 90])
  holder();
cd_insert();

