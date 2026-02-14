# use systemd-environment-d-generator(8) to generate environment, and export those variables
set -o allexport
source <(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
set +o allexport

export CLICOLOR=1

export CC="gcc"
export CXX="g++"
export EDITOR="nvim"

export PATH="$PATH:/home/redh/.local/bin"
