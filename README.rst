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
