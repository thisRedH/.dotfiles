#!/bin/zsh

setopt prompt_subst
source "$ZDOTDIR/git_status.zsh"

# Styling

## see colors at https://raw.githubusercontent.com/webdiscus/ansis/HEAD/docs/img/ansi256.png and https://unix.stackexchange.com/a/124409
## convert colors using https://stackoverflow.com/a/26665998/22279121

RESET="%f%k%b%u%s"
num_colors=$(tput colors)
if [ "$num_colors" -ge 256 ]; then
    STYLE_USER="%B%F{227}"      # yellow-green, bold
    STYLE_USER_ROOT="%B%F{1}"   # red, bold

    STYLE_HOST="%F{127}"        # magenta
    STYLE_DIR="%F{240}"         # dark gray

    STYLE_DEFAULT="%F{247}"     # light gray, bold
    STYLE_DEFAULT_R="%F{130}"   # dark orange
    STYLE_DEFAULT_S=""
elif [ "$num_colors" -ge 8 ]; then
    STYLE_USER="%B%F{3}"        # yellow, bold
    STYLE_USER_ROOT="%B%F{1}"   # red, bold

    STYLE_HOST="%F{5}"          # magenta
    STYLE_DIR=""

    STYLE_DEFAULT="%B"          # bold
    STYLE_DEFAULT_R="%F{1}"     # red
    STYLE_DEFAULT_S=""
else
    # No need to set anything
fi

if [[ $UID == 0 ]]; then
    STYLE_USER=$STYLE_USER_ROOT
fi

# Layout

GIT_FORMAT="\
${STYLE_DIR}[${RESET}\
${STYLE_DEFAULT}{@B}${RESET}\
${STYLE_HOST}{ ↑@a}{↓@b}${RESET}\
${STYLE_DEFAULT_R}{ ·@s}{ !@!}{ ?@?}${RESET}\
${STYLE_DIR}]{@ }"

PROMPT="\
${STYLE_USER}%n${RESET}\
${STYLE_DEFAULT}@${RESET}\
${STYLE_HOST}%m${RESET}\
${STYLE_DIR} %~ ${RESET}"\
'$(zsh_git_status_get $GIT_FORMAT)'"${RESET}\
${STYLE_DEFAULT}> "

RPROMPT="${STYLE_DEFAULT}"'$elapsed'"${RESET}${STYLE_DEFAULT_R}%(?,,%?)"
SPROMPT="zsh: correct '%R' to '%r' ? [ynea] "

# from https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0?permalink_comment_id=4749037#gistcomment-4749037
precmd() {
    elapsed=" "
    if [ $timer ]; then
        local now=$(date +%s%3N)
        local d_ms=$(($now-$timer))
        local d_s=$((d_ms / 1000))
        local ms=$((d_ms % 1000))
        local s=$((d_s % 60))
        local m=$(((d_s / 60) % 60))
        local h=$((d_s / 3600))
        if ((h > 0)); then elapsed=(${h}h ${m}m)
        elif ((m > 0)); then elapsed=(${m}m ${s}s)
        elif ((s >= 10)); then elapsed=${s}.$((ms / 100))s
        elif ((s > 0)); then elapsed=${s}.$((ms / 10))s
        else elapsed=${ms}ms
        fi

        unset timer
    fi
    elapsed="$elapsed "
}
preexec() {
    timer=$(date +%s%3N)
}

# Exports

export PROMPT="${RESET}${STYLE_DEFAULT}${PROMPT}${RESET}"
export RPROMPT="${RESET}${STYLE_DEFAULT_R}${RPROMPT}${RESET}"
export SPROMPT="${RESET}${STYLE_DEFAULT_S}${SPROMPT}${RESET}"
