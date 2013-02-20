#!/bin/bash
# .bashrc
#
# Author: M-O Titeux
# Adapted from various sources
# Date: 27/09/2012

# Check for an interactive session
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# Sourcing all sub config files
if [ -d ~/.bashrc.d/ ]; then
    for s in ~/.bashrc.d/*; do
	if [[ -f $s ]]; then
        source $s
	fi
    done;
fi
