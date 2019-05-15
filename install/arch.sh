# Installation script
# Tested on Manjaro 18

echo ""
echo "==============================================="
echo " Dev tools and utilities installation (arch)   "
echo "==============================================="
echo ""

echo "Installing yay"
sudo pacman -Sy yay

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

echo "Installing cmake"
yay -Sy cmake

echo "Installing neovim"
yay -Sy neovim
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
sudo pip3 install pynvim

echo "Installing tmux"
yay -Sy tmux
echo "Configuring tmux"
cd ~
ln -s  ~/dev/repos/setup/tmux/.tmux.conf

echo "Installing ranger"
yay -Sy ranger
echo "Configuring ranger"
cd ~
mkdir -p .config/ranger
cd ~/.config/ranger
ln -s ~/dev/repos/setup/ranger/commands.py
ln -s ~/dev/repos/setup/ranger/rc.conf

echo "Configuring git"
cp ~/dev/repos/setup/git/.gitconfig ~/
cp ~/dev/repos/setup/git/.gitignore_global ~/

echo "Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "Installing Oh-My-Zsh"
cd ~
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
rm -rf .zshrc
ln -s ~/dev/repos/setup/zsh/.zshrc

echo "Setup almost complete. There are still some manual tasks to be perfomed:"
echo "- Enable 'Color' in /etc/pacman.conf"
