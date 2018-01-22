
$fa=1;
$fn=80;

module rotate_handle(long, larg, attach, grip) {
    cylinder(h=long,d=larg);
//    rotate([0,0,90]) translate([0,larg/2,0]) cylinder(h=long,d=grip);
    for (i=[0:20:350]) {
        rotate([0,0,i]) translate([0,larg/2,0]) cylinder(h=long,d=grip);
    }
    translate([0,0,long+attach/2]) cube([attach,attach,attach], center=true);
    }

module rotate_piece() {
    // handle extension
    translate([10,0,0]) rotate([0,90,0]) cylinder(h=30,d=10);
    translate([40,0,0]) cube([10,5,5], center=true);
    // rotation support
    translate([-40,0,0]) rotate([0,90,0]) cylinder(h=30,d=10);
    difference() {
    // main
    rotate([0,90,0]) cylinder(h=20,d=18, center=true);
    // hole
    sphere(d=11);
    translate([0,0,10]) cylinder(h=20,d=11, center=true);
    translate([0,0,9]) cube([22,11,4], center=true);
    }
}

module rotate_piece_2(base_size, main_diam, shaft_diam) {
    difference() {
    union() {
    // shaft
    cylinder(h=base_size,d=shaft_diam, center=true);
    translate([0,0,base_size/2]) cube([4,4,8], center=true);
    // ball catch
    cylinder(h=20,d=main_diam, center=true);
    }

    translate([-main_diam/4,0,0]) rotate([0,90,0]) cylinder(h=main_diam/2,d=13, d2=11,center=true);
    sphere(d=11);
}
}


module picot_male() {
//    translate([3,-15,0]) rotate([0,90,0]) union() {
//        cylinder(h=6,d=6, center=true);
//        cylinder(h=10,d=3, center=true);
//    }
        cylinder(h=6,d=6, center=true);
        cylinder(h=10,d=3, center=true);

    }

module picot_female (x, y) {
    translate([x,y,-3]) difference () {
    cylinder(h=6,d=6, center=true);
    cylinder(h=6,d=3, center=true);
    }
    }

module rotate_floor(base_size, base_height, corner_size) {

    picot_female(10,10);
    picot_female(110,110);
    picot_female(110,10);
    picot_female(10,110);

    triangle_points =[[0,0],[corner_size,0],[0,corner_size]];
    triangle_paths =[[0,1,2]];
    translate([base_size,0,base_height]) rotate([0,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([base_size,base_size,base_height]) rotate([90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,0,base_height]) rotate([-90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,base_size,base_height]) rotate([180,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);

    cube([base_size,base_size,base_height], center=false);

//    difference() {
//    // base
//    cube([base_size,base_size,base_height], center=false);
//    // hole
//    translate([60,60,0]) cylinder(h=base_height,d=13, d2=13);
//    }
}

//rotate_piece();
difference () {

union () {
difference () {
    translate([0,0,6]) rotate_floor(120,2,4);
    union () {

        translate([60,60,0]) rotate([0,90,0]) cylinder(h=118,d=21, center=true);
    }}

translate([60,60,0]) rotate([0,90,0])  {

    difference() {

                    cylinder(h=120,d=24, center=true);
    union() {
                    cylinder(h=120,d=21, center=true);
         translate([-13,0,0]) cube([10,25,25], center=true);
                }}}
// supports
translate([60,60,0]) rotate([0,90,0]) {
    difference() {
    translate([0,0,50]) cylinder(h=2,d=21, center=true);
    cylinder(h=120,d=10, center=true);
}
difference () {
                translate([0,0,-50]) cylinder(h=2,d=21, center=true);
                cylinder(h=120,d=10, center=true);
            }
 }

 // jupe
translate([0,120,0]) rotate([0,0,-90]) cube([120,3,6]);
cube([120,3,6]);
translate([120,0,0]) rotate([0,0,90])  cube([120,3,6]);
 translate([0,117,0]) cube([120,3,6]);
}
union () {
translate([0,0,-40]) cube([130,130,40]);
translate([120,60,0]) rotate([0,90,0]) cylinder(h=60,d=10, center=true);

}
}

module attempt_2 () {
difference () {

    union () {

        union() {
            // supports
            difference() {
                translate([0,0,50]) cylinder(h=2,d=21, center=true);
                cylinder(h=120,d=10, center=true);
            }
            difference () {
                translate([0,0,-50]) cylinder(h=2,d=21, center=true);
                cylinder(h=120,d=10, center=true);
            }
            //cylinder(h=120,d=10, center=true);

            // tunnel
            difference() {
                difference() {
                    cylinder(h=120,d=23, center=true);
                    cylinder(h=120,d=21, center=true);
                }
            // ball opening
            cube([25,25,25], center=true);

        }
        }

        // base
        difference() {
            rotate([0,90,0]) cube([120,120,4], center=true);
            cylinder(h=120,d=21, center=true);
                }
    }

translate([15,0,0]) rotate([0,90,0]) cube([140,140,30], center=true);
}

// picots

// males
translate([3,-15,0]) rotate([0,90,0]) union() {
    cylinder(h=6,d=6, center=true);
    cylinder(h=10,d=3, center=true);
}
// femelle
translate([3,15,0]) rotate([0,90,0])  difference () {
cylinder(h=6,d=6, center=true);
cylinder(h=6,d=3, center=true);
}

translate([3,50,50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,50,-50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,-50,50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,-50,-50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);

translate([3,15,0]) rotate([0,90,0])  difference () {
cylinder(h=6,d=6, center=true);
cylinder(h=6,d=3, center=true);
}


}
//rotate_piece_2(120, 20, 6);


//translate([0,0,-2]) rotate_floor(120, 4, 5);


//rotate([0,90,0]) rotate_handle(25, 25, 5, 3);

//translate([60,60,-10]) rotate_piece();



module rotate_floor_tube(base_size, main_diam) {

    difference() {
cylinder(h=base_size,d=main_diam+3, center=true);
translate([0,0,2]) cylinder(h=base_size,d=main_diam+1, center=true);
}

}
//translate([25,60,-0]) rotate([0,90,0])  rotate_floor_tube(50, 20);
//translate([95,60,-0]) rotate([0,-90,0])  rotate_floor_tube(50, 20);
