#!/bin/bash

# Get the maximum brightness value
MAX_BRIGHTNESS=$(brightnessctl max)

# Function to get the current brightness percentage
get_brightness_percentage() {
    CURRENT_BRIGHTNESS=$(brightnessctl get)
    echo $((CURRENT_BRIGHTNESS * 100 / MAX_BRIGHTNESS))
}

case "$1" in
    up)
        # Increase brightness by 10%
        brightnessctl set +10%
        NEW_BRIGHTNESS_PERCENTAGE=$(get_brightness_percentage)
        dunstify "Brightness: ${NEW_BRIGHTNESS_PERCENTAGE}%"
        ;;
    down)
        # Decrease brightness by 10%
        brightnessctl set 10%-
        NEW_BRIGHTNESS_PERCENTAGE=$(get_brightness_percentage)
        dunstify "Brightness: ${NEW_BRIGHTNESS_PERCENTAGE}%"
        ;;
    toggle)
        # Toggle between 0% and 100% brightness
        CURRENT_BRIGHTNESS_PERCENTAGE=$(get_brightness_percentage)
        if [ "$CURRENT_BRIGHTNESS_PERCENTAGE" -eq 0 ]; then
            brightnessctl set 100%
            dunstify "Brightness: 100%"
        else
            brightnessctl set 0%
            dunstify "Brightness: 0%"
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|toggle}"
        exit 1
        ;;
esac
