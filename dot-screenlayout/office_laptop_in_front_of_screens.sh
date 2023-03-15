#!/bin/sh
xrandr --output DP-2.1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2.2 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output HDMI-0 --off --output DP-4 --mode 1920x1200 --pos 0x1080 --rotate normal --output DP-5 --off --output DP-6 --off
sleep 5
nitrogen --restore
i3 restart
