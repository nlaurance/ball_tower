from __future__ import division
from itertools import tee
import scad


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def bezier(A, B, C, t):
    """A B and C being 2-tuples, t being a float between 0 and 1"""
    x = (1 - t) ** 2 * A[0] + 2 * t * (1 - t) * B[0] + t ** 2 * C[0]
    y = (1 - t) ** 2 * A[1] + 2 * t * (1 - t) * B[1] + t ** 2 * C[1]
    return x, y


def intersect(A, sa, B, sb):
    """sa slope in A"""

    a0 = A[1] - sa * A[0]
    b0 = B[1] - sb * B[0]

    x = (b0 - a0) / (sa - sb)
    y = sa * x + a0
    return x, y


def prepare_bezier_poly(path, steps=10):
    points = []
    for start, end in pairwise(path):
        start, start_slope = start
        end, end_slope = end
        middle = intersect(start, start_slope,
                           end, end_slope)
        print(start)
        print(middle)
        print(end)
        t = 0
        while t < 1:
            points.append(bezier(start, middle, end, t))
            t += 1 / steps
    return points


path = [
    ((-10, 0), 0),
    ((-5, 15), 15),
    ((0, 30), 0),
]
points = prepare_bezier_poly(path)
points.append((0, 0))
scad.Polygon(points=points).render("helix.scad")
