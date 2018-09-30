from scad.core import SCAD_Object
from scad import Cylinder
from scad import Cube
from scad import Sphere
from scad import Polygon
from scad import Difference, Union, Translate, Rotate
from scad import Minkowski, Scale
from scad import LinearExtrude
from scad import R


class Base(SCAD_Object):
    Defaults = {
        "size": {"type": float, "default": 20},
        "height": {"type": float, "default": 5},
        "thickness": {"type": float, "default": 2},
    }

    def scad(self):
        main = Cube(size=[self.size,
                          self.size,
                          self.height],
                    # background=True,
                    # debug=True,
                    center=True)
        skirt = Cube(size=[self.size - self.thickness,
                           self.size - self.thickness,
                           self.height],
                     # background=True,
                     # debug=True,
                     center=True)
        skirt = Translate(z=-self.thickness / 2)(skirt)
        base = Difference()([main, skirt])

        border_thickness = self.thickness / 2
        points = [[0, 0], [0, border_thickness], [border_thickness, border_thickness]]
        border = LinearExtrude(h=self.size, center=True,
                               debug=False)(Polygon(points=points))
        border_1 = Translate(x=-self.size / 2 + border_thickness,
                             z=self.height / 2)(
            Rotate(x=90, y=-90)(border))
        border_2 = Rotate(z=90)(border_1)
        border_3 = Rotate(z=180)(border_1)
        border_4 = Rotate(z=270)(border_1)
        result = Union()([base,
                          border_1,
                          border_2,
                          border_3,
                          border_4
                          ])
        return result


def render_base():
    base = Base(size=30, height=5, thickness=3)
    base.render("helix.scad")


render_base()
