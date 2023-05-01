#!/usr/bin/env bash
# uninstall.sh
# Uninstalls the configuration files 
# Example: ./uninstall.sh <package> (<target_dir>)
#  - Leave <package> empty to uninstall all packages
#  - To test, you can provide a target directory as a second argument
set -e
PACKAGE=$1
TARGET_DIR=$2
if [ "${TARGET_DIR}" = "" ]; then
    TARGET_DIR=$HOME
fi
echo "Uninstalling configurations from ${TARGET_DIR} ..."
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "... alacritty"
    stow -t ${TARGET_DIR} -D alacritty
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "git" ]; then
    echo "... git"
    stow -t ${TARGET_DIR} -D git
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "... zsh"
    stow -t ${TARGET_DIR} -D zsh
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tmux" ]; then
    echo "... tmux"
    stow -t ${TARGET_DIR} -D tmux
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "vifm" ]; then
    echo "... vifm"
    stow -t ${TARGET_DIR} -D vifm
    rm -rf ~/.local/share/vifm
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nvim" ]; then
    echo "... nvim"
    stow -t ${TARGET_DIR} -D nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
fi
echo "Finished uninstalling configurations"
