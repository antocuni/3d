#!/usr/bin/python3
from dataclasses import dataclass

# Default Ender 3 Pro settings:
#   X =  80 steps/mm
#   Y =  80 steps/mm
#   Z = 400 steps/mm
#   E =  93 steps/mm

# current settings (use M92 to get)
CURRENT_STEPS_PER_MM = Vector(79.6, 79.6, 400)
CURRENT_STEPS_PER_MM_E = 93.0

@dataclass
class Vector:
    x: float
    y: float
    z: float

def calib(current, expected, measured):
    """
    Compute the new value for steps_per_mm
    """
    return current * expected / measured

def calibrate_axes():
    steps_per_mm = CURRENT_STEPS_PER_MM
    expected = Vector(20, 20, 20)    # standard calibration cube
    measured = Vector(20, 20, 20)
    #
    sx = calib(steps_per_mm.x, expected.x, measured.x)
    sy = calib(steps_per_mm.y, expected.y, measured.y)
    sz = calib(steps_per_mm.z, expected.z, measured.z)
    return Vector(sx, sy, sz)

def calibrate_extruder():
    # to calibrate the extruder:
    #    1. put a mark in the filament
    #    2. measure the distance to the mark
    #    3. extrude 10mm
    #    4. repeat 2-3 until the mark is visible
    #
    # The more measures we take, the more accurate it will be because we
    # average them.
    measures = [71.86, 62.74, 52.83, 42.79, 32.73, 23.10, 13.16]
    extrusions = []
    for i in range(len(measures)-1):
        e = measures[i] - measures[i+1]
        #print(e)
        extrusions.append(e)
    avg = sum(extrusions) / len(extrusions)
    steps_per_mm = CURRENT_STEPS_PER_MM_E
    expected = 10
    measured = avg
    return calib(steps_per_mm, expected, measured)

def main():
    v = calibrate_axes()
    e = calibrate_extruder()
    print(f'New steps_per_mm (axes):     {v}')
    print(f'New steps_per_mm (extruder): {e}')
    print(f'M92 X{v.x:.2f} Y{v.y:.2f} Z{v.z:.2f} E{e:.2f}')

if __name__ == '__main__':
    main()
