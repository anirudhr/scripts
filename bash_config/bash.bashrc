# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

########## ALIASES
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -Alh'
alias cdd='cd "$OLDPWD"'
alias sl='sl -e'
alias LS='sl -e'

########## PATHS
export PATH=/usr/local/cuda/bin/:$PATH
#$LD_LIBRARY_PATH FOR CUDA #Shouldn't I be {editing /etc/ld.conf.d or adding a .conf in /etc/ld.so.conf.d} and running ldconfig to achieve this?
export LD_LIBRARY_PATH=/usr/local/cuda/lib/:$LD_LIBRARY_PATH
export JAVA_HOME="/usr/lib/jvm/java-6-openjdk" # "/usr/lib/jvm/java-6-sun/"
export EDITOR=vim
export HISTSIZE=100000
export HISTFILESIZE=100000
export PATH=/mnt/ns2/ns-allinone-2.34/bin:/mnt/ns2/ns-allinone-2.34/tcl8.4.18/unix:/mnt/ns2/ns-allinone-2.34/tk8.4.18/unix:$PATH
export LD_LIBRARY_PATH=/mnt/ns2/ns-allinone-2.34/otcl-1.13:/mnt/ns2/ns-allinone-2.34/lib:$LD_LIBRARY_PATH
export TCL_LIBRARY_PATH=/mnt/ns2/ns-allinone-2.34/tcl8.4.18/library:$TCL_LIBRARY_PATH

########## FUNCTIONS

nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2=$4="";1') | column -t; }

volumes() { watch -d -n 1 'df -h | grep '/dev/sd' | grep -v 'boot' | sort; '; }

devices() { watch -d -n 1 'df -h'; }

rmbut() { ls -Q | grep -v "$1" | xargs rm -r ; }

psgkill() { ps aux | grep -v grep | grep -i $1 ; pgrep $1 | xargs sudo kill -9 ; }

psg() { ps aux | grep -v grep | grep -i $1 ; }

popularcommands() { history | awk '{a[$'$(echo "1 2 $HISTTIMEFORMAT" | wc -w)']++}END{for(i in a){print a[i] " " i}}' | sort -rn | head ; }

ports() { lsof -Pan -i tcp -i udp; }

#ffa() { (($# < 2)) && { echo "usage: ffa pat1 pat2 [...]" >&2; return 1; };awk "/$1/$(printf "&&/%s/" "${@:2}")"'{ print FILENAME ":" $0 }' *; } # http://www.commandlinefu.com/commands/view/7517/where-did-i-write-this

rmbgd() { rm "`gconftool-2 -g /desktop/gnome/background/picture_filename`"; }

bgd() { gconftool-2 -g /desktop/gnome/background/picture_filename; }

openbgd() { echo '"'`gconftool-2 -g /desktop/gnome/background/picture_filename`'"' | xargs eog; }

cpbgd() { echo '"'`gconftool-2 -g /desktop/gnome/background/picture_filename`'"' | xclip -sel clip; }

# cp_p()
# {
#    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
#       | awk '{
#         count += $NF
#             if (count % 10 == 0) {
#                percent = count / total_size * 100
#                printf "%3d%% [", percent
#                for (i=0;i<=percent;i++)
#                   printf "="
#                printf ">"
#                for (i=percent;i<100;i++)
#                   printf " "
#                printf "]\r"
#             }
#          }
#          END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
# }

torinit()
{
	http_proxy=http://127.0.0.1:8118/
	HTTP_PROXY=$http_proxy
	export http_proxy HTTP_PROXY
}

tordestr() { unset http_proxy HTTP_PROXY; }
