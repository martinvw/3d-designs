height = 15;


difference() {
    union(){
        translate([0,22,0]) {
            cube([43,35,height]);
        }
        polyhedron(
           points=[[0,57,0], [21.5,57,0], [21.5,104,0], [21.5,104,height], [0,57,height], [21.5,57,height]],
           faces=[[2,0,1], [4,5,1,0], [1,5,3,2], [3,5,4], [0,2,3,4]]
        );
        polyhedron(
           points=[[43,57,0], [21.5,57,0], [21.5,104,0], [21.5,104,height], [43,57,height], [21.5,57,height]],
           faces=[[1,0,2], [0,1,5,4], [2,3,5,1], [4,5,3], [4,3,2,0]]
        );
        translate([21.5,22,0]) {
            cylinder(h=height, r=21.5, $fn=50);
        }
    }
    translate([0, 44, 0]) {
        translate([20,0,0]) {
            cube([3, 70, (height/2) + 2]);
        }
        translate([0,-4,(height/2)]) {
            cube([45, 70, 2.5]);
            translate([0,-7,0]) {
                cube([17, 22, 2.5]);
            }
            translate([0,-11,0]) {
                cube([12, 22, 2.5]);
            }
        }
    }
    translate([21.5,16,0]) {
        cylinder(h=height, d=14, $fn=50);
    }
    translate([0,54,0]) {
        translate([12,0,0]) {
            cylinder(h=height, d=4.2, $fn=50);
            nut_trap(w = 7, h = 3.7);
        }
        translate([31,0,0]) {
            cylinder(h=height, d=4.2, $fn=50);
            nut_trap(w = 7, h = 3.7);
        }
    }
    translate([0,70,(height/2)]) {
        cube([45, 45, 10]);
    }
}
module nut_trap (
        w = 5.5,
        h = 3
        )
{
        cylinder(r = w / 2 / cos(180 / 6) + 0.05, h=h, $fn=6);
} 