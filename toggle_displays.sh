#!/bin/bash
TV="HDMI-0"
SCREEN1="DVI-0"
SCREEN2="DVI-1"


# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="tv"
        xrandr --output $TV --auto --output $SCREEN2 --off --output $SCREEN1 --off
elif [ $monitor_mode = "tv" ]; then
        monitor_mode="pc"
        xrandr --output $TV --off --output $SCREEN2 --auto --output $SCREEN1 --auto --left-of $SCREEN2
else
        monitor_mode="all"
        xrandr --output $TV --auto --output $SCREEN2 --left-of $TV --output $SCREEN1 --auto --left-of $SCREEN2
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
