#!/bin/env sh

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function setup_zsh {
    echo [INFO]: Starting zsh setup

    if [ "$EUID" -ne 0 ]; then
        echo [ERROR]: Please run as root
        return 13
    fi

    if [[ $SCRIPT_DIR != "/home/.dotfiles" ]]; then
        echo [INFO]: Getting files from git@github.com:thisRedH/.dotfiles.git
        cd /home
        git clone --recursive git@github.com:thisRedH/.dotfiles.git >/dev/null
    fi


    echo [INFO]: Creating /etc/profile.d/zdotdir.sh
    sh -c "echo export ZDOTDIR=/home/.dotfiles/zsh > /etc/profile.d/zdotdir.sh" >/dev/null

    echo [INFO]: Creating \"Fake\" .zshrc
    echo \# Set in /etc/profile.d/zdotdir.sh > ~/.zshrc
}

#TODO: Add Bash option
echo [WARNING]: Currently only zsh supported
read -p "CTRL-C to stop; ENTER to run setup"

#TODO: Add option for "/home" dir
#TODO: Add option for local/public install (currently only public)
setup_zsh

exit $?

