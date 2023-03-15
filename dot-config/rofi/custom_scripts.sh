#!/usr/bin/env bash
# Custom Script Runner by hexp
DIR=$HOME/$1
echo -en "\0prompt\x1f$(basename $DIR)\n"
# quit to quit 
if [ "$ROFI_RETV" = 1 ]
then
	coproc ( /bin/bash $DIR/$2 > /dev/null 2>&1 ) && exit 0
fi
# list all scripts in DIR
for entry in "$DIR"/*.sh
do
	echo $(basename "$entry")
done
