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
cube([120,120,20], center=true);
cube([120,118,18], center=true);
}

// this makes the 'flower' wheel
translate([20,0,0]) {
  difference() {
  rotate_handle(10, 100, 5);
  translate([30,0,0]) cylinder(h=10, d=13, center=true);
}
}
