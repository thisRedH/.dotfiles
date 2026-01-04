# by thisRedh
# Super basic file

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls="ls --color=auto"
alias ll="ls -la"
alias la="ls -a"
alias rm="rm -Iv"
alias cp="cp -iv"
alias mv="mv -iv"
alias grep="grep --color=auto"

if command -v nala &> /dev/null; then
    alias apt="nala"
fi

if [ -f source "/usr/share/nvm/init-nvm.sh" ]; then
    source "/usr/share/nvm/init-nvm.sh"
fi

export EDITOR="vim"

PS1='\u@\h \w \$ '
