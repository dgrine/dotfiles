#Determing OS
if [ "${OSTYPE}" == "darwin16" ]; then
	PLATFORM="mac"
	BASH_RC=".bash_profile"
elif [ "${OSTYPE}" == "linux-gnu" ]; then
	PLATFORM="linux"
	BASH_RC=".bashrc"
else
	echo "error: unsupported platform ${OSTYPE}"
	exit 1
fi

export EDITOR=vi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
export PATH=$PATH:/usr/local/mysql/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
if [ "${PLATFORM}" == "mac" ]; then
	alias e='mvim'
else
	alias e='vim'
fi
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias grep='grep --color=auto'
alias ebp='e ~/.bash_profile'
alias ebpl='e ~/.bash_profile_local'
alias sbp='source ~/.bash_profile'
alias scpalt='rsync avzP'
alias m='make -j7'
alias l='ls -alh'
alias gitstatus='git status'
alias cddev='cd ~/dev'

if [ -f "${HOME}/.bash_profile_local" ]; then
	source .bash_profile_local
fi

