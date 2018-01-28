$fa=1;
$fn=40;

use <handles.scad>
use <shapes.scad>

module shaft(width, length) {
  offset = width / 2;
  difference() {
    cube([width,width,length], center=true);
    union() {
      translate([offset,offset,0]) rotate([0,0,45]) cube([3,3,length], center=true);
      translate([-offset,offset,0]) rotate([0,0,45]) cube([3,3,length], center=true);
      translate([offset,-offset,0]) rotate([0,0,45]) cube([3,3,length], center=true);
      translate([-offset,-offset,0]) rotate([0,0,45]) cube([3,3,length], center=true);
    }
  }
}

/* shaft(10, 80); */

module picot_male(x, y) {
    translate([x,y,-6]) {
        cylinder(h=6,d=6);
        translate([0,0,-4]) cylinder(h=4,d=3);
      }
    }


module base_as_box(size) {
  difference () {
    cube([size,size,20], center=true);
    cube([size,size-2,18], center=true);
  }
}

module wheel_v1 () {
  /* rotate_handle(25, 25, 3); */
  difference () {
    // base as box
    base_as_box(120);
    // holes in base, right and left
    // TODO have to be z levelled
    union() {
      translate([15,30,11]) cylinder(h=20, d=13, center=true);
      translate([15,-30,-11]) cylinder(h=20, d=13, center=true);
    }
  }


  translate([0,0,5]) {
  picot_male(50,50);
  picot_male(-50,50);
  picot_male(50,-50);
  picot_male(-50,-50);
  }

  // this makes the 'flower' wheel
  translate([15,0,0]) {
    // axis
    cylinder(h=18, d=5, center=true);
    difference() {
      rotate_handle(10, 110, 5);
      translate([0,30,0]) cylinder(h=10, d=13, center=true);
  }
  }

  // axis hinge for flower axis
  translate([15,0,8]) tube(4,8,5);
  translate([15,0,-8]) tube(4,8,5);
}

wheel_v1();

// pseudo base
 /*base_as_box(120);
 square(120, center=true);
translate([15,0,0]) cylinder(h=40, d=11, center=true);
translate([-15,0,0]) cylinder(h=40, d=11, center=true);*/

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



/* rotate ([90,0,0]) linear_extrude(height = 2, center = true)
  polygon(points=[[0,0],[10,0],[0,10]]);

linear_extrude(height = 10, center = false)
  polygon(points=[[0,0],[10,0],[10,2], [0,2]]); */


module rounded_corner_box() {
  difference () {
    minkowski() {
      cube([10,10,2]);
      cylinder(h=1,r=1);
    }
   cube([10,10,3]);
  }
}

module another_rounded_corner_box() {
  hull() {
    translate([5,5,0]) cylinder(h=1, r=1);
    translate([5,-5,0]) cylinder(h=1, r=1);
    translate([-5,5,0]) cylinder(h=1, r=1);
    translate([-5,-5,0]) cylinder(h=1, r=1);
  }
}
