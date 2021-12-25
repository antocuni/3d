Basic calibration settings
--------------------------

https://all3dp.com/2/how-to-calibrate-a-3d-printer-simply-explained/

In my current setup, most of the calibration data is not stored in the printer
but inside octoprint.

Go to Settings -> GCODE Scripts -> "After connection to printer..."

    ; 2021-11-14: after installing bltouch, PLA filament
    M92 X80.04 Y79.76 Z400.80 E95.06   ; calibrate axes
    M851 Z-2.75       ; set Probe Z Offset (for BLTouch)


Use calibrate.py to get the correct M92 string.

Set Z offset (no longer needed with BLTouch):
https://www.youtube.com/watch?v=Q5M7DvdMcew

Bed leveling
-------------

**IMPORTANT**: we need to re-do bed leveling every time we change filament
because of bed temperature:

  1. find the bed temperature for the new filament
  2. go to Octoprint -> settings -> Bed visualizer
  3. find the following gode:
         M190 S60 ; waiting until the bed is fully warmed up
  4. change S60 to "S<temperature>"
  5. re-run bed leveling



Contrarily to the M92 settings, the bed leveling mesh is stored only in the
EEPROM.dat and it's automatically loaded at startup:

  - The bed leveling is off by default: you need to turn it on with M420 S1
    *AFTER* G28. Do to so you need to modify CURA

  - You can check the status by using M503

  - To create a new bed leveing, you see Bed Leveling plugin in octoprint. The
    bed leveling plugin is configured to use this GCODE:
    https://github.com/jneilliii/OctoPrint-BedLevelVisualizer/blob/master/wiki/gcode-examples.md

    However, the GCODE is customized at the end with this command:
        M500 ; by antocuni: save mesh to EEPROM.dat

    This ensures that the mesh data is saved to the EEPROM and loaded at the
    next startup

  - The bed leveling depends on the bed temperature, so it must be redone
    after changing material



Useful G-codes
--------------

https://marlinfw.org/meta/gcode/

M155 S30 Send temperature updates every 30 seconds

M503     Get Current Settings
M500     Store settings to EEPROM
M501     Load settings from EEPROM

M105     Get extruder Temperature
M114     Get Current Position
M115     Get Firmeware Version and Capabilities

M125 P1  Park & pause
G4 S60   Sleep for 60s

M92      Set Axis Steps-per-unit: M92 X79.6 Y79.6

G28      Home all axes
G28 X Y  Home only on axes X and Y

G29      Bed Leveling
M420     Get Bed Leveling State
M420 V1  Get Bed Leveling State, print also matrix
M420 S0  Disable Bed Leveling
M420 S1  Enable Bed Leveling  (put this at the beginning of gcodes)
M503     Get all settings, including bed leveling

M851               Get XYZ Probe Offset
M851 Z-2.75        Set the Probe Z Offset
M92 X79.6 Y79.6    Set steps/mm, for calibration


**NOTE** my Ender-3 Pro does NOT have an EEPROM. All the settings are saved to
EEPROM.dat in the sdcard. If the sdcard is not present, they are not
saved/loaded.

