$fa=1;
$fn=80;

use <dimensions.scad>
use <base_floor.scad>
use <handles.scad>

module rotate_floor() {
  difference () {
    base_floor(120, 4, 6, 3, 6, false);
    // opening in skirt for wheel
    translate([120,60,0])  cube([10,80,12], center=true);
  }
}

/*translate([120,60,0])  cube([10,60,15], center=true);*/

difference() {
  rotate_floor();
  translate([55,90,0]) cylinder(h=30, d=12, center=true);

}

wheel_angle = $t*360;

color([1,0,0])
translate([75,60,0]) rotate([0,0,wheel_angle]) {
  difference () {
    // wheel
    rotate_handle(9, 105, 5, plug=false);
    union () {
      // hole
      translate([-20,30,3]) cylinder(h=6, d1=11, d2=13, center=true);
      translate([-20,30,-3]) cylinder(h=6, d1=13, d2=11, center=true);
    }
  }
  // wheel axis
  cylinder(h=40, d=2, center=true);

}
