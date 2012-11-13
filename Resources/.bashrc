#!/bin/bash

#===============================================================================
#                   BASH RC (Titeuxm) - from various sources
#===============================================================================

# Necessary in order to launch shell scripts
if ! [ -e $HOST_PATH ]; then
    :
else
    # setting locale
    export SHELL=/bin/bash
    export LANG=fr_FR.utf8

    export CUPS_SERVER=irsrvcups
    export PRINTER=irimp285

    export PREFIX_INSTALL=/work/irlin168_1/titeuxm/Apps
    export HOST_PATH=/work/irlin168_1/titeuxm

    export http_proxy=http://titeuxm@irproxyweb1:8082
    export ftp_proxy=http://irproxyweb1:8082


    # Setting up MANPATH, PATH and LD_LIBRARY_PATH
    if [ -n "$PATH" ]; then
        export PATH=$HOME/bin/acces/bash:$PATH:.
    else
        export PATH=$HOME/bin/acces/bash:.
    fi

    # Acces Stuff
    # Subversion
#     . $HOME/bin/acces/bash/acces_subversion.sh
# 
#     Python
#     . $HOME/bin/acces/bash/acces_python.sh

    #-------------------------------------------------------------
    # Source global definitions (if any)
    #-------------------------------------------------------------
    if ! shopt -q login_shell ; then # We're not a login shell
        # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
        pathmunge () {
            if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
            fi
        }

        # Only display echos from profile.d scripts if we are no login shell
        # and interactive - otherwise just process them to set envvars
        for i in /etc/profile.d/*.sh; do
            if [ -r "$i" ]; then
                if [ "$i" == "kde.sh" ] || [ "$i" == "qt.sh" ]; then
                    continue
                else
                    if [ "$PS1" ]; then
                        . $i
                    else
                        . $i >/dev/null 2>&1
                    fi
                fi
            fi
        done
    fi

    #-------------------------------------------------------------
    # Automatic setting of $DISPLAY (if not set already).
    # This works for linux - your mileage may vary. ...
    # The problem is that different types of terminals give
    # different answers to 'who am i' (rxvt in particular can be
    # troublesome).
    # I have not found a 'universal' method yet.
    #-------------------------------------------------------------
    function get_xserver ()
    {
        case $TERM in
           xterm )
                XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
                # Ane-Pieter Wieringa suggests the following alternative:
                # I_AM=$(who am i)
                # SERVER=${I_AM#*(}
                # SERVER=${SERVER%*)}

                XSERVER=${XSERVER%%:*}
                ;;
            aterm | rxvt)
            # Find some code that works here. ...
                ;;
        esac
    }

    if [ -z ${DISPLAY:=""} ]; then
        get_xserver
        if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || \
            ${XSERVER} == "unix" ]]; then
            DISPLAY=":0.0"          # Display on local host.
        else
            DISPLAY=${XSERVER}:0.0  # Display on remote host.
        fi
    fi

    export DISPLAY

	#-------------------------------------------------------------
    # PROMPT
    #-------------------------------------------------------------

    # set a fancy prompt (non-color, unless we know we "want" color)
    PS1="[\t] \[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\W\[\e[00m\]\$ "

    # Pour permettre de taper des caractères accentués dans le shell :
    bind 'set convert-meta off'

	#-------------------------------------------------------------
    # Some settings
    #-------------------------------------------------------------

    ulimit -S -c 0          # Don't want any coredumps.
    set -o notify
    set -o noclobber
    set -o ignoreeof
    #set -o nounset
    #set -o xtrace          # Useful for debuging.

    # Enable options:
    shopt -s cdspell
    shopt -s cdable_vars
    shopt -s checkhash
    shopt -s checkwinsize
    shopt -s sourcepath
    shopt -s no_empty_cmd_completion
    shopt -s cmdhist

    shopt -s extglob        # Necessary for programmable completion.

    # Disable options:
    shopt -u mailwarn
    unset MAILCHECK         # Don t want my shell to warn me of incoming mail.


    export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
    export HOSTFILE=$HOME/.hosts    # Put list of remote hosts in ~/.hosts ...

	# Historique
    #-----------

    # ne pas mettre en double dans l'historique les commandes tapées 2x
    export HISTCONTROL=ignoredups

    # lignes de l'historique par session bash
    export HISTSIZE=10000

    # lignes de l'historique conserv�es
    export HISTFILESIZE=20000
    export HISTTIMEFORMAT="%H:%M > "
    export HISTIGNORE="&:bg:fg:ll:h"
    shopt -s histappend histreedit histverify

    # supporte des terminaux redimensionnables (xterm et screen -r)
    shopt -s checkwinsize

    # setting up del key in terminal
    if tty --quiet ; then
        stty erase '^?'
    fi

    unset QTDIR QTINC QTLIB

    export EDITOR=/usr/bin/kate

    # fetch aliases if they exist
    if [ -f ~/.bash_aliases ]; then
    	. ~/.bash_aliases
    fi

    # setting up del key in terminal
    if tty --quiet ; then
        stty erase '^?'
    fi
fi
