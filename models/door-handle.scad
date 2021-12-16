$fa = 1;
$fs = 0.4;

D=16.8;

difference() {
    cylinder(d=D, h=50);

    translate([0, 10, 15])
         rotate([90, 0, 0])
         cylinder(d=3, h=20);

    translate([0, D/2, 15+22-2.4])
         rotate([90, 0, 0])
         cylinder(d=3, h=D/2);

    translate([0, 0, 15+22-2.4-1])
         rotate([90, 0, 0])
         cylinder(d=3, h=D/2);

    
    translate([-D/2, 0, 15+22-2.4-0.5])
         rotate([0, 90, 0])
         cylinder(d=3, h=D/2);

    translate([0, 0, 15+22-2.4-1.5])
         rotate([0, 90, 0])
         cylinder(d=3, h=D/2);

}
