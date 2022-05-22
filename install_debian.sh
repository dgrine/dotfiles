#!/bin/bash

apt update

cd ~

echo "Installing exa"
apt install exa

echo "Installing nodejs, npm"
apt install nodejs npm

echo "Installing clang, lldb"
apt install clang lldb

echo "Installing cmake"
apt install cmake

echo "Installing ccls"
apt install ccls

echo "Installing Python3"
apt install python3 python3-dev

echo "Installing Docker, Docker Compose"
apt install docker docker-compose
groupadd docker
usermod -aG docker $USER
newgrp docker

echo "Installing ctags"
apt install ctags

echo "Installing neovim"
apt install neovim
pip install neovim
ln -s ~/dev/repos/setup/nvim ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing vifm"
apt install vifm
ln -s ~/dev/repos/setup/vifm ~/.config/vifm

echo "Installing git"
apt install git
ln -s ~/dev/repos/setup/git/.gitconfig

echo "Installing tmux"
apt install tmux
ln -s ~/dev/repos/setup/tmux/.tmux.conf
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing ripgrep"
apt install ripgrep

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing meld"
apt install meld

echo "Installing texlive"
apt install texlive-latex-recommended
apt install texlive-extra-utils
apt install texlive-latex-extra
apt install texlive-fonts-extra

echo "Linking to custom .zshrc"
ln -s ~/dev/repos/setup/zsh/.zshrc ~/.zshrc

echo "Creating empty .zshrc_local"
touch ~/.zshrc_local

echo "Installing curl"
apt install curl

echo "Installing zsh and oh-my-zsh"
echo "Note: exit manually after reaching the zsh prompt"
apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
