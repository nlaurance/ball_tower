$fa=1;
$fn=40;

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

module handle_1(handle_size) {

  offset = handle_size /2;

  difference() {
    cube([handle_size,handle_size,handle_size], center=true);
    union() {
      // corners
      translate([-offset,-offset,0]) cylinder(h=40, d=8, center=true);
      translate([offset,-offset,0]) cylinder(h=40, d=8, center=true);
      translate([-offset,offset,0]) cylinder(h=40, d=8, center=true);
      translate([offset,offset,0]) cylinder(h=40, d=8, center=true);

      // sides
      translate([-offset*2.2,0,0]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([0,-offset*2.2,,0]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([offset*2.2,0,0]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([0,offset*2.2,,0]) cylinder(h=40, d=handle_size*1.5, center=true);

      // shaft plug
      translate([0,0,handle_size/2-2.5]) cube([5,5,5], center=true);
    }
  }
}

/* handle_1(30); */

module handle_2(handle_size) {

  offset = handle_size /2;
  difference() {
    cube([handle_size,handle_size,handle_size], center=true);
    union () {
      translate([-offset*2.2,0,0]) rotate([90,0,0]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([offset*2.2,0,0]) rotate([90,0,0]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([0,offset*2.2,0]) rotate([90,0,90]) cylinder(h=40, d=handle_size*1.5, center=true);
      translate([0,-offset*2.2,0]) rotate([90,0,90]) cylinder(h=40, d=handle_size*1.5, center=true);
      // shaft plug
      translate([0,0,handle_size/2-2.5]) cube([5,5,5], center=true);
    }
  }
}
/* handle_2(25); */


module rotate_handle(long, larg, grip) {
  difference () {
    union () {
      cylinder(h=long,d=larg, center=true);
      for (i=[0:20:350]) {
          rotate([0,0,i]) translate([0,larg/2,0]) cylinder(h=long,d=grip, center=true);
      }
    }
    // shaft plug
    translate([0,0,long/2-2.5]) cube([5,5,5], center=true);
  }
}

/* rotate_handle(25, 25, 3); */
difference () {
  // base as box
  difference () {
    cube([120,120,20], center=true);
    cube([120,118,18], center=true);
  }
  // holes in base, right and left
  // TODO have to be z levelled
  union() {
    translate([15,30,11]) cylinder(h=20, d=13, center=true);
    translate([15,-30,-11]) cylinder(h=20, d=13, center=true);
  }
}

module picot_male(x, y) {
    translate([x,y,-6]) {
        cylinder(h=6,d=6);
        translate([0,0,-4]) cylinder(h=4,d=3);
      }
    }
translate([0,0,5]) {
picot_male(10,10);
picot_male(110,10);
picot_male(10,110);
picot_male(110,110);
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

module tube(height, outer, inner) {
  difference() {
    cylinder(h=height, d=outer, center=true);
    cylinder(h=height, d=inner, center=true);
  }
}

// axis hinge for flower axis
translate([15,0,8]) tube(4,8,5);
translate([15,0,-8]) tube(4,8,5);
