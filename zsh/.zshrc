# by thisRedh

# Local
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keybinding.zsh"
source "$ZDOTDIR/prompt.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh"
source "$ZDOTDIR/plugins/LS_COLORS/lscolors.sh"

autoload -Uz compinit && compinit

zstyle ':completion:*' menu selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

eval "$(zoxide init --cmd cd zsh)"

# History
mkdir -p "$XDG_CACHE_HOME/zsh"
HISTFILE="$XDG_CACHE_HOME/zsh/.histfile"
HISTSIZE=10000
SAVEHIST=$HISTSIZE
setopt append_history
setopt share_history
setopt extended_history
setopt inc_append_history
setopt hist_reduce_blanks
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# setopt no_beep

setopt correct
#setopt correct_all
