module tube(height, outer, inner) {
  difference() {
    cylinder(h=height, d=outer, center=true);
    cylinder(h=height, d=inner, center=true);
  }
}
