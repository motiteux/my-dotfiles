#!/usr/bin/env python

# Inspired by https://github.com/dag/dotfiles/blob/master/python/.pythonrc
# and http://jbisbee.blogspot.ch/2013/07/add-history-and-tab-completion-to.html

try:
    import readline
    import rlcompleter
    import atexit
    import os
except ImportError:
    print "Python shell enhancement modules not available."
else:
    readline.parse_and_bind('tab: complete')
    history = os.path.expanduser("~/.pythonhist")

    def save_history(history=history):
        readline.write_history_file(history)

        if os.path.exists(history):
            try:
                readline.read_history_file(history)
            except IOError:
                pass

    atexit.register(save_history)
    #del os, atexit, readline, rlcompleter, 
    del save_history, history
