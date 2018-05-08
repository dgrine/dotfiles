echo "Determining OS"
if [[ "${OSTYPE}" == *"darwin17"* ]]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" == "linux-gnu" ]; then
	PLATFORM="linux"
else
	echo "error: unsupported platform ${OSTYPE}"
	exit 1
fi
echo "-> ${PLATFORM}"

echo "Verifying pre-requisites"
if [ "${PLATFORM}" == "mac" ]; then
	if [ ! `command -v brew` ]; then
		echo "Installing brew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo "Installing pip"
        brew install pip
        pip2 install --upgrade pip setuptools
	fi
fi

echo "Getting up-to-date local copy"
BASE="${HOME}/.my"
REPO="${BASE}/setup"
cd ${HOME}
if [ ! -d "${BASE}" ]; then
	echo "Creating directory"
	mkdir -p ${BASE}
	echo "Cloning repository into ${BASE}"
	cd ${BASE}
	git clone https://github.com/dgrine/setup
else
	echo "Updating repository ${REPO}"
	cd ${REPO}
	git pull --rebase
fi

echo "Configuring VIM"
cd ${HOME}
if [ -f "${HOME}/.vimrc" ]; then
	if [ ! -f "${HOME}/.vimrc.my-orig" ]; then
		echo "Renaming previous .vimrc to .vimrc.my-orig"
		mv ${HOME}/.vimrc ${HOME}/.vimrc.my-orig
	fi
fi
ln -s ${REPO}/.vimrc
if [ ! -f "${HOME}/.vim/colors/seagull.vim" ]; then
	echo "Installing colorscheme"
	mkdir -p ${HOME}/.vim/colors
	cd  ${HOME}/.vim/colors
	curl -O https://raw.githubusercontent.com/nightsense/seabird/master/colors/seagull.vim
    curl -O https://raw.githubusercontent.com/AlessandroYorba/Sidonia/master/colors/sidonia.vim
    curl -O https://raw.githubusercontent.com/cocopon/iceberg.vim/master/colors/iceberg.vim
    curl -O https://raw.githubusercontent.com/vim-scripts/summerfruit256.vim/master/colors/summerfruit256.vim
    curl -O https://raw.githubusercontent.com/Addisonbean/Vim-Xcode-Theme/master/colors/xcode.vim
    curl -O https://raw.githubusercontent.com/zacanger/angr.vim/master/colors/angr.vim
fi
mkdir -p ${HOME}/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer

echo "Configuring Bash"
BASH_RC=".bash_profile"
if [ -f "${HOME}/${BASH_RC}" ]; then
	if [ ! -f "${HOME}/${BASH_RC}.my-orig" ]; then
		echo "Renaming previous ${BASH_RC} to ${BASH_RC}.my-orig"
		mv ${HOME}/${BASH_RC} ${HOME}/${BASH_RC}.my-orig
	fi
fi
if [ "${PLATFORM}" == "mac" ]; then
    brew install bash-completion
fi
ln -s ${REPO}/.bash_profile ${HOME}/${BASH_RC}
#fzf
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install

echo "Everything went OK."

