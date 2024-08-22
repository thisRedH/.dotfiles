#!/bin/sh

alias ls="ls -p --color=auto"
alias ll="ls -lAp"
alias la="ls -Ap"

alias tree="exa --tree"
alias ltree="exa --tree -la"

alias history="history -f"

alias cat="bat -p"
alias bat="bat --theme=Dracula"
alias more="less"

alias rm="rm -Iv"
alias cp="cp -iv"
alias mv="mv -iv"

alias grep="grep --color=auto"
alias egrep="grep -E"
alias fgrep="grep -F"

alias df="df -h"
alias free="free -m"

alias z="zoxide"

alias yay="paru"
#alias yeet="paru -R"
alias yeet="paru -Runs"

export VIM_CMD="/bin/nvim"
alias vimo="/bin/vim"
alias vim="$VIM_CMD"
alias v="$VIM_CMD"

alias :q="exit"
alias d="cd ~/dev"

alias resetall="tput sgr0 && tput rmam"

# Windows Stuff
alias help="man"
alias cls="clear"

# FZF
export FZF_DEFAULT_OPTS="\
    --layout reverse \
    --info=inline \
    --bind 'enter:become({\
        { cd {1} && echo cd {1} } || \
        { [ -f {1} ] && echo $VIM_CMD \"{1}\" } || \
        echo echo ERROR: Could not open \"{1}\" \
    ; } 2>/dev/null)' \
    --preview 'file -b {} && { \
        bat --style=numbers --color=always --line-range :500 {} || \
        { ls -lAhbp --color {} | tail -n+2 } || \
        echo ERROR: Could not preview this file! \
    ; } 2>/dev/null'"

# im using eval as else cd wouldnt work
alias fd='eval "$(find . -type d | fzf --preview-window 35%)"'
alias ff='eval "$(find . -type f | fzf)"'
alias f='eval "$(_f)"'
alias _f="find . | \
fzf --prompt '*> ' \
    --header 'CTRL-A :: CTRL-D :: CTRL-F' \
    --bind 'ctrl-a:change-prompt(*> )+reload(find .)' \
    --bind 'ctrl-d:change-prompt(d> )+reload(find . -type d)' \
    --bind 'ctrl-f:change-prompt(f> )+reload(find . -type f)'"

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "

alias fr="\
fzf --ansi --disabled \
    --delimiter : \
    --bind 'start:reload:$RG_PREFIX {q}' \
    --bind 'change:reload:sleep 0.1; $RG_PREFIX {q} || true' \
    --preview '"' \
        T=$(($(echo {2} | tr -d -c 0-9) - 250)); \
        T=$(($T < 0 ? 0 : $T));'" \
        bat --style=numbers --color=always --line-range \$T:+250 {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3' \
    --bind 'enter:become($VIM_CMD {1} +{2})'"

alias ffr="$RG_PREFIX '' | \
fzf --ansi \
    --delimiter : \
    --preview '"' \
        T=$(($(echo {2} | tr -d -c 0-9) - 250)); \
        T=$(($T < 0 ? 0 : $T));'" \
        bat --style=numbers --color=always --line-range \$T:+250 {1} --highlight-line {2}' \
    --preview-window 'up,60%,border-bottom,+{2}+3/3' \
    --bind 'enter:become($VIM_CMD {1} +{2})'"

export YSU_IGNORED_ALIASES=(
    "yay"
    "yeet"

    "v"

    ":q"
    "d"

    "help"
    "cls"
)
