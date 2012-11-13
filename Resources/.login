#!/bin/tcsh
#################
# SHELL OPTIONS #
#################
setenv HOST_PATH /work/irlin168_1/titeuxm

setenv PREFIX_INSTALL /work/irlin168_1/titeuxm/Apps

setenv http_proxy http://titeuxm@irproxyweb1:8082
setenv ftp_proxy http://irproxyweb1:8082

setenv CUPS_SERVER irsrvcups
setenv PRINTER irimp285
setenv LANG fr_FR.utf8
setenv LC_COLLATE 'C'

set autolist
set color
set colorcat
set nobeep
set autocorrect
set correct=cmd
set ellipsis
set implicitcd=verbose
set notify
set time='1 %c'

# lignes de l'historique conservées
set history = 10000          # History remembered is 2000
set savehist = (10000 merge) # Save and merge with existing saved
set histfile = ~/.tcsh_history

set prompt="[%{\033$USER}@`hostname`:%c][\!]: "
set prompt="%{\033[34m%}%n%{\033[0m%}@%{\033[36m%}%m%{\033[0m%}:[%c] "

######################################
# PATHS, LD_LIBRARY_PATH, AND OTHERS #
######################################
# PYTHON AND SUBVERSION
setenv LD_RUN_PATH /work/irlin168_1/titeuxm/Apps
setenv PYTHONHOME /work/irlin168_1/titeuxm/Apps/python272
setenv PYTHONPATH ${PYTHONHOME}/lib/python2.7/site-packages
setenv PYTHONEXECUTABLE ${PYTHONHOME}/bin/python
setenv PYTHON_INCLUDE_DIR ${PYTHONHOME}/include/python2.7
setenv PYTHON_EXECUTABLE ${PYTHONHOME}/bin/python2.7
setenv PYTHON_LIBRARY ${PYTHONHOME}/lib/libpython2.7.so

##
set EXPL_DIR=/soft/irsrvsoft1/expl

set BASEPATH=/usr/bin:/usr/X11R6/bin:/usr/lib64/qt-3.3/bin:/usr/kerberos/bin:/usr/soft/system/bin:/usr/soft/system/env:/usr/soft/proc:/usr/soft/bin:/sbin:/bin
setenv PATH ${HOME}/bin:${HOME}/bin/acces/csh:${HOME}/bin/aster:${PREFIX_INSTALL}/bin:${PREFIX_INSTALL}/eclipse/eclipse-4.2:${PREFIX_INSTALL}/mendeleydesktop:${PREFIX_INSTALL}/firefox:${PREFIX_INSTALL}/nixnote:${PREFIX_INSTALL}/scilab-5.3.3/bin:${PYTHONHOME}/bin:${EXPL_DIR}/Subversion_1.7.4/SUBVERSION/bin:${BASEPATH}:.

set BASELD_LIBRARY_PATH=/usr/lib64:/lib64:/usr/lib:/lib:/usr/soft/lib
setenv LD_LIBRARY_PATH ${PREFIX_INSTALL}/lib:${PREFIX_INSTALL}/lib64:${PREFIX_INSTALL}/libexec:${PYTHONHOME}/lib/python2.7:${PYTHONHOME}/lib:${EXPL_DIR}/Subversion_1.7.4/SUBVERSION/lib:${EXPL_DIR}/Subversion_1.7.4/APR-UTIL/lib:${EXPL_DIR}/Subversion_1.7.4/APR/lib:${BASELD_LIBRARY_PATH}

set BASEMANPATH=/usr/share/man:/usr/X11R6/man:/usr/kerberos/man:/usr/soft/man
setenv MANPATH ${PREFIX_INSTALL}/man:${PYTHONHOME}/share/man/man1:${BASEMANPATH}

# To be able to ue the one from IFP
alias svn='/soft/irsrvsoft1/expl/Subversion_1.7.4/SUBVERSION/bin/svn'

###########
# ALIASES #
###########
alias ll 'ls -l --color=always \!* | egrep --color=never "^d" ; ls -lXB --color=always \!* | egrep --color=never "^l" ; ls -lXB --color=always \!* | egrep --color=never "^-" && ls -lXB --color=always \!* | egrep --color=never -v "^[d|l|-]";'
alias la 'll -a'
alias mv 'mv -i'
alias rm 'rm -i'
alias cp 'cp -i'
alias grep 'grep --color=auto'

# -> Prevents accidentally clobbering files.
alias mkdir 'mkdir -p'

alias hh 'history'
alias hg 'hh | grep'
alias j 'jobs -l'
alias ..='cd ..'
alias path 'echo -e ${PATH//:/\\n}'
alias libpath 'echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du 'du -kh'       # Makes a more readable output.
alias df 'df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
alias la 'ls -Al'          # show hidden files
alias lx 'ls -lXB'         # sort by extension
alias lk 'ls -lSr'         # sort by size, biggest last
alias lc 'ls -ltcr'        # sort by and show change time, most recent last
alias lu 'ls -ltur'        # sort by and show access time, most recent last
alias lt 'ls -ltr'         # sort by date, most recent last
alias lm 'ls -al |more'    # pipe through 'more'
alias lr 'ls -lR'          # recursive ls
alias tree 'tree -Csu | more'     # nice alternative to 'recursive ls'


#-------------------------------------------------------------
# spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------
alias xs 'cd'
alias vf 'cd'
alias moer 'more'
alias moew 'more'
alias kk 'll'

# aliases that use xtitle
#alias top 'xtitle Processes on $HOST && top'
alias htop 'xtitle Processes on $HOST && htop'
alias make 'xtitle Making $(basename $PWD) ; make'
alias ncftp "xtitle ncFTP ; ncftp"
