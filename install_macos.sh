#!/usr/bin/sh
cd ~

echo "Installing exa"
brew install exa

echo "Installing nodejs, npm"
brew install nodejs npm

echo "Installing clang, lldb"
brew install clang
brew install lldb

echo "Installing cmake"
brew install cmake

#echo "Installing ccls"
#sudo dnf install ccls

echo "Installing Python3"
brew install python3

#echo "Installing Docker, Docker Compose"
#brew install docker
#brew install docker-compose
#sudo usermod -aG docker ${USER}

echo "Installing ctags"
brew install ctags

echo "Installing neovim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s ~/dev/repos/setup/nvim ~/.config/nvim
brew install neovim 
pip3 install neovim

# Hack Nerd Fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

echo "Installing vifm"
brew install vifm
ln -s ~/dev/repos/setup/vifm ~/.config/vifm

echo "Installing tmux"
brew install tmux
ln -s ~/dev/repos/setup/tmux/.tmux.conf

echo "Installing ripgrep"
brew install ripgrep

echo "Installing fzf"
brew install fzf

echo "Linking to custom .zshrc"
ln -s ~/dev/repos/setup/zsh/.zshrc ~/.zshrc

echo "Creating empty .zshrc_local"
touch ~/.zshrc_local

echo "Installing zsh and oh-my-zsh"
echo "Note: exit manually after reaching the zsh prompt"
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
