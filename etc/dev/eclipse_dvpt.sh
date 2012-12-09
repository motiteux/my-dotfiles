#!/bin/bash

# Bash script that sets Python version (using Pythonbrew)

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

ECLIPSE_EXE=/opt/eclipse/eclipse-4.2.1/eclipse
case "$1" in
        "orange")
            WORKSPACE=/opt/dvpt/Orange
            ;;
            
        "perso")
            WORKSPACE=/opt/dvpt/PersoDev
            ;;

        *)
            echo $"Usage: $0 {orange|perso}"
            exit 1
 
esac

$ECLIPSE_EXE -data $WORKSPACE
