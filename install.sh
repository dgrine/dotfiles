#!/usr/bin/env bash
PACKAGE=$1
mkdir -p ~/.config
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "Installing alacritty ..."
    stow alacritty
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "Installing zsh ..."
    stow zsh
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tmux" ]; then
    echo "Installing tmux ..."
    stow tmux
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "vifm" ]; then
    echo "Installing vifm ..."
    stow vifm
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nvim" ]; then
    echo "Installing nvim ..."
    stow nvim
fi
echo "Done"


