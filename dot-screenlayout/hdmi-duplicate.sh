#!/bin/sh
xrandr --output HDMI-0 --auto --scale-from 1920x1200 --output DP-4
xrandr --output DP-2.1 --off --output DP-2.2 --off --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-4 --mode 1920x1200 --pos 0x0 --rotate normal --output DP-5 --off --output DP-6 --off
sleep 5
nitrogen --restore
i3 restart
