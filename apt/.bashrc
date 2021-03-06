# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -Al'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#MY PART OF BASHRC
#$PATH FOR CUDA
export PATH=$PATH:/usr/local/cuda/bin/
#$LD_LIBRARY_PATH FOR CUDA
#Shouldn't I be {editing /etc/ld.conf.d or adding a .conf in /etc/ld.so.conf.d} and running ldconfig to achieve this?
export LD_LIBRARY_PATH=/usr/local/cuda/lib/:$LD_LIBRARY_PATH

#My custom prompt
PS1="\[\033[33m\]\t\[\033[m\]-\[\033[31m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\n\# "

#An alias to switch to the directory you were in previously.
alias cdd='cd "$OLDPWD"'

#Adding my sh_files folder to $PATH
export PATH=$PATH:/script_files/:/script_files/accounts:/script_files/apt:/script_files/coll:

#COPY WITH PROGRESS BAR
cp_p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

#Boost's Libraries
export LD_LIBRARY_PATH=$HOME/pool/lib/:$LD_LIBRARY_PATH

#java home
export JAVA_HOME="/usr/lib/jvm/java-6-openjdk"

#Shortcut for sources.list file
export SOU=/etc/apt/sources.list

export SOUD=/etc/apt/sources.list.d

#export GRUBCFG=/boot/grub/grub.cfg
#export CUDA_POSTON=/media/vol0/academic/TimPoston/CUDA_DynamicFiles
#export ACADEMIC=/media/vol0/academic
#export VOL0=/media/vol0/
#export VOL1=/media/vol1/

alias stud='ssh anirudh@172.16.200.190'

#$PATH for QtCreator
export PATH=$PATH:/opt/qtsdk-2010.02/ #qt/bin

nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }
volumes() { watch -d -n 1 'df -h | grep '/dev/sd' | sort; '; } #Can also add ls and all to be watched
devices() { watch -d -n 1 'df -h; '; }
rmbut() { ls -Q | grep -v "$1" | xargs rm -r ; }
psgkill() { ps aux | grep -v grep | grep -i $1 ; pgrep $1 | xargs sudo kill -9 ; }
psg() { ps aux | grep -v grep | grep -i $1 ; }
popularcommands() { history | awk '{a[$'$(echo "1 2 $HISTTIMEFORMAT" | wc -w)']++}END{for(i in a){print a[i] " " i}}' | sort -rn | head ; }
apacheuser() { sudo su -c bash www-data; }
ports() { lsof -Pan -i tcp -i udp; }

export EDITOR=vim

alias sl='sl -e'
alias LS='sl -e'

export HISTSIZE=100000
export HISTFILESIZE=100000

