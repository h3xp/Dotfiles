#!/bin/bash
brightness=$(cat /sys/class/backlight/nvidia_0/actual_brightness)
brightness=$((brightness * 10))
action=$1
if [[ "$action" = "up" ]]
then
    brightness=$((brightness + 10))
else
    if [[ "$brightness" < 10 ]]
    then
        brightness=0
    else
        brightness=$((brightness - 10))
    fi
fi
notify-send "brightness" -h int:value:$brightness