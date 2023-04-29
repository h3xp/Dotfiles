#!/bin/sh
# inspired by cedricfarinazzo
# https://github.com/cedricfarinazzo/i3lock-fancy-multimonitor

DISPLAY_RE="([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+)"
IMAGE_RE="([0-9]+)x([0-9]+)"

# todo, get wallpapers used by nitrogen, readfile:
# ~/.config/nitrogen/bg-saved.cfg

# custom test area
LOCK="/usr/share/i3lock-fancy-multimonitor/icons/lock.png"
TEXT="/usr/share/i3lock-fancy-multimonitor/icons/text.png"

PARAMS=""
OUTPUT_IMAGE="/tmp/i3lock.png"
INPUT_IMAGE="/home/tom/Pictures/wallpaper/wallhaven-ex3ovk.png"
DISPLAY_TEXT=true
COLORIZE=false
BLURTYPE="1x1"

# check if file exists
if [ -f "$OUTPUT_IMAGE" ]; then
    i3lock -i $OUTPUT_IMAGE -t
    exit 0
fi

# Read user input
POSITIONAL=()
for i in "$@"
do
  case $i in
  -h|--help)
    echo "lockscreen.sh: Syntax: lock [-n|--no-text] [-b=VAL|--blur=VAL] [-c|--colorize]"
    echo "for correct blur values, read: http://www.imagemagick.org/Usage/blur/#blur_args"
    exit
    shift
    ;;
  -b=*|--blur=*)
    VAL="${i#*=}"
    BLURTYPE=(${VAL//=/ }) 
    shift
    ;;
  -n|--no-text)
    DISPLAY_TEXT=false
    shift # past argument
    ;;
  -c|--colorized)
    COLORIZE=true
    shift # past argument
    ;;
  *)    # unknown option
    echo "unknown option: $i"
    exit
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

    #Take screenshot:
    #scrot -z $OUTPUT_IMAGE

cp $INPUT_IMAGE $OUTPUT_IMAGE

#Get dimensions of the lock image:
LOCK_IMAGE_INFO=`identify $LOCK`
[[ $LOCK_IMAGE_INFO =~ $IMAGE_RE ]]
IMAGE_WIDTH=${BASH_REMATCH[1]}
IMAGE_HEIGHT=${BASH_REMATCH[2]}

if $DISPLAY_TEXT ; then
  #Get dimensions of the text image:
  TEXT_IMAGE_INFO=`identify $TEXT`
  [[ $TEXT_IMAGE_INFO =~ $IMAGE_RE ]]
  TEXT_WIDTH=${BASH_REMATCH[1]}
  TEXT_HEIGHT=${BASH_REMATCH[2]}
fi

#Execute xrandr to get information about the monitors:
while read LINE
do
  #If we are reading the line that contains the position information:
  if [[ $LINE =~ $DISPLAY_RE ]]; then
    #Extract information and append some parameters to the ones that will be given to ImageMagick:
    WIDTH=${BASH_REMATCH[1]}
    HEIGHT=${BASH_REMATCH[2]}
    X=${BASH_REMATCH[3]}
    Y=${BASH_REMATCH[4]}
    POS_X=$(($X+${WIDTH}/2-${IMAGE_WIDTH}/2))
    POS_Y=$(($Y+$HEIGHT/2-$IMAGE_HEIGHT/2))

#    PARAMS="$PARAMS '$LOCK' '-geometry' '+$POS_X+$POS_Y' '-composite'"

    if $DISPLAY_TEXT ; then
        TEXT_X=$(($X+$WIDTH/2-$TEXT_WIDTH/2))
        TEXT_Y=$(($Y+$HEIGHT/2-$TEXT_HEIGHT/2+200))
        PARAMS="$PARAMS '$TEXT' '-geometry' '+$TEXT_X+$TEXT_Y' '-composite'"
    fi
  fi
done <<<"`xrandr`"

RESIZE="'-geometry' '1920x1200^'"

if ! [[ "$COLORIZE" = true ]]
then
    PARAMS="'-colorspace' 'Gray' $PARAMS"
fi

#Execute ImageMagick:
#eval convert "'$OUTPUT_IMAGE' $RESIZE '-level' '0%,100%,0.6' '-blur' '$BLURTYPE' $PARAMS '$OUTPUT_IMAGE'"
eval convert "'$OUTPUT_IMAGE' $RESIZE '-level' '0%,100%,0.6' $PARAMS '$OUTPUT_IMAGE'"

#Lock the screen:
i3lock -i $OUTPUT_IMAGE -t

#Remove the generated image:
#rm $OUTPUT_IMAGE
