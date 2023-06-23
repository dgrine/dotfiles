#!/usr/bin/env bash
# install-tools.sh
# Installs (most of) the tools on a Debian-based system
# Example: ./install-tools.sh <package> <user>
#  - Leave <package> empty to install all packages
#  - Leave <user> empty to use the current user's home directory for tools that require this
set -e
PACKAGE=$1
DF_USER=$2
if [ "$2" == "" ]; then
    DF_USER=$USER
fi
DF_HOME=$(eval echo ~$DF_USER)

# Superuser privileges
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$PACKAGE" "$DF_USER"

echo "Installing tools for $DF_USER ..."
# alacritty — Fast, cross-platform OpenGL terminal emulator
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "... alacritty"
    apt install -y alacritty
fi
# aws — AWS management tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "aws" ]; then
    echo "... aws"
    TMPDIR=$(mktemp -d)
    echo "    building in $TMPDIR"
    CURDIR=$(pwd)
    cd $TMPDIR
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    ./aws/install
    cd $CURDIR
fi
# bat — Cat clone with syntax highlighting and Git integration
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "bat" ]; then
    echo "... bat"
    apt install -y bat
fi
# buildtools — Generic build tools required for source builds
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "buildtools" ]; then
    echo "... buildtools"
    apt install -y ninja-build \
        gettext libtool libtool-bin \
        autoconf automake cmake g++ \
        pkg-config unzip
fi
# cmake — Cross platform build tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "cmake" ]; then
    echo "... cmake"
    apt install -y cmake
fi
# docker — Containerized application development
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "docker" ]; then
    echo "... docker"
    apt install -y docker
    if [ $(getent group docker) ]; then
        echo "Group 'docker' already exists, skipping"
    else
        groupadd docker
    fi
    usermod -aG docker $DF_USER
fi
# docker-compose — Multi-container application development
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "docker-compose" ]; then
    echo "... docker-compose"
    apt install -y docker-compose
fi
# clang — C language family frontend for llvm
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "clang" ]; then
    echo "... clang"
    apt install -y clang
fi
# exa — Modern replacement for ls
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "exa" ]; then
    echo "... exa"
    apt install -y exa
fi
# fzf — General-purpose command-line fuzzy finder
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "fzf" ]; then
    echo "... fzf"
    apt install -y fzf
fi
# git — Distributed version control system
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "git" ]; then
    echo "... git"
    apt install -y git
fi
# icdiff — Command-line diff tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "icdiff" ]; then
    echo "... icdiff"
    apt install -y icdiff
fi
# kubectl — Kubernetes management tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "kubectl" ]; then
    echo "... kubectl"
    TMPDIR=$(mktemp -d)
    echo "    building in $TMPDIR"
    CURDIR=$(pwd)
    cd $TMPDIR
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    cd $CURDIR
fi
# meld — Visual diff and merge tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "meld" ]; then
    echo "... meld"
    apt install -y meld
fi
# neovim — Hyperextensible Vim-based text editor
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "neovim" ]; then
    echo "... neovim"
    # Notes:
    # - This requires 'buildtools'
    # - Source build to get latest version
    TMPDIR=$(mktemp -d)
    echo "    building in $TMPDIR"
    CURDIR=$(pwd)
    cd $TMPDIR
    git clone https://github.com/neovim/neovim.git
    cd neovim
    git checkout stable
    make CMAKE_BUILD_TYPE=Release install
    cd $CURDIR
fi
# nerdfonts — Fonts for the terminal
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nerdfonts" ]; then
    echo "... nerdfonts"
    TMPDIR=$(mktemp -d)
    echo "    building in $TMPDIR"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/UbuntuMono.zip -O $TMPDIR/nerdfonts.zip
    echo "    installing in $DF_HOME/.fonts"
    mkdir -p $DF_HOME/.fonts/
    unzip $TMPDIR/nerdfonts.zip -d $DF_HOME/.fonts/
    fc-cache -fv
fi
# nodejs — JavaScript runtime
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nodejs" ]; then
    echo "... nodejs"
    apt install -y nodejs
fi
# npm — nodejs package manager
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "npm" ]; then
    echo "... npm"
    apt install -y npm
fi
# patchelf — Patch ELF objects
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "patchelf" ]; then
    echo "... patchelf"
    apt install -y patchelf
fi
# python3-venv — Virtual environment manager for Python3
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "python3-venv" ]; then
    echo "... python3-venv"
    apt install -y python3-venv
fi
# python3-pip — Package manager for Python3
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "python3-pip" ]; then
    echo "... python3-pip"
    apt install -y python3-pip
fi
# ripgrep — Fast, line-oriented search tool for regex patterns
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "ripgrep" ]; then
    echo "... ripgrep"
    apt install -y ripgrep
fi
# stow — Symlink farm manager
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "stow" ]; then
    echo "... stow"
    apt install -y stow
fi
# tldr — Simplified and community-driven man pages
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tldr" ]; then
    echo "... tldr"
    apt install -y tldr
fi
# tmux — Terminal multiplexer
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tmux" ]; then
    echo "... tmux"
    apt install -y tmux
fi
# vifm — File manager with curses interface providing a Vim-like environment
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "vifm" ]; then
    echo "... vifm"
    apt install -y vifm
fi
# xclip — Command line interface to X selections
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "xclip" ]; then
    echo "... xclip"
    apt install -y xclip
fi
# zsh — Shell designed for interactive use
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "... zsh"
    apt install -y zsh
fi

echo "Finished installing tools"

