#!/bin/bash

# Get the current brightness level using brightnessctl
CURRENT_BRIGHTNESS=$(brightnessctl g)

# Get the maximum brightness level using brightnessctl
MAX_BRIGHTNESS=$(brightnessctl m)

# Calculate the brightness percentage
BRIGHTNESS_PERCENTAGE=$(echo "scale=2; ($CURRENT_BRIGHTNESS / $MAX_BRIGHTNESS) * 100" | bc)

# Send the notification using dunstify
dunstify -a "brightness" -u low -r "2" -t 500 -h string:x-dunst-stack-tag:brightness "Brightness: $BRIGHTNESS_PERCENTAGE%"
