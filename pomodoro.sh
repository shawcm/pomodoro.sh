#!/bin/bash

# defining default intervals
WORK=25m     # working
SHORT=5m     # short relax
LONG=15m     # long relax
NUM=5        # number of work intervals before a long relax

while getopts :w:s:l:n: OPT; do
    case $OPT in
	w|+w)
	    WORK="$OPTARG"
	    ;;
	s|+s)
	    SHORT="$OPTARG"
	    ;;
	l|+l)
	    LONG="$OPTARG"
	    ;;
	n|+n)
	    NUM="$OPTARG"
	    ;;
	*)
	    echo "usage: ${0##*/} [+-w ARG] [+-s ARG] [+-l ARG] [+-n ARG}"
	    exit 2
    esac
done

shift $(( OPTIND - 1 ))
OPTIND=1

while [[ true ]]; do
    t=1
    while [ $t -le $NUM ]; do
	t=$(( t + 1 ))
	zenity --warning --title="Pomodoro"  --text="Click to Focus $WORK"
	sleep $WORK
	if [ $t -eq $NUM ]; then
	    zenity --warning --title="Pomodoro"  --text="Click to Relax $LONG"
	    sleep $LONG
	else
	    zenity --warning --title="Pomodoro"  --text="Click to Relax $SHORT"
	    sleep $SHORT
	fi
    done
done
