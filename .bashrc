#!/bin/bash
# Reference from: *** https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c ***

#######################################################
# SOURCED ALIAS'S AND SCRIPTS BY zachbrowne.me
#######################################################

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then . /etc/bash_completion
fi

#######################################################
# EXPORTS
#######################################################

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Set the default editor
export EDITOR=vim

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias ll='ls -Fls' # long listing format
# Copy file with a progress bar

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function color() {
    echo "\033[$1;38;2;$2;$3;$4m"
}
function __setprompt
{
    local LAST_COMMAND=$? # Must come first!

    # Define colors
    local LIGHTGRAY="\033[0;37m"
    local WHITE="\033[1;37m"
    local BLACK="\033[0;30m"
    local DARKGRAY="\033[1;30m"
    local RED=$(color 0 223 24 37)
    local LIGHTRED=$(color 0 231 61 60)
    local GREEN=$(color 1 21 189 70)
    local LIGHTGREEN=$(color 0 42 173 109)
    local BROWN="\033[0;33m"
    local YELLOW="\033[1;33m"
    local BLUE="\033[0;34m"
    local LIGHTBLUE=$(color 0 63 154 208)
    local MAGENTA="\033[0;35m"
    local LIGHTMAGENTA="\033[1;35m"
    local CYAN=$(color 0 122 181 217)
    local LIGHTCYAN="\033[1;36m"
    local NOCOLOR="\033[0m"

    # Show error exit code if there is one
    if [[ $LAST_COMMAND != 0 ]]; then
        # PS1="\[${RED}\](\[${LIGHTRED}\]ERROR\[${RED}\])-(\[${LIGHTRED}\]Exit Code \[${WHITE}\]${LAST_COMMAND}\[${RED}\])-(\[${LIGHTRED}\]"
        PS1="\[${DARKGRAY}\](\[${LIGHTRED}\]ERROR\[${DARKGRAY}\])-(\[${RED}\]Exit Code \[${LIGHTRED}\]${LAST_COMMAND}\[${DARKGRAY}\])-(\[${RED}\]"
        if [[ $LAST_COMMAND == 1 ]]; then
            PS1+="General error"
        elif [ $LAST_COMMAND == 2 ]; then
            PS1+="Missing keyword, command, or permission problem"
        elif [ $LAST_COMMAND == 126 ]; then
            PS1+="Permission problem or command is not an executable"
        elif [ $LAST_COMMAND == 127 ]; then
            PS1+="Command not found"
        elif [ $LAST_COMMAND == 128 ]; then
            PS1+="Invalid argument to exit"
        elif [ $LAST_COMMAND == 129 ]; then
            PS1+="Fatal error signal 1"
        elif [ $LAST_COMMAND == 130 ]; then
            PS1+="Script terminated by Control-C"
        elif [ $LAST_COMMAND == 131 ]; then
            PS1+="Fatal error signal 3"
        elif [ $LAST_COMMAND == 132 ]; then
            PS1+="Fatal error signal 4"
        elif [ $LAST_COMMAND == 133 ]; then
            PS1+="Fatal error signal 5"
        elif [ $LAST_COMMAND == 134 ]; then
            PS1+="Fatal error signal 6"
        elif [ $LAST_COMMAND == 135 ]; then
            PS1+="Fatal error signal 7"
        elif [ $LAST_COMMAND == 136 ]; then
            PS1+="Fatal error signal 8"
        elif [ $LAST_COMMAND == 137 ]; then
            PS1+="Fatal error signal 9"
        elif [ $LAST_COMMAND -gt 255 ]; then
            PS1+="Exit status out of range"
        else
            PS1+="Unknown error code"
        fi
        PS1+="\[${DARKGRAY}\])\[${NOCOLOR}\]\n"
    else
        PS1=""
    fi

    local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
    local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
    # PS1+="\[${RED}\]\u"
    PS1+="\[${GREEN}\]\w \[${DARKGRAY}\] "
    if [ $SSH2_IP ] || [ $SSH_IP ] ; then
        PS1+="\[${RED}\]\u@\h"
    else
        PS1+="\[${LIGHTRED}\]\u\[${LIGHTBLUE}\]@\[${LIGHTRED}\]\h"
    fi

    local git_branch=$(parse_git_branch)
    if [ "$git_branch" ] ; then
        PS1+=" \[${LIGHTBLUE}\]\$(parse_git_branch)\[\033[00m\]"
    fi
    PS1+="\n"
    PS1+="\[${GREEN}\]>\[${NOCOLOR}\] "
}
PROMPT_COMMAND='__setprompt'
export VIMDIR=~/.config/nvim

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon
xset b off
function fcd {
    cd $(find . \( \
        -name ".git" -o \
        -name ".dotnet" -o \
        -name "debug" -o \
        -name "bin" -o \
        -name "obj" -o \
        -name ".idea" -o \
        -name ".fleet" -o \
        -name "node_modules" -o \
        -name "volumes" -o \
        -name ".terraform" -o \
        -name "Library" -o \
        -name "Pictures" -o \
        -name "Documents" -o \
        -name ".local" -o \
        -name ".nuget" -o \
        -name ".npm" -o \
        -name ".vscode" -o \
        -name ".rustup" -o \
        -name ".cargo" -o \
        -name ".quokka" -o \
        -name ".vscode-insiders" \
        \) -prune -false -o -type d -print | fzf)
    }
export FZF_DEFAULT_OPTS='-i --height=100%'
alias f='fcd'
# . "$HOME/.cargo/env"
cfd() { # NOTE: find and open directory in vim ( open project )
    if ! command -v fdfind &> /dev/null
    then
        echo "<fdfind> could not be found\nUse switch to <find>"
        result=$(find . -name target -prune -o -name node_modules -prune -o -not -path '*/.*' -type d| fzf)
    else
        result=$(fdfind --type d | fzf)
    fi
    if [[ $result != "" ]] then
        cd $result
    fi
}
vfd() { # NOTE: find and open directory in vim ( open project )
    if ! command -v fdfind &> /dev/null
    then
        if ! command -v fd &> /dev/null
        then
            echo "<fdfind || fd> could not be found. Use switch to <find>"
            result=$(find . -name target -prune -o -name node_modules -prune -o -not -path '*/.*' -type d| fzf)
        else
            result=$(fd --type d | fzf)
        fi
    else
        result=$(fdfind --type d | fzf)
    fi
    if [[ $result != "" ]] then
        if ! command -v nvim &> /dev/null
        then
            echo "<nvim> could not be found\nUse switch to <vim>"
        else
            nvim $result
        fi
    fi
}
lazygit() { # work around for symlinks
    cd $(readlink -f .)
    /usr/local/bin/lazygit "$@"
}
alias clip="xclip -selection clipboard"
