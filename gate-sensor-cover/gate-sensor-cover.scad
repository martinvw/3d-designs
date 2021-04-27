inner_width=72.5;
inner_depth=82.5;
default_hull_width=1;
box_height=65;
height=133;
width=inner_width+2*default_hull_width;
depth=inner_depth+2*default_hull_width;
cylinder_inner_d1=27*2;
cylinder_d1=cylinder_inner_d1+(2*default_hull_width);
cylinder_inner_d2=inner_width;
cylinder_d2=width;
hole_width=57;
hole_height=63; // could also be 57

difference()
{
    union(){
        translate([-default_hull_width, -default_hull_width, 0]){
            translate([0, 0, -(height-box_height)]){
                difference(){
                    translate([(inner_width/2)+default_hull_width, depth-default_hull_width,0]){
                        scale([1, cylinder_d1/cylinder_d2, 1]){
                            cylinder(d=cylinder_d2, h=height-box_height, $fn=90);
                        }
                    }
                    cube([width,depth,height-box_height]);
                }
            }
            cube([
                width,
                depth,
                box_height + default_hull_width]
            );
            polyhedron(
                [
                    [0,0,0],
                    [width, 0, 0],
                    [width, depth, 0],
                    [0, depth, 0], 
                    [width, depth, box_height - height],
                    [0, depth, box_height - height] 
                ], [
                    [0, 3, 2, 1],
                    [0, 1, 4, 5],
                    [0, 5, 3],
                    [1, 2, 4],
                    [2, 3, 5, 4]
                ]
            );
            
        }
        
        
    }
    union(){
        translate([(inner_width/2), depth-2*default_hull_width,-(height-box_height+default_hull_width)]){
            scale([1, cylinder_d1/cylinder_d2, 1]){
                cylinder(d=cylinder_inner_d2, h=height-box_height, $fn=90);
            }
        }
        translate([0, 0, -(height-box_height)]){
            cube([inner_width,inner_depth,height]);
        }
        translate([(width-hole_width)/2-default_hull_width, -default_hull_width, -default_hull_width]){
            cube([hole_width, 5, hole_height]);
        }
    }
}