use <shapes.scad>
use <dimensions.scad>

base_size = 120;
base_floor_thickness = 4;
base_end_floor_thickness = 5;
base_skirt_thickness = 5;
base_skirt_height = 6;
base_border_thickness = 3;

/*base_floor(120, 4, 6, 3, 6, false);*/

base_floor_v2();

module base_floor_v2() {
  difference() {
  // floor
  cube([base_size,
        base_size,
        base_floor_thickness+base_skirt_height], center=true);
  // carve skirt
  translate([0,0,-base_skirt_height/2])
  cube([base_size-base_skirt_thickness,
        base_size-base_skirt_thickness,
        base_skirt_height], center=true);
  }
  picot_male(10,10);
  picot_male(base_size-10,base_size-10);
  picot_female(base_size-10,10);
  picot_female(10,base_size-10);

}

module base_floor(base_size, base_height, corner_size,
                    skirt_wall, skirt_height, male_picot=true) {

  translate([0,0,6]) union () {

    picot_male(10,10);
    picot_male(base_size-10,base_size-10);
    picot_female(base_size-10,10);
    picot_female(10,base_size-10);

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
