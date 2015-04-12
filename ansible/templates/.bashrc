#{{ ansible_managed }}
if [ -n "$SSH_CLIENT" ]; then
    PS1="Via ssh: "
fi
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
case $- in
      *i*) ;;
      *) return;;
esac

. /etc/bash.bashrc

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=100000
export HISTTIMEFORMAT="%F %T"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Fix minor errors in directory name when cd'ing
shopt -s cdspell

# Automatically enter a directory even when command is not prefixed with 'cd'
shopt -s autocd

# When on, single tab is necessary instead of two to display the list of completions
bind 'set show-all-if-ambiguous on'

# Disable suspend/resume process, aka flow control with ctrl+s/ctrl+q
stty -ixon

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function display_profile {
  [ -n "${PROFILE:+x}" ] && echo "${PROFILE} ";
}

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -l'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if [ -f ~/.ssh_aliases ]; then
    . ~/.ssh_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export TERM=xterm-256color
export GDK_NATIVE_WINDOWS=1
export TZ='Europe/Paris'
export LANG='fr_FR.UTF-8'
export LANGUAGE='fr_FR.UTF-8'
export LC_ALL='fr_FR.UTF-8'

if [ -f .environment ]; then
 source .environment
fi

function tmux {
    if (( $# )); then
        command tmux "${@}"
    else
        if (( $(tmux list-sessions 2> /dev/null | wc -l) )); then
            command tmux attach -t dev
        else
            command tmux new-session -s dev
        fi
    fi
}

# At last, allows user to customize its environment
if [ -f ~/.bash_perso ]; then
    . ~/.bash_perso
fi
#{{ ansible_managed }}
