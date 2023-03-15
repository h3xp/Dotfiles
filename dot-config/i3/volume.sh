VOLUME=$1
notify=$2
echo $notify
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
	notification="volume: $VOLUME"
	sinksource="list-sinks"
fi
for SINK in $(pacmd $sinksource | grep 'index:' | cut -b12-)
do
	$cmd $SINK $VOLUME
	if [[ $notify ]]
	then
		notify-send $notification
	fi
done
