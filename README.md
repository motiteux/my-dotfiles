This is my dotfiles structure. I am using the package [dotfiles](https://pypi.python.org/pypi/dotfiles) to manage those.

Most of those dotfiles work with Debian and have been tested with Debian 8.

On a new account, or a new machine, I usually do::

    > mkdir ~/.dotfiles && cd ~/.dotfiles
    > git clone git@bitbucket.org:marc_olivier/my-dotfiles.git my-dotfiles
    > ln -sfn ~/.dotfiles/my-dotfiles/dotfilesrc ~/.dotfilesrc
    > cd ~
    > dotfiles -s -d

Then, I check everything is covered, ie, every file I need is symlinked to a path in the git repo::

    > dotfiles -s

I also have private dotfiles repository (with more sensitive data), into which I add other kind of files with a suffix .branch_name.
In this repo, each branch is related to a machine I own or a environment I need. Then, I do the following::

    > cd ~/.dotfiles
    > git clone git@bitbucket.org:marc_olivier/my-private-dotfiles my-private-dotfiles
    > cd ~
    > dotfiles -C ~/.dotfiles/my-private-dotfiles/dotfilesrc -s -d

I check nothing already taken care of is not overriden, and then::

    > dotfiles -C ~/.dotfiles/my-private-dotfiles/dotfilesrc -s  # no -f option otherwise it will override global .dotfilesrc

You can rinse and repeat the previous procedure for any third-party repository you would have.

Every file is either automatically sourced or included in the PATH or in the different environment variable according to its location in the repo.
