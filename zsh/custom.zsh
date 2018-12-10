# Assuming ~/.zshrc only sets export ZSH="/path/to/oh-my-zsh"
# Sources this file.
# Everything else in that file should be commented out

ZSH_THEME="cypher"

plugins=(git web-search vim pip python rake ruby)

source $ZSH/oh-my-zsh.sh

# Determing OS
if [ "${OSTYPE}" = "darwin17.0" ]
then
    PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin18.0" ]
then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "linux-gnu" ]
then
	PLATFORM="linux"
else
	echo "Error: unsupported platform ${OSTYPE}"
    return
fi

# Editor
export EDITOR="vim -v"
alias ce='$EDITOR'
if [ "${PLATFORM}" = "mac" ]; then
    if [ -x "$(command -v mvim)" ]; then
        export VISUAL="mvim"
    else
        export VISUAL="${EDITOR}"
        echo "Warning: MacVim not installed"
    fi
else
    if [ -x "$(command -v gvim)" ]; then
        export VISUAL="gvim"
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
#export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

# Aliases
alias icecream='export PATH=/usr/local/opt/icecream/libexec/icecc/bin:$PATH'
icecream
#export auro_j=40
alias cdvim='cd $HOME/.vim/'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias evrc='e $HOME/.vimrc'
alias ezrc='e $HOME/dev/repos/setup/zsh/custom.zsh'
alias ezrcl='e $HOME/.zshrc_local'
alias szrc='source $HOME/.zshrc'
alias l='ls -alh'
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdsetup='cdrepos; cd setup'
alias cddocs='cdrepos; cd docs'
alias cdbin='cd $HOME/dev/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
if [ -x "$(command -v ranger)" ]; then
    alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
else
    echo "Warning: ranger not installed"
fi
alias scpalt='rsync avzP'
alias grep='grep -E -n --color=auto'
if [ -x "$(command -v python3)" ]; then
    alias python='python3'
    alias pip='pip3'
    alias mkenv='python3 -m venv env'
    alias senv='source env/bin/activate'
else
    echo "Warning: Python 3 not installed"
fi
if [ -x "$(command -v make)" ]; then
    alias m='make -j7'
else
    echo "Warning: Make not installed"
fi
if [ -x "$(command -v pygmentize)" ]; then
    alias pcat='pygmentize -O style=native -g'
else
    echo "Warning: Pygmentize not installed"
fi
if [ "${PLATFORM}" = "mac" ]; then
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

else
    echo "Warning: Git not installed"
fi

# iTerm shell integration
#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#Vim and Fzf interaction
# vi mode, needs to come before fzf is loaded
bindkey -v
# Edit command line in vim by pressing Esc-v
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

#Fzf
if [ -x "$(command -v fzf)" ]; then
    export FZF_CTRL_T_OPTS='--height 90% --preview "pygmentize -l $(pygmentize -N {}) {}"'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    echo "Warning: fzf not installed"
fi

# Bash completion
#if [ "${PLATFORM}" = "mac" ]; then
	#TMP_VAR=`find /usr/local/Cellar/bash-completion/ -name bash_completion | tail -n 1`
	#if [ "${TMP_VAR}" != "" ]; then
		#. ${TMP_VAR}
	#fi
#fi

# Invoke completion
#if [ -x "$(command -v inv)" ]; then
    #source ${HOME}/dev/repos/setup/invoke/bash_completion.sh
#else
    #echo "Warning: Invoke not installed"
#fi

# Local profile
[ -f "${HOME}/.zshrc_local" ] && source ${HOME}/.zshrc_local
