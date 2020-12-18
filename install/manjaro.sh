#!/bin/bash
pamac install alacritty
mkdir -p $HOME/dev/repos
cd $HOME/dev/repos
git clone git@gitlab.com:dgrine/setup.git

# neovim
pamac install neovim
cd $HOME/.config
ln -s $HOME/dev/repos/setup/alacritty

# neovim: coc requires node
pamac install nodejs

# tmux
pamac install tmux
cd $HOME
ln -s  $HOME/dev/repos/setup/tmux/.tmux.conf

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

# Oh-My-Zsh
cd $HOME
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s $HOME/dev/repos/setup/zsh/.zshrc


