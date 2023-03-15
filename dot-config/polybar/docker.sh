#!/bin/sh
option=$1
docker_status=$(systemctl is-active docker)
#echo $docker_status
if [[ "$option" = "status" ]]
then
	if [[ "$docker_status" = "inactive" ]]
	then
		#echo "off"
		echo "%{F#707880} %{F-}"
		#exit 1
	else
		#exit 0
		echo "%{F#50fa7b} %{F-}"
	fi
elif [[ "$option" = "toggle" ]]
then
	if [[ "$docker_status" = "inactive" ]]
	then
		systemctl start docker
	else
		systemctl stop docker
	fi
elif [[ "$option" = "list" ]]
then
	notify-send "not a feature john 🧞"
fi

