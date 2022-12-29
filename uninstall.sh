#!/usr/bin/env bash
PACKAGE=$1
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "alacritty" ]; then
    echo "Uninstalling alacritty ..."
    stow -D alacritty
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "zsh" ]; then
    echo "Uninstalling zsh ..."
    stow -D zsh
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "tmux" ]; then
    echo "Uninstalling tmux ..."
    stow -D tmux
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "vifm" ]; then
    echo "Uninstalling vifm ..."
    stow -D vifm
    rm -rf ~/.local/share/vifm
fi
if [ "$PACKAGE" = "" ] || [ "$PACKAGE" = "nvim" ]; then
    echo "Uninstalling nvim ..."
    stow -D nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
fi
echo "Done"
