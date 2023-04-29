#!/bin/sh
xrandr --output DP-2.2 --mode 2560x1440 --pos 4480x0 --rotate normal --output DP-2.1 --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --outpu    t DP-2 --off --output DP-3 --off --output HDMI-0 --off --output DP-4 --primary --mode 1920x1200 --pos 0x0 --rotate normal --output DP-5 --off --output DP-6 --off
sleep 5
nitrogen --restore
i3 restart
