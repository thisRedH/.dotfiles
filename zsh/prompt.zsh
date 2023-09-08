#!/bin/sh

# Prompt

## see colors at https://raw.githubusercontent.com/webdiscus/ansis/HEAD/docs/img/ansi256.png and https://unix.stackexchange.com/a/124409
## convert colors using https://stackoverflow.com/a/26665998/22279121

# Styling
usr_style_8="%B%F{3}"                   # yellow, bold
usr_style_root_8="%B%F{1}"              # red, bold

usr_style_256="%B%F{227}"               # yellow-green, bold
usr_style_root_256=$usr_style_root_8    # same


host_style_8="%F{5}"        # magenta
dir_style_8=""              # none

host_style_256="%F{127}"    # magenta
dir_style_256="%F{240}"     # dark gray

# Defoult Styling
streset="%f%k%b%u%s"
default_style_8="%B"        # bold
r_default_style_8="%F{1}"   # red
s_default_style_8=""        # none

default_style_256="%F{247}"     # light gray, bold
r_default_style_256="%F{130}"   # dark orange
s_default_style_256=""          # none

# Styling Logic
num_colors=$(tput colors)
if [ "$num_colors" -ge 256 ]; then
    #echo "This terminal supports 256 or more colors."

    usr_style=$usr_style_256
    usr_style_root=$usr_style_root_256

    host_style=$host_style_256
    dir_style=$dir_style_256

    default_style=$default_style_256
    r_default_style=$r_default_style_256
    s_default_style=$s_default_style_256
elif [ "$num_colors" -ge 8 ]; then
    #echo "This terminal supports at least 8 colors."

    usr_style=$usr_style_8
    usr_style_root=$usr_style_root_8

    host_style=$host_style_8
    dir_style=$dir_style_8

    default_style=$default_style_8
    r_default_style=$r_default_style_8
    s_default_style=$s_default_style_8
else
    #echo "This terminal supports no colors"

    usr_style=""
    usr_style_root=""

    host_style=""
    dir_style=""

    default_style=""
    r_default_style=$default_style
    s_default_style=$default_style
fi

if [[ $UID == 0 ]]; then
    usr_style=$usr_style_root
fi

# Layout
PROMPT="\
${usr_style}%n\
${streset}\
${default_style}@\
${streset}\
${host_style}%m\
${streset}\
${dir_style} %~\
${streset}\
${default_style} > "

RPROMPT="%(?,,%?)"
SPROMPT="zsh: correct '%R' to '%r' ? [ynea] "

# Exports
export PROMPT="${streset}${default_style}$PROMPT${streset}"
export RPROMPT="${streset}${r_default_style}$RPROMPT${streset}"
export SPROMPT="${streset}${s_default_style}$SPROMPT${streset}"