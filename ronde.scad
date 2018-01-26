$fn=50;

module torus(inner, outer) {

  rotate_extrude(convexity = 10)
  translate([inner, 0, 0])
  rotate([0,0,90])
  circle(r=outer, $fn=50);
}


module bouton() {
translate([0, 0, 20]) sphere(6);
hull() torus(12, 6);

hull() {
  translate([0, 0, 20]) torus(6, 3);
  torus(12, 4);
  }
}

/*bouton();
translate([0, 0, -50]) cylinder(h=50, d=10);*/

/*minkowski() {
  difference() {
    cube(50, center=true);
    union() {
      translate([-40,0,0]) rotate([90,0,0]) cylinder(h=80, d=80, center=true);
      translate([0,40,0]) rotate([90,0,90]) cylinder(h=80, d=80, center=true);
    }
  }
cylinder(h=1,d=2);
}*/

module arc() {
difference() {
  torus(25, 5, 90);
  translate([30,0,0]) cube(60, center=true);
}
translate([0,25,0]) sphere(5);
translate([0,-25,0]) sphere(5);
}

/*hull() {
translate([0,0,-40]) rotate([0,90,0]) arc();
translate([0,0,40]) rotate([0,-90,0]) arc();
translate([40,0,0]) rotate([0,0,0]) arc();
translate([-40,0,0]) rotate([0,180,0]) arc();
}*/

scale([1.5,1,3]) sphere(10);
