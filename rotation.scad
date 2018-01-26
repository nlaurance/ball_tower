
$fa=1;
$fn=80;

include <base_floor.scad>


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
    // ball catch
    cylinder(h=20,d=main_diam, center=true);
    translate([main_diam/4,0,0]) rotate([0,90,0])
    cylinder(h=main_diam/2,d=11, d2=13,center=true);
    sphere(d=11);
  }
}


//rotate_piece();

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

translate([3,50,50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,50,-50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,-50,50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);
translate([3,-50,-50]) rotate([0,90,0]) cylinder(h=6,d=6, center=true);

translate([3,15,0]) rotate([0,90,0])  difference () {
cylinder(h=6,d=6, center=true);
cylinder(h=6,d=3, center=true);
}


}



module rotate_floor_tube(base_size, main_diam) {

    difference() {
cylinder(h=base_size,d=main_diam+3, center=true);
translate([0,0,2]) cylinder(h=base_size,d=main_diam+1, center=true);
}

}


module what() {
  difference () {

    union () {
      difference () {
        translate([0,0,0]) base_floor(120, 4, 6, 3, 6, false);
        union () {
          translate([60,60,0]) rotate([0,90,0]) cylinder(h=118,d=21, center=true);
          }
        }

      // tunnel roof, could be replaced by a tube call
      translate([60,60,0]) rotate([0,90,0])  {
        difference() {
          cylinder(h=120,d=24, center=true);
          union() {
            cylinder(h=122,d=21, center=true);
            // opening in roof
            translate([-13,0,0]) cube([10,25,25], center=true);
            }
          }
        }

      // supports
      translate([60,60,0]) rotate([0,90,0]) {
        difference() {
          translate([0,0,14]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
        }
        difference () {
          translate([0,0,-14]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
        difference () {
          translate([0,0,58]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
        difference () {
          translate([0,0,-58]) cylinder(h=2,d=21, center=true);
          cylinder(h=120,d=10, center=true);
          }
      }
  }
  union () {
    // cut in half
    translate([0,0,-40]) cube([130,130,40]);
    // hole for shaft in base skirt
    translate([120,60,0]) rotate([0,90,0]) cylinder(h=60,d=10, center=true);
    }
  }
}
/*what();*/
difference () {
color(yellow, 0.75) rotate_piece_2(20,25,10);
translate([15,0,0]) cube([10,25,25], center=true);
}
