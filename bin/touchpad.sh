#!/bin/bash
# Turn Touchpad service on/off  return 1 - status
#
# Author: Marc-Olivier Titeux
# Date: 01/11/2012

RETVAL=0
TEST_SYNC=`xinput --list | grep sync`
if [ $TEST_SYNC ]; then
    DE_STATUS=$(synclient -l | grep TouchpadOff | sed -e 's/.*= //')
    STATUS=$((1-$DE_STATUS))
fi

case "$1" in
start)
    HOSTNAME=$(hostname)
    if [ $HOSTNAME == 'marco-laptop' ]; then
        xinput set-prop 16 130 1
        exit 0
    fi
    
    if [[ $STATUS -eq 1 ]]; then
        notify-send --icon=gtk-warning -t 900 "Touchpad already activated."
        exit 1
    fi
    /usr/bin/synclient TouchpadOff=0
    notify-send --icon=gtk-remove -t 900 "Activating Touchpad"
    RETVAL=$?
  ;;
stop)
    HOSTNAME=$(hostname)
    if [ $HOSTNAME == 'marco-laptop' ]; then
        xinput set-prop 16 130 0
        exit 0
    fi
    
    if [[ $STATUS -eq 0 ]]; then
        notify-send --icon=gtk-warning -t 900 "Touchpad already deactivated."
        exit 1
    fi
    /usr/bin/synclient TouchpadOff=1
    notify-send --icon=gtk-add -t 900 "Deactivating Touchpad"
    RETVAL=$?
  ;;
status)
    if [[ $STATUS -eq 1 ]]; then
        echo "Touchpad is activated"
    else
        echo "Touchpad is activated"
    fi
  ;;
*)
    echo $"Usage: $0 {start|stop|status}"
    RETVAL=1
  ;;
esac

exit $RETVAL
