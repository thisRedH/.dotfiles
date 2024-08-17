#!/bin/sh

alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -a"

alias tree="exa --tree"
alias ltree="exa --tree -la"

alias history="history -f"

alias cat="bat -p"
alias bat="bat --theme=Dracula"
alias more="less"

alias vimo="/bin/vim"
alias vim="nvim"
alias v="nvim"

alias rm="rm -Iv"
alias cp="cp -iv"
alias mv="mv -iv"

alias grep="grep --color=auto"
alias egrep="grep -E"
alias fgrep="grep -F"

alias yay="paru"
#alias yeet="paru -R"
alias yeet="paru -Runs"

alias df="df -h"
alias free="free -m"

alias :q="exit"
alias d="cd ~/dev"

alias resetall="tput sgr0 && tput rmam"

# Windows Stuff
alias help="man"
alias cls="clear"

export YSU_IGNORED_ALIASES=(
    "yay"
    "yeet"

    "v"
    "vim"

    ":q"
    "d"

    "help"
    "cls"
)
