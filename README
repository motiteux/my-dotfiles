This is my dotfiles structure. I am using the package [dotfiles](https://pypi.python.org/pypi/dotfiles) to manage those. 

On a new account, or a new machine, I usually do::
    > mkdir ~/.dotfiles && cd ~/.dotfiles
    > git clone git@bitbucket.org:marc_olivier/my-dofiles.git my-dotfiles
    > ln -sfn ~/.dotfiles/my-dotfiles/dotfilesrc ~/.dotfilesrc
    > dotfiles -s -d

    [Then, I check everything is covered, ie, every file I need is symlinked to a path in the git repo]

    > dotfiles -s

Afterwards, I also have private dotfiles repository (with more sensitive data), into which I add other kind of files with a suffix .branch_name.
In this repo, each branch is related to a machine I own or a environment I need. Then, I do the following::
    > https://bitbucket.org/marc_olivier/my-private-dotfiles ~/.dotfiles/my-private-dotfiles
    > dotfiles -C ~/.dotfiles/my-private-dotfiles -s -d

    [I check nothing already taken into is not overriden]

    > dotfiles -C ~/.dotfiles/my-private-dotfiles -s  # no -f option otherwise it will override global .dotfilesrc

You can rinse and repeat the previous procedure for any third-party repository you would have.

Every file is either automatically sourced or included in the PATH or in the different environment variable according to its location in the repo.
