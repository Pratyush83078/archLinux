
#!/bin/bash

# Get the current volume level using wpctl
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}' | tr -d '.' | sed 's/^0\{1,2\}//')
VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ $2 = ($2 * 100); print }')

# Get the default sink name
DEFAULT_SINK=$(pactl info | grep "Default Sink" | awk '{print $3}')
DEVICE_NAME="3"
# Extract the device name from the sink
if [[ $DEFAULT_SINK == *"bluez"* ]]; then
    DEVICE_NAME="Rockerz 550 -> "
    
else
    DEVICE_NAME="Laptop(vostro 3478) -> "
fi

BATTERY_LEVEL=$(acpi -b | awk '{print $5}' | tr -d '%,' | head -n 1)
BLUETOOTH_BATTERY=$(bluetoothctl info | grep Battery | awk '{print $4}' | tr -d '()')
# Send the notification
dunstify -a "volume" "$DEVICE_NAME" -r 1 -h int:value:"$VOLUME" -t 1000 "$VOLUME_INFO%" -i $HOME/Downloads/medium-volume.png

# Check if the battery level is below 40%
if [ "$BATTERY_LEVEL" -lt 35 ]; then
    # Send a notification using dunstify
    dunstify -u critical "$laptopBattery Low" "Battery level is at $BATTERY_LEVEL%"
fi

if [ "$(echo $BLUETOOTH_BATTERY)" -lt 80 ]; then
    # Send a notification using dunstify
    dunstify -i medium-volume.png -r 999  "$DEVICE_NAME Battery: $BLUETOOTH_BATTERY%" -t 500
fi
