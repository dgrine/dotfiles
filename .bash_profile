#Determing OS
if [ "${OSTYPE}" == "darwin17" ]; then
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
	export EDITOR="vim"
fi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH=$PATH:/usr/local/mysql/bin
export PATH="/usr/local/sbin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#function _update_ps1() {
    #PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    #PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

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

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    #Remote
    export PS1="\[\e[1;32m\]\u\[\e[m\]\[\e[1;30m\]@\[\e[m\]\[\e[1;33m\]\h\[\e[m\]:\[\e[1;34m\]\W\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\] "
else
    #Local
    export PS1="\[\e[1;32m\]\u\[\e[m\]:\[\e[1;34m\]\W\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\] "
fi

#Bash completion
if [ "${PLATFORM}" == "mac" ]; then
	TMP_VAR=`find /usr/local/Cellar/bash-completion/ -name bash_completion | tail -n 1`
	if [ "${TMP_VAR}" != "" ]; then
		. ${TMP_VAR}
	fi
fi

#ViM
alias ce='vim'
if [ "${PLATFORM}" == "mac" ]; then
    alias e='mvim'
else
    alias e='ce'
fi

#Configuration
export mypath="$HOME/.my/setup"
alias cdmy='cd $mypath'
alias cdvim='cd $HOME/.vim/'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias evrc='e $HOME/.vimrc'
alias ebp='e $HOME/.bash_profile'
alias ebpl='e $HOME/.bash_profile_local'
alias sbp='source $HOME/.bash_profile'
alias senv='source env/bin/activate'
alias scpalt='rsync avzP'
alias l='ls -alh'
#Tools
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias grep='grep -E -n --color=auto'
alias ack='ack --nogroup'
#Git
alias s='git status'
alias b='echo Top-level; git branch; git submodule foreach git branch'
alias d='git diff'
alias a='git add *'
alias cm='git commit -m '
alias cuth='git commit -m uth'
alias cwip='cm wip'
alias pr='git pull --rebase'
alias p='git push'
alias ms='git merge --squash'
alias ch='git checkout'
alias master='ch master'
alias gc='git clone -j8 --recursive'
alias gd='git difftool'
alias gdd='git difftool'
#Development
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias m='make -j7'
alias mkenv='virtualenv -p python3 env'
alias ag='ag --nogroup'
alias meld='open /Applications/Meld.app'
alias p3='python3'
alias pcat='pygmentize -O style=native -g'
function dbg {
    prog=$1
    shift
    lldb $prog -- $@
}

#Path
export PATH="${PATH}:/$HOME/dev/bin"

if [ -f "${HOME}/.bash_profile_local" ]; then
	source ${HOME}/.bash_profile_local
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

