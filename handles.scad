$fn=40;

module right_left_handle(handle_size) {

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

module push_pull_handle(handle_size) {

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

translate([30,0,0]) right_left_handle(25);
translate([-30,0,0]) push_pull_handle(25);
translate([0,30,0]) rotate_handle(25, 25, 3);
