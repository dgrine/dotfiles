# Installation script
# Tested on Manjaro 18

echo ""
echo "==============================================="
echo " Dev tools and utilities installation (arch)   "
echo "==============================================="
echo ""

echo "Installing yaourt"
sudo pacman -Sy yaourt

echo "Installing git"
yaourt git-git

echo "Checking out setup repo"
cd ~
mkdir -p dev/repos/
cd dev/repos
git clone git@gitlab.com:dgrine/setup.git || {
    echo "SSH checkout failed"
    git clone https://gitlab.com/dgrine/setup.git || {
        echo "HTTPS checkout failed"
        exit 1
    }
}

echo "Installing curl"
sudo apt install -y curl

echo "Installing gcc and g++"
# sudo apt install -y build-essential gcc g++

# echo "Installing cmake"
# sudo apt install -y cmake

# echo "Installing python"
# sudo apt install -y python3 python3-dev

echo "Installing neovim"
sudo apt install -y neovim
echo "Configuring neovim"
cd ~
ln -s ~/dev/repos/setup/vim/.vimrc
mkdir -p .vim
cd ~/.vim
ln -s ~/dev/repos/setup/vim/colors
cd ~
mkdir -p .config/nvim
cd ~/.config/nvim
ln -s ~/dev/repos/setup/nvim/init.vim
echo "Installing neovim plugins"
nvim
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clang-completer

echo "Installing tmux"
sudo apt install -y tmux
echo "Configuring tmux"
cd ~
ln -s  ~/dev/repos/setup/tmux/.tmux.conf

echo "Installing ranger"
sudo apt install -y ranger
echo "Configuring ranger"
cd ~
mkdir -p .config/ranger
cd ~/.config/ranger
ln -s ~/dev/repos/setup/ranger/commands.py
ln -s ~/dev/repos/setup/ranger/rc.conf

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing Oh-My-Zsh"
sudo apt install -y zsh
echo "Configuring Oh-My-Zsh"
cd ~
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s ~/dev/repos/setup/zsh/.zshrc
