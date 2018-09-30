from __future__ import division
import scad
import math


class Mirror(scad.Vector3D_SCAD_Primitive):
    SCAD_Name = "mirror"


class RotateExtrude(scad.SCAD_Primitive):
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


# h = 4  # largeur base
# h2 = 2  # largeur pres tete
# l = 25.4  # tige
# loh = 5  # longueur tete
# lah = 5  # largeur tete

eps = 0.5 * 6 / 100


def h_snap(l, y, f):
    return (1.09 / f) * (eps * pow(l, 2)) / y


def snap_h(l, y, a, b, f=1):
    # l longueur tige, sans tete
    # y epaisseur tete
    # a angle tete
    # b largeur de l'extrusion
    # f epaisseur tige

    h = h_snap(l, y, f)
    p = y

    poly = scad.Polygon(points=
                        [[0, 0],
                         [l, 0],
                         [l, y],
                         [l + p, y],
                         [l + p + (y + h / 4) / math.tan(a), -h / 4],
                         [l, -h / 2],
                         [0, -h]]
                        )
    result = scad.LinearExtrude(height=b, convexity=10, twist=0)(poly)
    return result


def y_snap(l, h, f):
    return (1.09 / f) * (eps * pow(l, 2)) / h


def snap_y(l, h, a, b, f=1):
    y = h_snap(l, h, f)
    p = y
    poly = scad.Polygon(points=
                        [[0, 0],
                         [l, 0],
                         [l, y],
                         [l + p, y],
                         [l + p + (y + h / 4) / math.tan(a), -h / 4],
                         [l, -h / 2],
                         [0, -h]]
                        )
    result = scad.LinearExtrude(height=b, convexity=10, center=f, twist=0)(poly)
    return result


def out_r_snap(l, h, a, Lobi, r2, f=1, K2=2):
    Theta = 180.0 / Lobi
    y = (1.64 / f) * K2 * (eps * pow(l, 2)) / r2
    p = y

    if (r2 - h) > y and (h < r2):
        snaps = []

        for f in range(Lobi):
            points = [
                [0, 0],
                [l, 0],
                [l, y],
                [l + p, y],
                [l + p + (y + h / 4) / math.tan(a), -h / 4],
                [l, -h / 2],
                [0, -h]]
            poly = scad.Polygon(points=points)
            snap = scad.Rotate([0, 0, Theta * 2 * f])(
                RotateExtrude(angle=Theta,
                              convexity=2,
                              fn=150)(
                    scad.Translate([r2, 0, 0])(
                        Mirror([1, -1, 0])(
                            poly
                        )
                    )
                )
            )
            snaps.append(snap)
    return scad.Union()(snaps)


def in_r_snap(l, h, a, Lobi, r2, f=1, K1=2):
    Theta = 180.0 / Lobi
    y = (1.64 / f) * K1 * (eps * pow(l, 2)) / r2
    p = y

    if y < r2:
        snaps = []

        for f in range(Lobi):
            points = [
                [0, 0],
                [l, 0],
                [l, y],
                [l + p, y],
                [l + p + (y + h / 4) / math.tan(a), -h / 4],
                [l, -h / 2],
                [0, -h]]
            poly = scad.Polygon(points=points)
            snap = scad.Rotate([0, 180, Theta * 2 * f])(
                RotateExtrude(angle=Theta,
                              convexity=2,
                              fn=150)(
                    scad.Translate([r2, 0, 0])(
                        Mirror([1, 1, 0])(
                            poly
                        )
                    )
                )
            )
            snaps.append(snap)
    return scad.Union()(snaps)


border = snap_h(l=15, y=5, a=7, b=10, f=1)

# y et b definissent la surface visible apres accroche




snaps = out_r_snap(l=10, h=2, a=30,
                   Lobi=4, r2=20, K2=3)
# border = in_r_snap(l=8, h=1, a=35,
#                     Lobi=3, r2=10, K1=2)

border = scad.Difference()(
    scad.Cylinder(r=20, h=16, fn=100),
    scad.Translate(z=2)(scad.Cylinder(r=18, h=16)))

box = scad.Union()(
    [scad.Translate(z=16)(snaps),
     border]
)

box.render("helix.scad")
