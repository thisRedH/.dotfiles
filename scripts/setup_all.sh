#!/bin/sh

pdebug() {
    echo "[DEBUG]:" "$@" >&2
}

pinfo() {
    echo "[INFO ]:" "$@" >&2
}

perror() {
    echo "[ERROR]:" "$@" >&2
}

pfatal() {
    echo "[FATAL]:" "$@" >&2
    exit 1
}

pstep_header() {
    pinfo "--===== Step: $1 =====-- " >&2
}

get_user() {
    if [ "$SUDO_USER" ]; then
        echo $SUDO_USER
    else
        echo $USER
    fi
}

get_home() {
    getent passwd $(get_user) | cut -d: -f6
}

REAL_USER="$(get_user)"
REAL_HOME="$(get_home)"

step_pkg_install_apt() {
    pinfo "Using apt for pkg install"

    pinfo "Update and Upgrade"
    apt-get -y update && apt-get -y upgrade
    pinfo "Installing install dependencies"
    apt-get -y install software-properties-common \
        python3              \
        python3-dev          \
        python3-pip          \
        python-is-python3    \

    pinfo "Adding ppa: 'universe'"
    add-apt-repository -y universe
    apt-get -y update

    pinfo "Installing main packages"
    apt-get -y install       \
        build-essential      \
        libfuse2t64          \
        dos2unix             \
        sudo                 \
        git                  \
        curl                 \
        wget                 \
        fzf                  \
        bat                  \
        eza                  \
        zoxide               \
        tmux                 \
        tree-sitter          \
        luarocks             \
        vim

    # Version in Ubuntu repos and ppa are too old
    sudo -H -u $REAL_USER curl -o /tmp/nvim.appimage -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    mv /tmp/nvim.appimage /usr/local/bin/nvim
    chmod 755 /usr/local/bin/nvim

    mkdir -p $REAL_HOME/.local/bin
    if [ -L "$REAL_HOME/.local/bin/bat" ]; then
        ln -sf /usr/bin/batcat $REAL_HOME/.local/bin/bat
    else
        ln -s /usr/bin/batcat $REAL_HOME/.local/bin/bat
    fi
}

step_pkg_install_pacman() {
    pinfo "Using pacman for pkg install"
    pdebug "TODO: Implement 'step_pkg_install_pacman()'"
}

step_pkg_install() {
    pstep_header "pkg install"

    # TODO: Just check if apt or pacman is avaiable (maybe also add paru and nala)
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            debian|ubuntu|linuxmint|pop)
                step_pkg_install_apt
                ;;
            arch|manjaro)
                step_pkg_install_pacman
                ;;
            *)
                pfatal "Unsupported operating system: $ID"
                ;;
        esac
    else
        pfatal "Unable to detect operating system using '/etc/os-release'"
    fi
}

set_git_alias() {
    pinfo "Setting git alias: '$1' -> '$2'"
    sudo -H -u $REAL_USER git config --global "alias.$1" "$2"
}

step_git_setup() {
    pstep_header "git setup"

    set_git_alias cloner "clone --recursive"
    set_git_alias cloned "clone --depth=1"
    set_git_alias clonerd "clone --recursive --depth=1"
}

step_git_clone_dotfiles() {
    pstep_header "git clone dotfiles"

    if [ ! "$DOTFILE_GIT_URL" ]; then
        DOTFILE_GIT_URL="https://github.com/thisRedH/.dotfiles.git"
    fi
    if [ ! "$DOTFILE_GIT_OUT_DIR" ]; then
        DOTFILE_GIT_OUT_DIR="$REAL_HOME/.dotfiles"
    fi

    if [ -d "$DOTFILE_GIT_OUT_DIR" ]; then
        pinfo "Skipping clone ('$DOTFILE_GIT_OUT_DIR' already exists)"
    else
        pinfo "Cloning '$DOTFILE_GIT_URL' into '$DOTFILE_GIT_OUT_DIR'"
        git clone --recursive "$DOTFILE_GIT_URL" "$DOTFILE_GIT_OUT_DIR" || exit $?
    fi
}

step_zsh_setup() {
    pstep_header "zsh setup"

    zshenv_fname="$REAL_HOME/.zshenv"

    pinfo "Creating '$zshenv_fname'"
    cat > $zshenv_fname <<EOF
export ZDOTDIR=~/.dotfiles/zsh
[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
EOF
}

if [ "$(id -u)" -ne 0 ]; then
    pfatal "This script must be run as root."
    exit 1
fi

help_usage="Usage: $0 {help|all|ipkg|sgit|cgitd|szsh}"
case "$1" in
    a|all|al)
        $0 pkg_install || exit 1
        $0 git_setup || exit 1
	$0 git_clone_dotfiles || exit 1
        $0 zsh_setup || exit 1
        ;;
    h|help|"-h"|"--help")
        echo "$help_usage"
        echo ""
        echo "  h, help             Print this message"
        echo "  a, all              Run all setup/install steps"
        echo "  i, ipkg             Install and update required packages"
        echo "     sgit             Setup git"
	echo "     cgitd            Clone .dotfiles to home dir"
        echo "     szsh             Setup zsh"
        echo ""
        ;;
    i|ipkg|pkg_install)
        step_pkg_install
        ;;
    sgit|git_setup)
        step_git_setup
        ;;
    cgitd|git_clone_dotfiles)
        step_git_clone_dotfiles
        ;;
    szsh|zsh_setup)
        step_zsh_setup
        ;;
    *)
        echo "$help_usage"
        echo ""
        exit 1
        ;;
esac
