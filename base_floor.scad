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

module base_floor(base_size, base_height, corner_size,
                    skirt_wall, skirt_height, male_picot=true) {

  translate([0,0,6]) union () {
    /*if (male_picot) {
      picot_male(10,10);
      picot_male(110,110);
      picot_male(110,10);
      picot_male(10,110);
    }
    else {
      picot_female(10,10);
      picot_female(110,110);
      picot_female(110,10);
      picot_female(10,110);
    }*/
      picot_male(10,10);
      picot_male(110,110);
      picot_female(110,10);
      picot_female(10,110);

    // top border
    triangle_points =[[0,0],[corner_size,0],[0,corner_size]];
    triangle_paths =[[0,1,2]];
    translate([base_size,0,base_height]) rotate([0,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([base_size,base_size,base_height]) rotate([90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,0,base_height]) rotate([-90,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);
    translate([0,base_size,base_height]) rotate([180,-90,0]) linear_extrude(base_size) polygon(triangle_points,triangle_paths,10);

    // floor
    cube([base_size,base_size,base_height], center=false);
    }
    // skirt
    translate([0,base_size,0]) rotate([0,0,-90]) cube([base_size,skirt_wall,skirt_height]);
    cube([base_size,skirt_wall,skirt_height]);
    translate([base_size,0,0]) rotate([0,0,90])  cube([base_size,skirt_wall,skirt_height]);
    translate([0,base_size-skirt_wall,0]) cube([base_size,skirt_wall,skirt_height]);

}

/*base_floor(120, 4, 6, 3, 6, false);*/
