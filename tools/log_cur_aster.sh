#!/bin/bash
#
# Bash script to log CodeAster computation logs
# Useful for sequential restoration with Kine3D3
#
# Author: Marc-Olivier Titeux
# Date: 27/01/2012
#
# Parameters:
#   param1: update time interval to track changes
#   param2: number of lines to display


# TO CHANGE ACCORDINGLY
# Path to the tmp folder defined in rep_trav in aster preferences
#   (this can be defined in $ASTER_ROOT/etc/codeaster/asrun or
#    superseded by user in ~/.astkrc/prefs)
cd /work/irlin168_1/titeuxm/tmp

# Default input parameters
DEFAULT_UPDATETIME=2
DEFAULT_LINETAIL=15
PROGNAME="Current Aster Computation"

# Timeout periods for notify-send
PERSISTENT_MESSAGETIMOUT=2
let INFOPERSISTENT_MESSAGETIMOUT=$PERSISTENT_MESSAGETIMOUT*1000
let WARNINGPERSISTENT_MESSAGETIMOUT=$PERSISTENT_MESSAGETIMOUT*3000
let CRITICALPERSISTENT_MESSAGETIMOUT=$PERSISTENT_MESSAGETIMOUT*7500

LOGASTER_DIR="$USER-$HOSTNAME-interactif"

# Variables used to track if current computation cycle has changed
CUR_DIR="$(echo $LOG_DIR)"

LOG_DIR=$(echo `ls -lrt | grep $LOGASTER_DIR | awk '/^d/ { f=$NF }; END{ print f }'`)


CUR_LOG=$CUR_DIR/fort.6


message() {
    notify-send -i gtk-dialog-info --urgency=low \
        --expire-time=$INFOPERSISTENT_MESSAGETIMOUT "$PROGNAME" "$*"
}

warning() {
    notify-send -i gtk-dialog-warning --urgency=normal \
        --expire-time=$WARNINGPERSISTENT_MESSAGETIMOUT "$PROGNAME" "$*"
}

critical() {
    notify-send -i gtk-dialog-error --urgency=critical \
        --expire-time=$CRITICALPERSISTENT_MESSAGETIMOUT "$PROGNAME" "$*"
}

# Function used to exit log viewer
quit_log() {
# run if user hits control-c
    QUIT_MSG="Cleaning output and exiting LogAster"
    echo -en "\n*** $QUIT_MSG  ***\n"
    warning "$QUIT_MSG"
    sleep $PERSISTENT_MESSAGETIMOUT
#     clear;
    exit $?
}

get_last_codeaster_proxy_path() {
    CODEASTERPROXY=`ls -lt | grep code_asterproxy_0_ | head -1 | awk '{print $9}'`
}

# Detect if computation has exited with error
capture_computation_error() {
    get_last_codeaster_proxy_path
    if [ -f $CODEASTERPROXY/output.mess ]; then
        TESTERREUR=`egrep 'ERREUR A' $CODEASTERPROXY/output.mess`
        if [ -n "$TESTERREUR" ]; then
            DIRLOG=`pwd`"/"${CODEASTERPROXY}
            critical \
                "Computation has ended with errors. See log for" \
                "<a href=\"file://$DIRLOG/output.mess\">$CODEASTERPROXY</a>"
        fi
    fi
}

usage() {
    cat << EOF
Bash script to log CodeAster computation logs made from
    sequential restoration with Kine3D3
    
log_cur_aster.sh [--help] ][update] [lines]
Parameters:
  --help: display this help
  update: update time interval to track changes
  time: number of lines to display
EOF
}

if [[ $@ == "--help" ]]; then
    usage
    exit $?
fi

case "$#" in
    0)
        update_time=$DEFAULT_UPDATETIME
        tail_lines=$DEFAULT_LINETAIL
        ;;
    1)
        if [[ $1 == [0-9]* ]]; then
            update_time=$1
            tail_lines=$DEFAULT_LINETAIL
        else
            echo "Arguments not set properly"
            usage
            quit_log
        fi
        ;;
    2)
        if [[ $1 == [0-9]* ]] && [[ $2 == [0-9]* ]]; then
            update_time=$1
            tail_lines=$2
        else
            echo "Arguments not set properly"
            usage
            quit_log
        fi
        ;;
    *)
        echo "Arguments not set properly"
        usage
        quit_log
        ;;
esac



header() {
# header of tails
    cat << EOF
Monitoring Aster computation
Current fort.6: $1
EOF
}

read_aster() {

    clear;
    echo $CUR_DIR
    # First check
    if [ ! -d $CUR_DIR ] && [ ! -f $CUR_DIR/fort.6 ]; then
        capture_computation_error
        MSG_END="No current Aster computation."
        echo "$MSG_END"
        critical "$MSG_END"
        quit_log
    fi
    
    while true; do
        if [ -d $CUR_DIR ] && [ -r $CUR_DIR/fort.6 ]; then
            header $CUR_LOG
            watch -n $update_time tail -$tail_lines $CUR_LOG & du -h $CUR_DIR/vola.1
        else
            if [ -d $LOG_DIR ] && [ -r $LOG_DIR/fort.6 ]; then
                CUR_DIR="$(echo $LOG_DIR)"
                CUR_LOG=$CUR_DIR/fort.6
                message "Switching to $CUR_DIR/fort.6"
            else
                MSG_END="Computation ended."
                echo "$MSG_END"
                warning "$MSG_END"
                quit_log
            fi
         fi
         clear;
     done
}

# trap keyboard interrupt (control-c)
trap quit_log SIGINT

read_aster
