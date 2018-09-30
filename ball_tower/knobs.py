from scad.core import SCAD_Object
from scad import Cylinder
from scad import Cube
from scad import Sphere
from scad import Difference, Union, Translate, Rotate
from scad import Minkowski, Scale


class Shaft(SCAD_Object):
    Defaults = {
        # "diameter": {"type": float, "default": 1},
        "length": {"type": float, "default": 1},
        "connector": {"type": float, "default": 1},
    }

    def scad(self):
        plug = Cube(size=self.connector,
                    # debug=True,
                    center=True)
        plugs = []
        plug_offset = (self.connector + self.length) / 2
        plugs.append(Translate(z=plug_offset)(plug))
        plugs.append(Translate(z=-plug_offset)(plug))

        rod = Cylinder(diameter=self.diameter,
                       height=self.length,
                       center=True,
                       # debug=True,
                       fn=self.fn)
        return Union()([rod] + plugs)


class Handle_1(SCAD_Object):
    Defaults = {
        "diameter": {"type": float, "default": 1},
        "height": {"type": float, "default": 1},
    }
    Aliases = {
        'd': 'diameter',
        'h': 'height'
    }

    def scad(self):
        cyl_diam = self.diameter * 1.4
        cut = Cylinder(diameter=cyl_diam,
                       height=self.height + 2,
                       center=True,
                       # debug=True,
                       fn=self.fn)
        cuts = []
        cut_offset = .8 * cyl_diam
        cuts.append(Translate(x=cut_offset)(cut))
        cuts.append(Translate(x=-cut_offset)(cut))
        cuts.append(Translate(y=cut_offset)(cut))
        cuts.append(Translate(y=-cut_offset)(cut))
        cuts = Union()(cuts)

        main = Cube(size=[self.diameter,
                          self.diameter,
                          self.height],
                    # background=True,
                    # debug=True,
                    center=True)

        result = Difference()([main, cuts])
        smooth_radius = 1
        result = Minkowski()(result,
                             Sphere(dia=smooth_radius,
                                    fn=20))
        result = Scale([
            self.diameter / (self.diameter + smooth_radius),
            self.diameter / (self.diameter + smooth_radius),
            self.height / (self.height + smooth_radius),
        ])(result)

        plug_size = 5
        shaft_plug = Cube(plug_size, center=True,
                          # debug=True,
                          # background=True
                          )
        plug_trans = (self.height - plug_size) / 2
        shaft_plug = Translate(z=plug_trans)(shaft_plug)

        result = Difference()([result,
                               shaft_plug])
        return result


def render_handle_1():
    handle = Handle_1(d=20, h=10, fn=20)
    # handle.render("handle.scad")
    # handle.render("handle.png")

    shaft = Shaft(connector=5,
                  diameter=8,
                  length=40, fn=50)

    shaft = Rotate(x=90)(shaft)
    handle = Translate(y=-35)(Rotate(x=-90)(handle))
    design = Union()(handle, shaft)

    design.render("helix.scad")


class RotationKnob(SCAD_Object):
    Defaults = {
        "diameter": {"type": float, "default": 1},
        "height": {"type": float, "default": 1},
    }

    def scad(self):
        main = Cylinder(diameter=self.diameter,
                        height=self.height,
                        center=True,
                        # debug=True,
                        fn=self.fn)

        grip_count = 30
        grip_diam = self.diameter / 9
        grips = [
            Rotate(z=(360.0/grip_count) * i)(
                Translate(x=self.diameter / 2)(
                    Cylinder(diameter=grip_diam,
                             height=self.height,
                             center=True,
                             fn=self.fn,
                             debug=False)
                )
            )
            for i in range(grip_count)
        ]
        result = Union()(main, *grips)

        plug_size = 5
        shaft_plug = Cube(plug_size, center=True,
                          # debug=True,
                          # background=True
                          )
        plug_trans = (self.height - plug_size) / 2
        shaft_plug = Translate(z=plug_trans)(shaft_plug)

        result = Difference()([result,
                               shaft_plug])

        return result

def render_rotation_knob():
    knob = RotationKnob(d=30, h=20, fn=30)

    design = knob
    design.render("rotation.scad")
    design.render("rotation.stl")

render_rotation_knob()


class PushPullKnob(SCAD_Object):
    Defaults = {
        "diameter": {"type": float, "default": 1},
        "height": {"type": float, "default": 1},
    }

    def scad(self):
        main = Cube(size=[self.diameter,
                          self.diameter,
                          self.height],
                    # background=True,
                    # debug=True,
                    center=True)

        cut = Cylinder(diameter=self.height*.8,
                       height=self.diameter+2,
                       center=True,
                       # debug=True,
                       fn=self.fn)
        cuts = []
        offset = 1.2 * self.diameter/2
        cuts.append(Translate(x=offset)(Rotate(x=90)(cut)))
        cuts.append(Translate(x=-offset)(Rotate(x=90)(cut)))
        cuts.append(Translate(y=offset)(Rotate(y=90)(cut)))
        cuts.append(Translate(y=-offset)(Rotate(y=90)(cut)))
        cuts = Union()(cuts)
        result = Difference()([main, cuts])

        smooth_radius = 1
        result = Minkowski()(result,
                             Sphere(dia=smooth_radius,
                                    fn=20))

        result = Scale([
            self.diameter / (self.diameter + smooth_radius),
            self.diameter / (self.diameter + smooth_radius),
            self.height / (self.height + smooth_radius),
        ])(result)

        plug_size = 5
        shaft_plug = Cube(plug_size, center=True,
                          # debug=True,
                          # background=True
                          )
        plug_trans = (self.height - plug_size) / 2
        shaft_plug = Translate(z=plug_trans)(shaft_plug)

        result = Difference()([result,
                               shaft_plug])

        return result

def render_push_knob():
    knob = PushPullKnob(d=30, h=20, fn=30)

    design = knob
    design.render("push_pull.stl")
    design.render("push_pull.scad")

render_push_knob()
