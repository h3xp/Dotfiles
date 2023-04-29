#!/bin/bash

count_instances=$(pidof alacritty | wc -w)
colors=("#282a36" "#282930" "#28302f" "#302e28" "#302928" "#30282b" "#2f2830" "#2a2830" "#282e30" "#283028" "#303028")

if [[ "${#colors[@]}" -gt $count_instances ]]
then
    selection=$count_instances
else
    selection=$(expr $count_instances % ${#colors[@]})
fi
echo ${colors[$selection]}
