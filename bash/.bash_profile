# Determing OS
if [ "${OSTYPE}" == "darwin17" ]; then
	PLATFORM="mac"
	BASH_RC=".bash_profile"
elif [ "${OSTYPE}" == "linux-gnu" ]; then
	PLATFORM="linux"
	BASH_RC=".bashrc"
else
	echo "Error: unsupported platform ${OSTYPE}"
	exit 1
fi

# Editor
export EDITOR="vim -v"
alias ce='$EDITOR'
if [ "${PLATFORM}" == "mac" ]; then
    if [ -x "$(command -v mvim)" ]; then
        export VISUAL="mvim"
    else
        export VISUAL="${EDITOR}"
        echo "Warning: MacVim not installed"
    fi
else
    if [ -x "$(command -v gvim)" ]; then
        export EDITOR="gvim"
    else
        export VISUAL="${EDITOR}"
        echo "Warning: gvim not installed"
    fi
fi
alias e='${VISUAL}'

# Environment
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
if [ -x "$(command -v mysql)" ]; then
    export PATH=$PATH:/usr/local/mysql/bin
fi
export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:/$HOME/dev/bin"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

# Command prompt
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
    # Remote
    export PS1="\[\e[1;32m\]\u\[\e[m\]\[\e[1;30m\]@\[\e[m\]\[\e[1;33m\]\h\[\e[m\]:\[\e[1;34m\]\W\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\] "
else
    # Local
    export PS1="\[\e[1;32m\]\u\[\e[m\]:\[\e[1;34m\]\W\[\e[m\]\[\e[35m\]\`parse_git_branch\`\[\e[m\] "
fi

# Aliases
alias cdmy='cd $HOME/.my/setup'
alias cdvim='cd $HOME/.vim/'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias evrc='e $HOME/.vimrc'
alias ebp='e $HOME/${BASH_RC}'
alias ebpl='e $HOME/${BASH_RC}_local'
alias sbp='source $HOME/${BASH_RC}'
alias l='ls -alh'
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdbin='cd $HOME/dev/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
if [ -x "$(command -v ranger)" ]; then
    alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
else
    echo "Warning: ranger not installed"
fi
alias scpalt='rsync avzP'
alias grep='grep -E -n --color=auto'
if [ -x "$(command -v ranger)" ]; then
    alias ag='ag --nogroup'
else
    echo "Warning: Ag (the silver searcher) not installed"
fi
if [ -x "$(command -v python3)" ]; then
    alias python='python3'
else
    echo "Warning: Python 3 not installed"
fi
if [ -x "$(command -v make)" ]; then
    alias m='make -j7'
else
    echo "Warning: Make not installed"
fi
if [ -x "$(command -v virtualenv)" ]; then
    alias mkenv='virtualenv -p python3 env'
    alias senv='source env/bin/activate'
else
    echo "Warning: Virtualenv not installed"
fi
if [ -x "$(command -v pygmentize)" ]; then
    alias pcat='pygmentize -O style=native -g'
else
    echo "Warning: Pygmentize not installed"
fi
if [ "${PLATFORM}" == "mac" ]; then
    alias meld='open /Applications/Meld.app'
fi
if [ -x "$(command -v lldb)" ]; then
    function dbg {
        prog=$1
        shift
        if [ ! -f dbg.txt ]; then
            lldb $prog -- $@
        else
            echo "Using dbg.txt"
            lldb -S dbg.txt $prog -- $@
        fi
    }
fi
if [ -x "$(command -v git)" ]; then
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
else
    echo "Warning: Git not installed"
fi

# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#Fzf
if [ -x "$(command -v fzf)" ]; then
    export FZF_CTRL_T_OPTS='--height 90% --preview "pygmentize -l $(pygmentize -N {}) {}"'
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
    echo "Warning: fzf not installed"
fi

# Bash completion
if [ "${PLATFORM}" == "mac" ]; then
	TMP_VAR=`find /usr/local/Cellar/bash-completion/ -name bash_completion | tail -n 1`
	if [ "${TMP_VAR}" != "" ]; then
		. ${TMP_VAR}
	fi
fi

# Invoke completion
if [ -x "$(command -v inv)" ]; then
    source ${HOME}/.my/setup/invoke/bash_completion.sh
else
    echo "Warning: Invoke not installed"
fi

# Local Bash profile
if [ -f "${HOME}/${BASH_RC}_local" ]; then
	source ${HOME}/${BASH_RC}_local
fi
