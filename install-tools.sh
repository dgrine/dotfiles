#!/usr/bin/env bash
# install-tools.sh
# Installs (most of) the tools on a Debian-based system
# Example: ./install-tools.sh <package> <userhomedir>
#  - Leave <package> empty to install all packages
#  - Leave <user> empty to use the current user's home directory for tools that require this
set -e
PACKAGE=$1
USERHOMEDIR=$2
if [ "$2" == "" ]; then
    USERHOMEDIR=$HOME
fi

# Superuser privileges
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$PACKAGE" "$USERHOMEDIR"

echo "Installing tools for $USERHOMEDIR ..."
# alacritty — Fast, cross-platform OpenGL terminal emulator
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "... alacritty"
    apt install -y alacritty
fi
# bat — Cat clone with syntax highlighting and Git integration
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "bat" ]; then
    echo "... bat"
    apt install -y bat
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
# meld — Visual diff and merge tool
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "meld" ]; then
    echo "... meld"
    apt install -y meld
fi
# neovim — Hyperextensible Vim-based text editor
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "neovim" ]; then
    echo "... neovim"
    apt install -y neovim
fi
# nerdfonts — Fonts for the terminal
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nerdfonts" ]; then
    echo "... nerdfonts"
    echo "    installing in $USERHOMEDIR/.fonts"
    TMPDIR=$(mktemp -d)
    # wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DroidSansMono.zip -O $TMPDIR/nerdfonts.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/UbuntuMono.zip -O $TMPDIR/nerdfonts.zip
    mkdir -p $USERHOMEDIR/.fonts/
    unzip $TMPDIR/nerdfonts.zip -d $USERHOMEDIR/.fonts/
    fc-cache -fv
fi
# nodejs — JavaScript runtime
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nodejs" ]; then
    echo "... nodejs"
    apt install -y nodejs
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
# zsh — Shell designed for interactive use
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "... zsh"
    apt install -y zsh
fi

echo "Finished installing tools"

