# by thisRedh

# Local
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keybinding.zsh"
source "$ZDOTDIR/prompt.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
export YSU_IGNORED_ALIASES=("yay" "help" "cls" "v" "vim" "d" "yeet")
source "$ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh"

# History
mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/.histfile"
HISTSIZE=2500
SAVEHIST=25000

# setopt no_beep

setopt correct
#setopt correct_all

setopt extended_history
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_expire_dups_first 
setopt hist_ignore_dups 
setopt hist_reduce_blanks
setopt hist_verify
