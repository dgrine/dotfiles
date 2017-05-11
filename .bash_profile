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

if [ "${PLATFORM}" == "mac" ]; then
	export EDITOR="vim -v"
else
	export EDITOR=vim
fi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
export PATH=$PATH:/usr/local/mysql/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#Midnight-commander wrapper
if [ "${PLATFORM}" == "mac" ]; then
	TMP_VAR=`find /usr/local/Cellar/midnight-commander/ -name mc-wrapper.sh | tail -n 1`
	if [ "${TMP_VAR}" != "" ]; then
		alias mc=". ${TMP_VAR}"
	fi
fi

#Bash completion
if [ "${PLATFORM}" == "mac" ]; then
	TMP_VAR=`find /usr/local/Cellar/bash-completion/ -name bash_completion | tail -n 1`
	if [ "${TMP_VAR}" != "" ]; then
		. ${TMP_VAR}
	fi
fi

#ViM
if [ "${PLATFORM}" == "mac" ]; then
	alias vim='mvim -v'
	alias vi='vim'
fi

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
alias senv='source env/bin/activate'
alias scpalt='rsync avzP'
alias m='make -j7'
alias l='ls -alh'
alias gitstatus='git status'
alias cdmy='cd ~/.my/setup'
alias cddev='cd ~/dev'
alias cdrepos='cd ~/dev/repos'

if [ -f "${HOME}/.bash_profile_local" ]; then
	source ${HOME}/.bash_profile_local
fi
