#!/bin/zsh
#
# Licensing information can be found at the end of this file.

ZSH_GIT_STATUS_DEFAULT_FORMAT='{@ }[{@B}{ ↑@a}{↓@b}{ ·@s}{ !@!}{ ?@?}]{@ }'

zsh_git_status_format() {
    # https://regex101.com/r/Cb2HAy/1
    if [[ $3 ]]; then
        o=$(echo "$1" | sed -E 's/(\{([^{}]*)(\@'"$2"')([^{}]*)\})/\2$3\4/g;t')
    else
        o=$(echo "$1" | sed -E 's/(\{([^{}]*)(\@'"$2"')([^{}]*)\})//g;t')
    fi

    o=$(eval "echo \"$o\"")
    echo "$o" >&1
}

#######################################
# Get git status for shell prompts
# Arguments:
#   1: Format for the output
# Outputs:
#   Writes git status to stdout
#######################################
zsh_git_status_get() {
    format="$1"
    if [ -z "$format" ]; then;
        format="$ZSH_GIT_STATUS_DEFAULT_FORMAT"
    fi

    git_status=$(git status --porcelain --branch 2>/dev/null)
    if [ -z "$git_status" ]; then; return; fi

    branch_info=$(echo "$git_status" | head -n 1)
    branch=$(echo "$branch_info" | cut -d " " -f2 | sed 's/\.\.\..*$//')
    upstream_status=$(echo "$branch_info" | grep -o '\[.*\]')

    if [[ $upstream_status =~ ahead ]]; then
        ahead=$(echo "$upstream_status" | grep -o 'ahead [0-9]*' | cut -d " " -f2 )
    fi

    if [[ $upstream_status =~ behind ]]; then
        behind=$(echo "$upstream_status" | grep -o 'behind [0-9]*' | cut -d " " -f2)
    fi

    while IFS= read -r line; do
        if [[ "${line:0:2}" == "??" ]]; then
            ((untracked++))
            continue
        fi

        if [[ "${line:0:1}" != " " ]]; then
            ((staged++))
        fi

        if [[ "${line:1:1}" != " " ]]; then
            ((unstaged++))
        fi
    done < <(echo "$git_status" | tail -n +2)

    out=$(zsh_git_status_format "$format" "B" "$branch")
    out=$(zsh_git_status_format "$out" "a" "$ahead")
    out=$(zsh_git_status_format "$out" "b" "$behind")
    out=$(zsh_git_status_format "$out" "s" "$staged")
    out=$(zsh_git_status_format "$out" "!" "$unstaged")
    out=$(zsh_git_status_format "$out" "\?" "$untracked")
    out=$(zsh_git_status_format "$out" "@" "@")
    out=$(zsh_git_status_format "$out" " " " ")

    echo "$out" >&1
}


# Copyright 2024 Matthias Roth
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
