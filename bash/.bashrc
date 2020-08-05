# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# To allow git branch to be shown in the prompt
# In Ubuntu this file is located at /usr/lib/git-core/ as git-sh-prompt
# In Arch this file is located at /usr/share/git/completion/ as git-prompt.bash
# Copy this file to ~ as .git-prompt.sh or provide the path directly
source $HOME/.git-prompt.sh

bold=$(tput bold);
if [ "$EUID" -ne 0 ]; then
    # Use single quotes rather than double quotes else bash will evaluate it first even before the bash prompt has been drawn
    # Double quotes will cause git branch name to fail to update when you cd because it would have been evaluated before.
    PS1='\[${bold}\]\[\e[38;2;171;178;191m\][\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;97;175;239m\]\u\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;152;195;121m\]@\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;198;120;221m\]\h: \[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;86;182;194m\]\w\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;171;178;191m\]]\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;224;108;117m\]$(__git_ps1 " (%s)")\[\e[m\]';
    PS1+='\[${bold}\]\[\e[38;2;229;192;123m\]\$ \[\e[m\]';
else
    # Need to edit .bashrc of root user and add this or link it to regular user's .bashrc for this to take effect.
    PS1='\[${bold}\]\[\e[38;2;224;108;117m\][\u@\h \W]# \[\e[m\]';

fi

# Modify terminal window name
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
    # Use first for Arch and second for Ubuntu
    # To install exa in Ubuntu:
    # sudo apt install cargo
    # cargo install exa
    alias ls='exa -al --color=always --group-directories-first'
    # alias ls='$HOME/.cargo/bin/exa -al --color=always --group-directories-first'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
