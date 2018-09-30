$fn=40;

difference() {
difference() {
cylinder(r1=9, r2=7, h=20);
cylinder(r=5, h=60);
}

translate([2,-10,0]) cube([10,20,60]);
}

difference() {
hull() {
translate([10,10,0]) cylinder(d=20, h=2, center=true);
translate([10,-10,0]) cylinder(d=20, h=2, center=true);
translate([-10,0,0]) cylinder(d=20, h=2, center=true);
}

union() {
translate([13,13,0]) cylinder(d=2, h=20, center=true);
translate([13,-13,0]) cylinder(d=2, h=20, center=true);
translate([-13,0,0]) cylinder(d=2, h=20, center=true);
}
}