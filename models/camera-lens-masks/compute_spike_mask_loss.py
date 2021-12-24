#!/usr/bin/python3
"""
Compute the equivalent F-number with the spike mask on.
"""

import math

def compute(focal_length, F_number, cross_section):
    """
    focal_length and F_number are obvious.
    
    cross_section: assuming the cross is made of two rectangles, it's the
    width of of the rectangle. I.e., in openscad one arm of the cross is made
    like this:

        cube([d, cross_section, cross_section])

    where "d" is the diameter of the lens
    """
    d = focal_length / F_number
    original_area = math.pi * (d/2)**2
    # this is slightly inaccurate because we count twice the small portion of
    # center which is shared by the two arms, but it's probably negligible
    cross_area = cross_section * d * 2
    new_area = original_area - cross_area
    equivalent_d = math.sqrt(new_area / math.pi) * 2
    return focal_length / equivalent_d


print(f'Cross  Lens   F     New F  light')
print(f'--------------------------------')

for cross_section in [1.5, 1.8, 2, 2.5, 3]:
    focal_length = 300
    F = 5.6
    new_F = compute(focal_length, F, cross_section)
    loss = (F**2 / new_F**2) * 100
    print(f'{cross_section:3.1f}    {focal_length}    {F:.1f}   {new_F:.1f}    {loss:.1f}%')

