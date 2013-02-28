// PRUSA iteration3
// Y drivetrain (idler and stepper holders)
// GNU GPL v3
// Josef Průša <josefprusa@me.com>
// Václav 'ax' Hůla <axtheb@gmail.com>
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration.scad>
use <inc/bearing-guide.scad>

module motorholder(thickness=10){
    difference(){
        union(){
            // Motor holding part
            translate([29, -21 + 50, 0])
            {
                //#cube([42, 42, 2], center=true);
                difference(){
                    union(){
                        translate([-21 + 4.5, 0, 5]) cube([9, 31, thickness], center=true);
                        nema17([0, 1, 1, 0], thickness=thickness, shadow=false);
                        mirror([0, 0, 1]) translate([0, 0, -10]) nema17([0, 1, 1, 0], thickness=thickness, shadow=7);
                        // Parts joining part
                        translate([-29, -21, 0]) cube([14, 30, thickness]);
                    }
                    // Motor mounting holes
                    translate([0, 0, thickness]) mirror([0, 0, 1]) nema17([0, 1, 1, 0], thickness=thickness, holes=true);
                }
            }

            // Front holding part
            translate([0, 10, 0]) cylinder(h = thickness, r=8);
            translate([0, 20, 5]) cube([16, 20, thickness], center=true);
            translate([0, 30, 0]) cylinder(h = thickness, r=8);
        }
        translate([0, 10, -1]) cylinder(h = 12, r=4.5);
        translate([0, 30, -1]) cylinder(h = 12, r=4.5);
    }
}

module oval(r=4, l=15, h=2){
    translate([l / 2, 0, 0]) cylinder(r=r, h=h, $fn=4);
    translate([-l / 2, 0, 0]) cylinder(r=r, h=h, $fn=4);
    translate([0, 0, h / 2]) cube([l, r * 2, h], center=true);
}


module idlermount(len=42, narrow_len=0, narrow_width=0, rod=threaded_rod_diameter_horizontal / 2, idler_height=16){
    difference(){
        union(){
            //wide part holding bearing
            translate([- (10 + idler_width) / 2, -25 + narrow_len, 0] ) cube_fillet([10 + idler_width, len + idler_bearing[2] - narrow_len, idler_height]);
            if (narrow_len > 0){
                translate([-narrow_width / 2, -25, 0] ) cube_fillet([narrow_width, len + idler_bearing[2], idler_height], vertical=[0, 0, 2, 2]);
            }
        }
        translate([-12, -10, idler_height / 2]) rotate([90, 0, 90]) oval(r=rod, l=12, h=25);
        translate([0, -17, idler_height / 2]) rotate([90, 0, 0]) cylinder(r=3.4, h=9, $fn=6, center=true);
        translate([0, -19, idler_height / 2]) rotate([90, 90, 0]) cylinder(r=3.2/2, h=15, $fn=7, center=true);

            translate([0, len + idler_bearing[2] - 33, idler_height / 2]) {
                rotate([0, 90, 0]) idler_assy(idler_bearing);
                translate([0, 10, 0]) cube([idler_width + 1, 20, idler_height + 2], center=true);
            }

    }
}


motorholder();
translate([32, 20, 0])  idlermount();

if (idler_bearing[3] == 1) {
    translate([0, -12 - idler_bearing[0] / 2, 0]) {
        bearing_guide_inner();
        translate([idler_bearing[0] + 10, 0, 0])
            bearing_guide_outer();
    }
}
