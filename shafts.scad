$fn=40;

module cut_corners_shaft(width, length) {
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
  translate([0,0,2.5+length/2]) cube([5,5,5], center=true);
}

module round_shaft(width, length) {
  cylinder(h=length, d=width, center=true);
  translate([0,0,2.5+length/2]) cube([5,5,5], center=true);
}

/* translate([50,0,0]) cut_corners_shaft(10, 80); */
translate([-50,0,0]) round_shaft(10, 80);
