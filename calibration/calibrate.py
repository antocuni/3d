# CURRENT BEST SETTINGS:
#   X = 79.6 steps/mm
#   Y = 79.6 steps/mm
#   Z = 400 (default)

# https://all3dp.com/2/how-to-calibrate-a-3d-printer-simply-explained/

steps_per_mm = 79.2
exp_X = 20
X = 19.9

print(exp_X * steps_per_mm / X)

# Z offset
#https://www.youtube.com/watch?time_continue=155&v=Q5M7DvdMcew&feature=emb_title&ab_channel=RemainIndoors

"""
Useful G-codes
https://marlinfw.org/docs/gcode/


M125 P1   # park & pause
G4 S60    # sleep for 60s
M114      # get current position
M503      # get current settings
M500      # save settings to EPROM
M501      # load settings from EPROM

M92 X79.6 Y79.6   # set steps/mm
"""
