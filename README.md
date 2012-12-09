It is a tool to deploy myself... Well, my user environment.

Often times, I change machine, switch to cloud development solution, need to 
deploy a development or station environment somewhere else. Or my machine 
crashes completely.

I want to have a cloud-based (at least distributed), version-controlled, easily 
deployable (i.e. displaying availability, atomicity, and consistency) solution. 
If possible, it would be nice to have a common interface from Windows to Linux. 
But as a start, this solution will be dedicated to Linux only.

I am essentially using bash, so there will be bash-related configurations. 
However, except from pure bash, the tool is written in python.

This is a simple dot-file management package, inspired by reinout (https://github.com/reinout/tools)
and others.

The principle
=============

The package has to be cloned in $HOME.
    $HOME/etc contains files to be deployed on the account

Setup
=====

  $HOME/etc/ contains files like 'bashrc' and directories like 'vim'
  $HOME/.* are symlinks to files in $HOME/etc

The idea is that $HOME/etc is tracked by a revision control system like
git.

Running
=======

Getting help:

        # etc/dot-files help
        dot-files - manages symlink files from ~/etc/* to ~/.*

        Syntax: dot-files [ <command> ] [ <options> ]

        Commands:

                list                 - list all etc files
                status               - status of available files
                install [-v] [-f]    - installs symlinks

Checking on the status:

        # etc/dot-files status
        zshrc                         OK
        bashrc                        .
        vimrc                         file

'OK' means that there is a $HOME/.zshrc symlink to etc/zshrc.  'file'
means that there is a $HOME/.zshrc file, but we could convert it into a
symlink.  A dot means that the $HOME/.bashrc is not populated.

You can install new symlinks:

        # etc/dot-files install
        installing .zshrc                         ... skipped, OK
        installing .bashrc
        installing .vimrc
        ln: creating symbolic link `/home/bart/.vimrc': File exists

The above skipped .zshrc, installed a symlink for .bashrc, stopped at
vimrc because there was a conflict.
