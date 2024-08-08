#!/bin/bash

# Get the current volume level using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | tr -d '.')
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ $2 = ($2 * 100); print }')

# Get the default sink name
DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Extract the device name from the sink
if [[ $DEFAULT_SINK == *"bluez"* ]]; then
    DEVICE_NAME="Rockerz 550 -> "
else
    DEVICE_NAME="Laptop(vostro 3478) -> "
fi

BATTERY_LEVEL=$(acpi -b | awk '{print $4}' | tr -d '%,' | head -n 1)
BLUETOOTH_BATTERY=$(bluetoothctl info | grep Battery | awk '{print $4}' | tr -d '()')

# Send the notification
dunstify -a "volume" "$DEVICE_NAME" -r 1 -h int:value:"$VOLUME" -t 1000 "$VOLUME_INFO%" -i $HOME/Downloads/medium-volume.png

# Check if the battery level is below 40%
if [ $BATTERY_LEVEL -lt 35 ] && [ "$(echo $(acpi -b | awk '{print $3}' | tr -d ','))" == "Discharging" ]; then
    # Send a notification using dunstify
    dunstify -u critical "Vostro 3478: Battery Low" "Battery level is at $BATTERY_LEVEL% :-"
fi

if [ "$BLUETOOTH_BATTERY" -lt 60 ]; then
    dunstify -u critical "$DEVICE_NAME Battery Low" "Battery level is at $BLUETOOTH_BATTERY% :-"
fi
