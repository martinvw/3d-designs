// Door open holder (C) by Joachim Eibl 2013
// Licence: CC BY-NC-SA 3.0
// Creative Commons: attribution, non commercial, share alike
// See: http://creativecommons.org/licenses/by-nc-sa/3.0/

// preview[view:north, tilt:bottom diagonal]

// Total length of base plate
length = 80;

// Width of base plate
width = 20;

// Thickness of the base plate
thickness = 5;

// Cut Off Angle [0-90]; 45° for auto slip on/off, 90° (max)
cutOffAngle = 90; 

// Diameter of door handle
diameterDoorHandle = 17;

/* [Advanced] */

// Quality of rendered design [20 - 100]
quality = 50;

rs = thickness / 2;
radiusDoorHandle = diameterDoorHandle / 2;
yOffset = length / 2 - 5;

module profile()
{
    translate([ rs, 0, 0 ]) circle(r = rs, $fn = quality);
    translate([ width - rs, 0, 0 ]) circle(r = rs, $fn = quality);
    translate([ rs, -rs ]) square([ width - 2 * rs, thickness ]);
}

module roundedHalfBox()
{
    translate([ rs, rs, rs ]) sphere(r = rs, $fn = quality);
    translate([ rs, length - rs, rs ]) sphere(r = rs, $fn = quality);
    translate([ rs, length - rs, width - rs ]) sphere(r = rs, $fn = quality);
    translate([ rs, rs, width - rs ]) sphere(r = rs, $fn = quality);

    difference()
    {
        union()
        {
            translate([ 0, rs, 0 ])
                cube([ thickness - rs, length - 2 * rs, width ]);
            translate([ 0, 0, rs ])
                cube([ thickness - rs, length, width - 2 * rs ]);
            translate([ 0, rs, rs ])
                cube([ thickness, length - 2 * rs, width - 2 * rs ]);
        }

        if (width > 8) {
            translate([ thickness, length / 4 - 2 * rs, width / 2 ])
                rotate([ 0, 270, 0 ])
                    screw_countersunk(l = thickness, ds = 3.5, dh = 8);

            translate([ thickness, length / 4 * 3 + 2 * rs, width / 2 ])
                rotate([ 0, 270, 0 ]) 
                    screw_countersunk(l = thickness);
        }
    }

    translate([ 0, length - rs, rs ]) rotate([ 0, 90, 0 ])
        cylinder(h = rs, r = rs, $fn = quality);
    translate([ 0, rs, rs ]) rotate([ 0, 90, 0 ])
        cylinder(h = rs, r = rs, $fn = quality);
    translate([ 0, rs, width - rs ]) rotate([ 0, 90, 0 ])
        cylinder(h = rs, r = rs, $fn = quality);
    translate([ 0, length - rs, width - rs ]) rotate([ 0, 90, 0 ])
        cylinder(h = rs, r = rs, $fn = quality);

    translate([ rs, rs, rs ]) rotate([ 0, 0, 0 ])
        cylinder(h = width - 2 * rs, r = rs, $fn = quality);
    translate([ rs, length - rs, rs ]) rotate([ 0, 0, 0 ])
        cylinder(h = width - 2 * rs, r = rs, $fn = quality);

    translate([ rs, rs, rs ]) rotate([ -90, 0, 0 ])
        cylinder(h = length - 2 * rs, r = rs, $fn = quality);
    translate([ rs, rs, width - rs ]) rotate([ -90, 0, 0 ])
        cylinder(h = length - 2 * rs, r = rs, $fn = quality);
}

module roundedBox(h, d, radius)
{
    translate([ 0, radius, radius ]) sphere(r = radius, $fn = 100);

    translate([ 0, h - radius, d - radius ]) sphere(r = radius, $fn = 100);

    translate([ 0, radius, radius ])
        cylinder(h = d - 2 * rs, r = radius, $fn = 100);
}


// Based on: https://gist.github.com/Stemer114/af8ef63b8d10287c825f
module screw_countersunk(l = 20,   // length
                         dh = 6,   // head dia
                         lh = 3,   // head length
                         ds = 3.2, // shaft dia
)
{
    union()
    {
        cylinder(h = lh, r1 = dh / 2, r2 = ds / 2, $fn = quality);
        rotate([ 0, 0, 180 ])
            cylinder(h = l, d = ds, $fn = quality);
    }
}

rotate([ 0, -90, 0 ])
{
    translate([ 0, -yOffset, -0 ]) roundedHalfBox();

    translate([ thickness + radiusDoorHandle, -thickness, 0 ])
        rotate([ 0, 0, -cutOffAngle ]) 
            translate([ 0, radiusDoorHandle, 0 ])
                roundedBox(thickness, width, rs);

    difference()
    {
        union()
        {

            difference()
            {
                translate([ 0, -thickness, 0 ]) cube([
                    radiusDoorHandle + thickness,
                    2 * radiusDoorHandle + thickness,
                    width
                ]);
                union()
                {
                    translate([
                        thickness + radiusDoorHandle,
                        2 * radiusDoorHandle,
                        -1
                    ]) cylinder(h = width + 2,
                                r = radiusDoorHandle + rs,
                                $fn = quality);
                    translate([ thickness + radiusDoorHandle, -thickness, -1 ])
                        cylinder(h = width + 2,
                                 r = radiusDoorHandle + rs,
                                 $fn = quality);
                }
            }
            // upper radius (for smooth touch)
            difference()
            {
                translate(
                    [ thickness + radiusDoorHandle, 2 * radiusDoorHandle, 0 ])
                    rotate_extrude($fn = quality)
                        translate([ radiusDoorHandle + rs, 0, 0 ])
                            rotate([ 0, 0, 90 ]) profile();
                union()
                {
                    translate([
                        thickness + radiusDoorHandle,
                        radiusDoorHandle - thickness,
                        -1
                    ])
                        cube([
                            radiusDoorHandle + thickness,
                            radiusDoorHandle + thickness + 1,
                            width + 2
                        ]);
                    translate([ 1, 2 * radiusDoorHandle, -1 ]) cube([
                        2 * (radiusDoorHandle + thickness),
                        radiusDoorHandle + thickness + 1,
                        width + 2
                    ]);
                }
            }
            difference()
            {
                translate([ thickness + radiusDoorHandle, -thickness, 0 ])
                    rotate_extrude($fn = quality)
                        translate([ radiusDoorHandle + rs, 0, 0 ])
                            rotate([ 0, 0, 90 ]) profile();
                translate([ 1, -(radiusDoorHandle + 2 * thickness + 2), -1 ])
                    cube([
                        2 * (radiusDoorHandle + thickness),
                        radiusDoorHandle + thickness + 2,
                        width + 2
                    ]);
            }
        }
        translate([ thickness + radiusDoorHandle, -thickness, -1 ])
            rotate([ 0, 0, -cutOffAngle ]) cube([
                radiusDoorHandle + thickness,
                radiusDoorHandle + thickness,
                width + 2
            ]);
    }
}