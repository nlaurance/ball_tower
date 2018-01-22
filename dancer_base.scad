$fa=1;
$fn=50;

module torus(ext_radius, inner_radius) {
  rotate_extrude(convexity = 10)
  translate([ext_radius, 0, 0])
  circle(r = inner_radius, $fn = 100);
}

difference() {
  cylinder(h=10, d=100);
  translate([0, 0, 10]) torus(40,2);
}
