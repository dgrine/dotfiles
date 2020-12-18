#!/bin/bash
#sudo pamac install alacritty
#mkdir -p $HOME/dev/repos
#cd $HOME/dev/repos
#git clone git@gitlab.com:dgrine/setup.git

# neovim
#sudo pamac install neovim
#cd $HOME
#ln -s $HOME/dev/repos/setup/vim/.vimrc
#mkdir -p .vim
#cd $HOME/.vim
#ln -s $HOME/dev/repos/setup/vim/colors
#cd $HOME
#mkdir -p .config/nvim
#cd $HOME/.config/nvim

# tmux
#sudo pamac install tmux
cd $HOME
ln -s  $HOME/dev/repos/setup/tmux/.tmux.conf

# Oh-My-Zsh
cd $HOME
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s $HOME/dev/repos/setup/zsh/.zshrc

