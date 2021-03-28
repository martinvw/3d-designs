width=55.8;
thickness=1.5;
radius=4.5;
height=7;
//height=2;
/* [Opening] */
hole_width=30.5;
full_open=14;
hole_height=8.5+full_open;
hole_radius=2;
hole_depth=12;
//hole_depth=0;
/* [Drill Hole] */
drill_hole_x=31.5;
drill_hole_y=41;
drill_hole_d=3;
drill_hole_sink_d=5;
drill_hole_sink_depth=1;

difference(){
    union(){
        translate([drill_hole_x,drill_hole_y,height-drill_hole_sink_depth-thickness]){
            cylinder(h=thickness, d=drill_hole_sink_d+2*thickness);
        }
        difference() {
            translate([radius, radius, 0]){
                minkowski() {
                    cube([width-2*radius,width-2*radius,height-1]);
                    cylinder(r=radius,h=1,$fn=30);
                }
            }
            translate([thickness+radius,thickness+radius,0]) {
                side = width-2*radius-(2*thickness);
                minkowski() {
                    cube([side,side,height-2-1]);
                    cylinder(r=radius,h=1);
                }
            }
            translate([16+hole_radius, 10+hole_radius, 0]){
                minkowski() {
                    cube([hole_width-2*hole_radius,hole_height-2*hole_radius,height-1]);
                    cylinder(r=hole_radius,h=1);
                }
            }
            
        }
        translate([16-thickness, 10-thickness, height-hole_depth]){
            difference() {
                cube([hole_width+2*thickness,full_open+2*thickness,hole_depth-1]);
                translate([thickness+hole_radius,thickness+hole_radius,+2]) {
                    width = hole_width-2*hole_radius;
                    height = width-2*hole_radius;
                    minkowski() {
                        cube([width,height,hole_depth-2-1]);
                        cylinder(r=hole_radius,h=1,$fn=30);
                    }
                }
            }
        }
    }
    translate([drill_hole_x,drill_hole_y,-thickness]){
        cylinder(h=height+thickness, d=drill_hole_d,$fn=30);
    }
    translate([drill_hole_x,drill_hole_y,height-drill_hole_sink_depth]){
        cylinder(h=drill_hole_sink_depth, d=drill_hole_sink_d, $fn=30);
    }
}