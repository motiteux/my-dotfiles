#!/bin/bash
# .bashrc
#
# Author: M-O Titeux
# Adapted from various sources
# Date: 27/09/2012

# Check for an interactive session
[ -z "$PS1" ] && return

source /etc/profile

if [ -d ~/.bashrc.d/ ]; then
    for s in ~/.bashrc.d/*; do
        source $s
    done;
fi