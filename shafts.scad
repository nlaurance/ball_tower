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

module polygon_shaft(width, length, sides) {

  linear_extrude(height = length, center = true)
    circle(width,$fn=sides);
  translate([0,0,2.5+length/2]) cube([5,5,5], center=true);
}


/* linear_extrude(height = 5, center = true, convexity = 10)
  translate([-30,-170,0])
  import(file = "button_profile.dxf", convexity=4); */

/* rotate_extrude(angle = 360, convexity = 2)
translate([-30,-170,0])
import(file = "button_profile.dxf"); */

/*
rotate_extrude(angle = 180, convexity = 3)
rotate([0,0,90])
translate([-10,0,0])
import(file = "button_profile.dxf"); */

translate([50,0,0]) cut_corners_shaft(10, 80);
translate([-50,0,0]) round_shaft(10, 80);
translate([0,30,0]) polygon_shaft(7, 80, 3);
translate([0,50,0]) polygon_shaft(5, 80, 5);
translate([0,70,0]) polygon_shaft(5, 80, 6);
