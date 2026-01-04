export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export TERM=xterm-256color
export CLICOLOR=1

export CC="gcc"
export EDITOR="vim"
export TERMINAL="kitty"
export BROWSER="zen-browser"

osc52() {
    printf "\033]52;c;%s\033\\" "$(base64 | tr -d '\n')"
}
