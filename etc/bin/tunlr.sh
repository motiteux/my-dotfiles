#!/bin/bash
# Turn Tunlr service on/off (rewrite temporarily nameserver in /etc/resolv.conf)
#   Should be turned off eventually
#
# Author: Marc-Olivier Titeux
# Date: 28/10/2012

RETVAL=0

function _validate()
{
    validate=0
    if [ -f /etc/resolv.conf ]; then
        validate=1
    fi
}

function _check_status()
{
    if [ -f /etc/resolv.conf.bak_tunlr ]; then
        status=1
    else
        status=0
    fi
}

_check_status
_validate

if [ $validate -eq 0 ]; then
    echo "Missing /etc/resolv.conf. Check your config."
else
    if [ `id -u` -eq 0 ]; then
        case "$1" in
        start)
            if [[ $status -eq 1 ]]; then
                echo "Tunlr already started. Exiting..."
                exit 1
            fi
            sudo mv /etc/resolv.conf /etc/resolv.conf.bak_tunlr
            sudo echo -e "nameserver 184.82.222.5\nnameserver 199.167.30.144" > /etc/resolv.conf
            sudo chattr +i /etc/resolv.conf
            notify-send -t 900 "Starting Tunlr""Do not forget to stop"
            RETVAL=$?
          ;;
        stop)
            if [[ $status -eq 0 ]]; then
                echo "Tunlr has not been started yed. Cannot be stopped."
                exit 1
            fi
            sudo chattr -i /etc/resolv.conf
            sudo mv /etc/resolv.conf.bak_tunlr /etc/resolv.conf
            notify-send -t 900 "Stopping Tunlr"
            RETVAL=$?
          ;;
        status)
            if [[ $status -eq 1 ]]; then
                echo "Tunlr is in usage"
            else
                echo "Tunlr is not in usage"
            fi
          ;;
        *)
            echo $"Usage: $0 {start|stop|status}"
            RETVAL=1
          ;;
        esac
    else
        echo "Must be run as sudo"
        RETVAL=1
    fi
fi

exit $RETVAL

