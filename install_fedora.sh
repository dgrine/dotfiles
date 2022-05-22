#!/usr/bin/sh
cd ~

echo "Installing exa"
sudo dnf install exa

echo "Installing nodejs, npm"
sudo dnf install nodejs npm

echo "Installing clang, lldb"
sudo dnf install clang
sudo dnf install lldb

echo "Installing cmake"
sudo dnf install cmake

#echo "Installing ccls"
#sudo dnf install ccls

echo "Installing Python3"
sudo dnf install python3
sudo dnf install python3-devel

echo "Installing Docker, Docker Compose"
sudo dnf install docker
sudo dnf install docker-compose
sudo usermod -aG docker ${USER}

echo "Installing ctags"
sudo dnf install ctags

echo "Installing neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s ~/dev/repos/setup/nvim ~/.config/nvim
sudo dnf install neovim 
pip install neovim

echo "Installing vifm"
sudo dnf install vifm
ln -s ~/dev/repos/setup/vifm ~/.config/vifm

echo "Installing tmux"
sudo dnf install tmux
ln -s ~/dev/repos/setup/tmux/.tmux.conf

echo "Installing ripgrep"
sudo dnf install ripgrep

echo "Installing fzf"
sudo dnf install fzf

echo "Installing git"
sudo dnf install git
ln -s ~/dev/repos/setup/git/.gitconfig

echo "Linking to custom .zshrc"
ln -s ~/dev/repos/setup/zsh/.zshrc ~/.zshrc

echo "Creating empty .zshrc_local"
touch ~/.zshrc_local

echo "Installing zsh and oh-my-zsh"
echo "Note: exit manually after reaching the zsh prompt"
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
