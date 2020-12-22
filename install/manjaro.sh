#!/bin/bash

# git
cd $HOME
ln -s $HOME/dev/repos/setup/git/.gitconfig
ln -s $HOME/dev/repos/setup/git/.gitignore_global

# alacritty
pamac install alacritty
mkdir -p $HOME/dev/repos
cd $HOME/dev/repos
git clone git@gitlab.com:dgrine/setup.git

# neovim
pamac install neovim
cd $HOME/.config
ln -s $HOME/dev/repos/setup/nvim

# neovim: coc dependencies
pamac install nodejs npm ccls

# neovim: tagbar dependencies
pamac install ctags

# tmux
pamac install tmux
cd $HOME
ln -s  $HOME/dev/repos/setup/tmux/.tmux.conf
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# tmux: copy/paste dependencie on xclip
pamac install xclip

# fzf
pamac install fzf
cd $HOME
ln -s $HOME/dev/repos/setup/fzf/.fzf.zsh

# ripgrep
pamac install ripgrep

# alacrity
pamac install alacritty
cd $HOME/.config
ln -s $HOME/dev/repos/setup/alacritty

# vifm
pamac install vifm
cd $HOME/.config
ln -s $HOME/dev/repos/setup/vifm

# oh-my-zsh
cd $HOME
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s $HOME/dev/repos/setup/zsh/.zshrc


