#!/bin/bash

icon="/"
colors=("#ff0000" "#ff5500" "#ffaa00" "#ffff00" "#aaff00" "#55ff00" "#00ff00" "#00ff55" "#00ffaa" "#00ffff" "#00aaff" "#0055ff" "#0000ff" "#5500ff" "#aa00ff" "#ff00ff" "#ff00aa" "#ff0055")
num_colors=${#colors[@]}
start_index=$((RANDOM % num_colors))

# Print the icons
for ((i=0; i<100; i++))
do
  color_index=$(( (start_index + i) % num_colors ))
  color="${colors[$color_index]}"
  echo -n "%{F$color}$icon%{F-}"
done
echo

