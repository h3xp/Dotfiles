#!/bin/sh
muted="no"
for SRC in $(pacmd list-sources | grep 'muted:' | cut -d ' ' -f 2)
do
	muted=$SRC
done
if [[ "$muted" = "no" ]]
then
    echo "%{F#BD93F9}%{F-} "
else
    echo "%{F#707880} %{F-}"
fi    