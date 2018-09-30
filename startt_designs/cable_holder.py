import scad

base_plate = scad.Translate(x=-39.7 / 2.0)(
    scad.Difference()(

    )(scad.Hull()([
        scad.Cylinder(d=14, h=3, center=True),
        scad.Translate(x=39.7)(scad.Cylinder(d=14, h=3, center=True))
    ]),

        scad.Union()([
            scad.Cylinder(d=3, h=5, center=True, fn=40),
            scad.Translate(x=39.7)(scad.Cylinder(d=3, h=5, center=True, fn=40))
        ])
    ))

scad.Rotate(x=90)()
scad.Translate(y=-15)()

hauteur= 20

from ball_tower.gauss import prepare_bezier_poly
path = [
    ((-10, 0), 0),
    ((-5, 15), 15),
    ((0, hauteur), 0),
]
points = prepare_bezier_poly(path)
points.append((0, 0))
arch = scad.LinearExtrude(height=14)(
    scad.Polygon(points=points))
arch = scad.Rotate(x=90)(arch)
arch = scad.Translate(x=-6, y=7, z=1.5)(arch)

from cantilever import Mirror
arch2 = Mirror(x=1)(arch)

passage = scad.Translate(z=1.5+hauteur/2.0)(
    scad.Cube(x=12, y=14, z=hauteur,
              center=True))

passage = scad.Union()([arch, arch2, passage])
passage = scad.Difference()(
    passage,
    scad.Translate(z=10)(
        scad.Rotate(x=90)(
        scad.Cylinder(r=8, h=30, center=True, fn=50,
                      debug=False)))
)

# arch = scad.Rotate(x=90)(scad.Difference()(
#     scad.Cylinder(d=35, h=14, center=True),
#     scad.Cylinder(d=31, h=30, center=True)
# ))
#
# arch = scad.Difference()(
#     arch,
#     scad.Translate(z=-20)(scad.Cube(40, center=True, ))
# )

result = scad.Union()([
    base_plate, passage
])
result.render("helix.scad")
