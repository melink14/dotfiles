# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#### Other settings ####

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

unset color_prompt force_color_prompt
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;
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

# If this is an xterm set the title to Date user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\D{%a %R} \u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#### Persistent History Setup #####

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# store multiline shell commands on a single line
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=-1
export HISTFILESIZE=-1

# associate a timestamp with each history entry so that it is saved
# across multiple sessions
export HISTTIMEFORMAT="%F %T "

# Cleans the history file, removing all duplicate entries.
clean_bash_history() {
    mkdir -p /tmp/"$USER"_history
    tac ~/.bash_history > /tmp/"$USER"_history/bash_history_dirty
    awk '!visited[$0]++' /tmp/"$USER"_history/bash_history_dirty > /tmp/"$USER"_history/bash_history_cleaned
    tac /tmp/"$USER"_history/bash_history_cleaned > ~/.bash_history
}

# Saving history after every command
process_command() {
    # history -n; # Read history from bash_history
    # history -w; # Save history to file and erase duplicates
    # history -c; # Clear current history
    # history -r; # Restory history from file
  history -a # Append history to history file
  # clean_bash_history # Remove duplicate entries
  history -c # Clear current history
  history -r # Reload history from history file
}

# Add preexec function since we're using bash-preexec.sh
precmd_functions+=(process_command)


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias c='code'
export EDITOR=code

# Should work after `sudo apt install fzf`
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    . /usr/share/doc/fzf/examples/key-bindings.bash
fi

# fzf plugin for auto execute command
# https://github.com/4z3/fzf-plugins
if [ -f ~/.fzf-plugins/history-exec.bash ]; then
    FZF_CTRL_R_EDIT_KEY=tab
    FZF_CTRL_R_EXEC_KEY=enter
    . ~/.fzf-plugins/history-exec.bash
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f ~/.hg-completion.bash ]; then
    . ~/.hg-completion.bash
fi

# GPG configuration
GPG_TTY=$(tty)
export GPG_TTY

# Local config
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local

# Enable bash-preexec
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Enable starship prompt
eval "$(starship init bash)"