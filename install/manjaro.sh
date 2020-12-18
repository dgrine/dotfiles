#!/bin/bash
sudo pamac install alacritty
mkdir -p $HOME/dev/repos
cd $HOME/dev/repos
git clone git@gitlab.com:dgrine/setup.git

# neovim
sudo pamac install neovim
cd $HOME/.config
ln -s $HOME/dev/repos/setup/alacritty

# neovim: coc requires node
sudo pamac install nodejs

# tmux
sudo pamac install tmux
cd $HOME
ln -s  $HOME/dev/repos/setup/tmux/.tmux.conf

# alacrity
sudo pamac install alacritty
cd $HOME/.config
ln -s $HOME/dev/repos/setup/alacritty

# vifm
sudo pamac install vifm
cd $HOME/.config
ln -s $HOME/dev/repos/setup/vifm

# Oh-My-Zsh
cd $HOME
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s $HOME/dev/repos/setup/zsh/.zshrc


