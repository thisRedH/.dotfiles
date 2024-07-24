#!/bin/sh

bindkey -e

bindkey "\e[3~" delete-char             # [Delete]
bindkey "\e[3;2~" delete-char           # [Delete]
bindkey "\e[3;5~" delete-char           # [Delete]
bindkey "\e[F" end-of-line              # [End]
bindkey "\e[4~" end-of-line             # [End]
bindkey "\e[H" beginning-of-line        # [Pos1/Home]
bindkey "\e[1~" beginning-of-line       # [Pos1/Home]
bindkey "\e[2~" overwrite-mode          # [Insert]
bindkey "^[" reset-prompt               # [Escape]
bindkey "\e[5~" up-line-or-history      # [Page Up]
bindkey "\e[6~" down-line-or-history    # [Page Down]
bindkey "^[[1;5C" forward-word          # [Ctrl-RightArrow]
bindkey "^[[1;5D" backward-word         # [Ctrl-LeftArrow]
bindkey "^H" backward-kill-word         # [Ctrl-Backspace]
bindkey "^[[3;5~" kill-word             # [Ctrl-Delete]
