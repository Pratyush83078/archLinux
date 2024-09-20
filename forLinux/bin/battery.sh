#!/bin/bash
# Get the laptop battery level
BATTERY_LEVEL=$(acpi -b | awk '{print $4}' | tr -d '%,' | head -n 1)

# Get Bluetooth device info (if available)
#BLUETOOTH_DEVICE_INFO=$(bluetoothctl info 2>/dev/null)

# Check if laptop battery is low and discharging
if [ "$BATTERY_LEVEL" -lt 35 ] && [ "$(acpi -b | awk '{print $3}' | tr -d ',')" = "Discharging" ]; then
    /sbin/dunstify -u critical "Vostro 3478: Battery Low" "Battery level is at $BATTERY_LEVEL%"
fi

# Check if Bluetooth battery is low (only if connected)
#if [ -n "$BLUETOOTH_BATTERY" ] && [ "$BLUETOOTH_BATTERY" -lt 50 ]; then
#    dunstify -u critical "Bluetooth Device: Battery Low" "Battery level is at $BLUETOOTH_BATTERY%"
#fi 

