import scad
from scad.core import SCAD_Primitive

class RotateExtrude(SCAD_Primitive):
    SCAD_Name = "rotate_extrude"
    Defaults = {
        "angle": {"type": float, "default": 360},
        "convexity": {"type": int, "default": None},
        "fn": {"type": float, "default": 20},
    }

    def get_scad_args(self):
        args = [("angle", self.angle)]
        args.append(("$fn", self.fn))
        if self.convexity is not None:
            args.append(("convexity", self.convexity))
        return args

class Mirror(scad.Vector3D_SCAD_Primitive):
    SCAD_Name = "mirror"


