In my current setup, the calibration data is not stored in the printer but
inside octoprint.

Go to Settings -> GCODE Scripts -> "After connection to printer..."

    ; 2021-11-14: after installing bltouch, PLA filament
    M92 X79.6 Y79.6   ; calibrate axis steps
    M851 Z-2.75       ; set Probe Z Offset (for BLTouch)
