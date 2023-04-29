VOLUME=$1
notify=$2
VOL=$(pamixer --get-volume)
DIFF=$((VOL + VOLUME))
if [[ 0 -gt "$DIFF" ]]
then
	DIFF=0
fi
if [[ "$VOLUME" = "toggle" ]]
then
	cmd="pactl set-sink-mute"
	VOLUME="toggle"
	notification="muted/unmuted"
	sinksource="list-sinks"
elif [[ "$VOLUME" = "mute" ]]
then
	cmd="pactl set-sink-mute"
	VOLUME="true"
	notification="muted"
	sinksource="list-sinks"
elif [[ "$VOLUME" = "unmute" ]]
then
	cmd="pactl set-sink-mute"
	VOLUME="false"
	notification="unmuted"
	sinksource="list-sinks"
elif [[ "$VOLUME" = "mictoggle" ]]
then
	cmd="pactl set-source-mute"
	VOLUME="toggle"
	notification="mic muted/unmuted"
	sinksource="list-sources"
else
	cmd="pactl set-sink-volume"
	VOLUME=$VOLUME"%"
	BAR="-h int:value:$DIFF"
	notification="volume"
	sinksource="list-sinks"
fi
for SINK in $(pacmd $sinksource | grep 'index:' | cut -b12-)
do
	$cmd $SINK $VOLUME
	if [[ $notify ]]
	then
		notify-send $notification $BAR
	fi
done
