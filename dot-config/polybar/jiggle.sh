#!/bin/bash
jigglestatus=$(pidof jiggle 2>/dev/null)
exitcode=$(echo $?)

if [ "$exitcode" == "0" ]; then
	echo %{F#BD93F9}󱕒 %{F-} $stat
fi
