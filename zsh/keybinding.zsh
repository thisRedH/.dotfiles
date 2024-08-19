#!/bin/sh

bindkey -e

bindkey "^[" reset-prompt                   # [Escape]

bindkey "^[[1;5C" forward-word              # [Ctrl-RightArrow]
bindkey "^[[5C" forward-word                # [Ctrl-RightArrow]
bindkey "^[[1;5D" backward-word             # [Ctrl-LeftArrow]
bindkey "^[[5D" backward-word               # [Ctrl-LeftArrow]

bindkey "^H" backward-kill-word             # [Ctrl-Backspace]
bindkey "^[[3;5~" kill-word                 # [Ctrl-Delete]

bindkey "$(tput khome)" beginning-of-line   # [HOME]
bindkey "$(tput kend)" end-of-line          # [End]
bindkey "$(tput kdch1)" delete-char         # [Delete]
bindkey "$(tput kpp)" up-line-or-history    # [Page Up]
bindkey "$(tput knp)" down-line-or-history  # [Page Down]
bindkey "$(tput kich1)" overwrite-mode      # [Insert]

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
