#
# Made for arch based desktop,
# by Redh
#

# Local
source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/keybinding.zsh"
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/prompt.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
export YSU_IGNORED_ALIASES=("yay" "help" "cls" "v" "vim")
source "$ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh"

# History
mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/.histfile"
HISTSIZE=2500
SAVEHIST=25000


# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Shut up zsh
setopt no_beep
# add
setopt extended_history
setopt share_history
setopt append_history
# adds commands as they are typed, not at shell exit
setopt inc_append_history
# expire duplicates first
setopt hist_expire_dups_first 
# removes blank lines from history
setopt hist_reduce_blanks
# when using !! nee to confirm
setopt hist_verify
# correct commands
setopt correct
# correct everything
#setopt correct_all
