#!/bin/bash
# Get the current volume level using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | tr -d '.')
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ $2 = ($2 * 100); print }')

BATTERY_LEVEL=$(acpi -b | awk '{print $4}' | tr -d '%,' | head -n 1)
BLUETOOTH_BATTERY=$(bluetoothctl info | grep Battery | awk '{print $4}' | tr -d '()')

# Get the default sink name
DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Extract the device name from the sink
if [[ $DEFAULT_SINK == *"bluez"* ]]; then
    DEVICE_NAME="Rockerz 550 ($BLUETOOTH_BATTERY) -> "
else
    DEVICE_NAME="Laptop(vostro 3478) $BATTERY_LEVEL -> "
fi

dunstify -a "volume" "$DEVICE_NAME" -r 1 -h int:value:"$VOLUME" -t 1000 "$VOLUME_INFO%" -i $HOME/Downloads/medium-volume.png



# Send the notification

# Check if the battery level is below 40%
if [ "$BLUETOOTH_BATTERY" -lt 50 ]; then
    dunstify -u critical "$DEVICE_NAME Battery Low" "Battery level is at $BLUETOOTH_BATTERY% :-"
fi

