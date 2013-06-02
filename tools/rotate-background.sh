#!/bin/bash
#Script to rotate GNOME backgrounds
 
export $(xargs -n 1 -0 echo </proc/$(pidof gnome-session)/environ | grep -Z DBUS_SESSION_BUS_ADDRESS=)
PICTUREDIR=/home/mtiteux/Pictures/Desktop/
NEWBACKGROUND="$(ls $PICTUREDIR | shuf -n1)"
/usr/bin/gconftool-2 -t string -s /desktop/gnome/background/picture_filename "$PICTUREDIR$NEWBACKGROUND" 
/usr/bin/gconftool-2 -t string -s /desktop/gnome/background/picture_options "scaled"
