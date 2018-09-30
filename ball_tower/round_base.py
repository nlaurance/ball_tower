import scad

border_thickness = -3
points = [[0, 0],
          [0, border_thickness],
          [border_thickness, border_thickness]]
border = RotateExtrude(fn=50)(
    scad.Translate(x=20)(
        scad.Polygon(points=points)))
border = scad.Translate(z=-border_thickness + 4 / 2)(border)

base = scad.Cylinder(r=20, h=4, center=True)
base = scad.Difference()(
    base,
    scad.Translate(z=-2)(scad.Cylinder(r=18, h=4, center=True,
                                       debug=False)))
# border=scad.Translate(x=-20)(
#         scad.Polygon(points=points))

result = scad.Union()([base, border])
result.render("helix.scad")
