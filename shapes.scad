module tube(height, outer, inner) {
  difference() {
    cylinder(h=height, d=outer, center=true);
    cylinder(h=height, d=inner, center=true);
  }
}

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


module picot_male(x, y) {
    translate([x,y,-6]) {
        cylinder(h=6,d=6);
        translate([0,0,-4]) cylinder(h=4,d=3);
      }
    }

module picot_female (x, y) {
    translate([x,y,-3]) difference () {
    cylinder(h=6,d=6, center=true);
    cylinder(h=6,d=3, center=true);
    }
    }


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
