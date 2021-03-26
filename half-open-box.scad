/*
Step 1
- basic parameters
- $fn - 200 fragments results in a smooth shape
- minkowski is creating a rounded shape, don't forget to exclude the double radius
*/

$fn=200;

// Length
length = 50;
width= 50;
height = 50;
thickness = 1;

cutout_width = 40;
cutout_height = 40;

cornerRadius = 2;

translate([-width/2, -length/2, 0]){
    difference() {
        roundedBox(length, width, height, cornerRadius); 
        translate([thickness,thickness,thickness]) {
            roundedBox(length - (thickness * 2), width - (thickness * 2), height - thickness, cornerRadius); 
        }
        translate([width/2, length/2, 0]) {
            rotate(a=[90,0,0]) {
                translate([(-cutout_width / 2), (height - cutout_height) +  cornerRadius , length / 2]) {
                    roundedBox(cutout_height + cornerRadius, cutout_width, thickness * 2, cornerRadius); 
                }
            }
        }
    }
}

module roundedBox(length, width, height, radius)
{
    dRadius = 2*radius;

    //base rounded shape
    minkowski() {
        cube(size=[width-dRadius,length-dRadius, height]);
        cylinder(r=radius, h=0.01);
    }  
}