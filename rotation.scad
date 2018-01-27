
$fa=1;
$fn=80;

include <base_floor.scad>
include <dimensions.scad>
use <handles.scad>

module rotate_piece(base_size, main_diam, shaft_diam) {
  difference() {
    // ball catch
    cylinder(h=25,d=main_diam, center=true);
    // ball hole
    translate([main_diam/4,0,0]) rotate([0,90,0])
    cylinder(h=main_diam/2,d=11, d2=13,center=true);
    sphere(d=11);
    // align with floor
    translate([15,0,0]) cube([10,25,30], center=true);
    // shaft junction
    translate([0,0,10]) cube([5,5,5], center=true);
    translate([0,0,-10]) cube([5,5,5], center=true);
  }
}


module rotate_floor() {
  difference () {

    union () {
      difference () {
        translate([0,0,0]) base_floor(120, 4, 6, 3, 6, false);
        union () {
          translate([60,60,0]) rotate([0,90,0])
          cylinder(h=118,d=23, center=true);
          }
        }

      // tunnel roof, could be replaced by a tube call
      translate([60,60,0]) rotate([0,90,0])  {
        difference() {
          cylinder(h=120,d=24, center=true);
          union() {
            cylinder(h=114,d=21, center=true);
            }
          }
        }

      // shaft rotation supports
      translate([60,60,0]) rotate([0,90,0]) {
        difference() {
          translate([0,0,14]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
        }
        difference () {
          translate([0,0,-14]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
        difference () {
          translate([0,0,58]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
        // back
        difference () {
          translate([0,0,-56]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
      }
    }
    union () {
      // cut in half
      translate([0,0,-40]) cube([130,130,40]);
      // hole for shaft in base skirt
      translate([120,60,0]) rotate([0,90,0]) cylinder(h=60,d=10, center=true);
      // opening in roof
      translate([60,60,0]) cube([25,13,25], center=true);
      }
    }
}

rotate_floor();
translate([60,60,0]) rotate([0,-90,0])  rotate_piece(20,23,10);
translate([133,60,0]) rotate([0,-90,0]) rotate_handle(25, 25, 3);
// shaft
translate([130,60,0]) rotate([0,-90,0]) cylinder(h=130,d=10);


translate([0,120,0]) rotate([0,180,180]) rotate_floor();
