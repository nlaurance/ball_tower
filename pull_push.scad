$fa=1;
$fn=40;

use <handles.scad>
use <shapes.scad>



module base_as_box(size) {
  difference () {
    cube([size,size,20], center=true);
    cube([size,size-2,18], center=true);
  }
}


module push_pull_carriage() {
  difference () {
    cube([80,20,20], center=true);
    // hole = 2 inverted cones
    union () {
      translate([0,0,-5]) cylinder(h=10, d1=13, d2=11, center=true);
      translate([0,0,5]) cylinder(h=10, d1=11, d2=13, center=true);
    }
  }
}

// over hole 1
 /*translate([15,0,0]) push_pull_carriage();*/
// over hole 2
 /*translate([-15,0,0]) push_pull_carriage();*/
