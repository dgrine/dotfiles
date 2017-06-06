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
export PATH=$PATH:/usr/local/mysql/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#Get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

#Get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[1;32m\]\u\[\e[m\]\[\e[1;30m\]@\[\e[m\]\[\e[1;33m\]\h\[\e[m\]:\[\e[34m\]\W\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\] "

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
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
#alias r='ranger'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias grep='grep --color=auto'
alias evrc='e ~/.vimrc'
alias ebp='e ~/.bash_profile'
alias ebpl='e ~/.bash_profile_local'
alias sbp='source ~/.bash_profile'
alias senv='source env/bin/activate'
alias scpalt='rsync avzP'
alias m='make -j7'
alias l='ls -alh'
alias s='git status'
alias pr='git pull --rebase'
alias p='git push'
alias cdmy='cd ~/.my/setup'
alias cddev='cd ~/dev'
alias cdrepos='cd ~/dev/repos'

if [ -f "${HOME}/.bash_profile_local" ]; then
	source ${HOME}/.bash_profile_local
fi
