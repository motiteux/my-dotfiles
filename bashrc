#!/bin/bash
# .bashrc
#
# Author: M-O Titeux
# Adapted from various sources
# Date: 27/09/2012

# Check for an interactive session
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	source /etc/bash.bashrc
fi

# Sourcing all sub config files
if [ -d ~/.bashrc.d/ ]; then
    for s in ~/.bashrc.d/*; do
	    if [[ -f $s ]]; then
            source $s
	    fi
    done;
fi

# Sourcing private config files
if [ -d ~/.privaterc.d/ ]; then
    for s in ~/.privaterc.d/*; do
        if [[ -f $s ]]; then
            source $s
        fi
    done;
fi


[ -s "/home/mtiteux/.scm_breeze/scm_breeze.sh" ] && source "/home/mtiteux/.scm_breeze/scm_breeze.sh"
