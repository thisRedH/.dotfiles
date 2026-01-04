#!/bin/sh

if [ -z "$DOTFILESPATH" ]; then
    SCRIPTPATH=$(cd "$(dirname "$0")" || exit 1; pwd)
    DOTFILESPATH=$SCRIPTPATH/..
fi

set -x

ln -s -t "$HOME" "$DOTFILESPATH/.config"
ln -s -t "$HOME" "$DOTFILESPATH/bash/.bashrc"

echo '
export ZDOTDIR=$HOME/.config/zsh
[[ -f "$ZDOTDIR/.zshenv" ]] && . "$ZDOTDIR/.zshenv"
' > "$HOME/.zshenv"
