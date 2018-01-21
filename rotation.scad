
$fa=1;
$fn=20;

module rotate_handle(long, larg, attach, grip) {
    cylinder(h=long,d=larg);
//    rotate([0,0,90]) translate([0,larg/2,0]) cylinder(h=long,d=grip);
    for (i=[0:20:350]) {
        rotate([0,0,i]) translate([0,larg/2,0]) cylinder(h=long,d=grip);
    }
    translate([0,0,long+attach/2]) cube([attach,attach,attach], center=true);
    }

module rotate_piece() {
    // rotate_handle() 
    translate([10,0,0]) rotate([0,90,0]) cylinder(h=30,d=10);
    translate([40,0,0]) cube([10,5,5], center=true);
    
    translate([-40,0,0]) rotate([0,90,0]) cylinder(h=30,d=10);
    difference() {
    rotate([0,90,0]) cylinder(h=20,d=18, center=true);
    sphere(d=11);
    translate([0,0,10]) cylinder(h=20,d=11, center=true);
    translate([0,0,9]) cube([22,11,4], center=true);
    translate([0,0,10]) sphere(d=13);
    }
}

module rotate_floor(base_size, base_height, corner_size) {

    triangle_points =[[0,0],[corner_size,0],[0,corner_size]];
    triangle_paths =[[0,1,2]];
    translate([base_size,0,base_height]) rotate([0,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([base_size,base_size,base_height]) rotate([90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,0,base_height]) rotate([-90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,base_size,base_height]) rotate([180,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    
    
    difference() {
    // base
    cube([base_size,base_size,base_height], center=false);
    translate([60,60,0]) cylinder(h=base_height,d=11, d2=13);
    }
}

//rotate_floor(120, 3, 5);


//rotate([0,90,0]) rotate_handle(25, 25, 5, 3);

rotate_piece();







