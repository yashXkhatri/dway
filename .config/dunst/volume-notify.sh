#!/bin/bash

# Get the current volume percentage
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
# Get the current mute status
MUTE_STATUS=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

case "$1" in
    up)
        # Increase volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ +5%
        NEW_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
        dunstify "Volume: ${NEW_VOLUME}"
        ;;
    down)
        # Decrease volume by 5%
        pactl set-sink-volume @DEFAULT_SINK@ -5%
        NEW_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')
        dunstify "Volume: ${NEW_VOLUME}"
        ;;
    mute)
        if [ "$MUTE_STATUS" = "yes" ]; then
            # If muted, unmute and notify
            pactl set-sink-mute @DEFAULT_SINK@ 0
            dunstify "Volume: Unmuted"
        else
            # If unmuted, mute and notify
            pactl set-sink-mute @DEFAULT_SINK@ 1
            dunstify "Volume: Muted"
        fi
        ;;
    *)
        echo "Usage: $0 {up|down|mute}"
        exit 1
        ;;
esac
