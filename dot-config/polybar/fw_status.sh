#!/bin/bash

fwupdmgr get-devices &>/dev/null
fwupdmgr refresh &>/dev/null

fwstatus=$(fwupdmgr get-updates 2>/dev/null)
exitcode=$(echo $?)

if [ "$exitcode" == "2" ]; then
	exit 0
#	echo %{F#44475a}󰁡 %{F-} 
else
	echo %{F#BD93F9}󰁡 %{F-} 
fi
