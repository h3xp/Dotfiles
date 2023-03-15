#!/bin/sh

vpnstatus=$(ip addr show tun0 2>/dev/null)
exitcode=$(echo $?)

if [ "$exitcode" == "1" ]; then
    echo "%{F#707880}󰖂  disconnected%{F-}"
else
	stat=$(echo "$vpnstatus" | grep 'inet ' | awk '{print $2}')
	echo %{F#BD93F9}󰖂 %{F-} $stat 
fi
