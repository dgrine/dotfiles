#!/usr/bin/env bash
# install.sh
# Installs the configuration files
# Example: ./install.sh <package> (<target_dir>)
#  - Leave <package> empty to install all packages
#  - To test, you can provide a target directory as a second argument
set -e
PACKAGE=$1
TARGET_DIR=$2
if [ "${TARGET_DIR}" = "" ]; then
    TARGET_DIR=$HOME
fi
echo "Installing configurations to ${TARGET_DIR} ..."
mkdir -p ~/.config
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "... alacritty"
    stow -t $TARGET_DIR alacritty
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "git" ]; then
    echo "... git"
    stow -t $TARGET_DIR git
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "... zsh"
    stow -t $TARGET_DIR zsh
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tmux" ]; then
    echo "... tmux"
    stow -t $TARGET_DIR tmux
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "vifm" ]; then
    echo "... vifm"
    stow -t $TARGET_DIR vifm
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nvim" ]; then
    echo "... nvim"
    stow -t $TARGET_DIR nvim
fi
echo "Finished installing configurations"

