# Assuming ~/.zshrc only sets export ZSH="/path/to/oh-my-zsh"
# Sources this file.
# Everything else in that file should be commented out

ZSH_THEME="arrow"

plugins=(git web-search vim pip python rake ruby fabric iterm2 npm brew z docker)

source $ZSH/oh-my-zsh.sh

# Determing OS
if [ "${OSTYPE}" = "darwin17.0" ]; then
    PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin18.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "linux-gnu" ]; then
	PLATFORM="linux"
else
	echo "Error: unsupported platform ${OSTYPE}"
    return
fi

# Environment
export PATH="$PATH:$HOME/dev/bin:$HOME/.local/bin"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
#export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

# Editor
if [ -x "$(command -v nvim)" ]; then
    export EDITOR="nvim"
elif [ -x "$(command -v vim)" ]; then
    export EDITOR="vim -v"
elif [ -x "$(command -v pico)" ]; then
    export EDITOR="pico"
elif [ -x "$(command -v nano)" ]; then
    export EDITOR="nano"
else
    echo "Warning: no suitable editor available"
fi
alias e='$EDITOR'

# Visual editor
if [ "${PLATFORM}" = "mac" ]; then
    if [ -x "$(command -v vimr)" ]; then
        export VISUAL="vimr"
    elif [ -x "$(command -v mvim)" ]; then
        export VISUAL="mvim"
    else
        export VISUAL="${EDITOR}"
        echo "Warning: VimR or MacVim not installed"
    fi
else
    if [ -x "$(command -v gvim)" ]; then
        export VISUAL="gvim"
    else
        export VISUAL="${EDITOR}"
        echo "Warning: gvim not installed"
    fi
fi
alias ve='${VISUAL}'

# General aliases
alias evrc='e $HOME/.vimrc'
alias etcnf='e $HOME/.tmux.conf'
alias ezrc='e $HOME/dev/repos/setup/zsh/custom.zsh'
alias ezrcl='e $HOME/.zshrc_local'
alias szrc='source $HOME/.zshrc'
alias cdvim='cd $HOME/.vim/'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias l='ls -alh'
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdsetup='cdrepos; cd setup'
alias cddocs='cdrepos; cd docs'
alias cdbin='cd $HOME/dev/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
if [ -x "$(command -v ranger)" ]; then
    # Doing a silly little dance to work-around Ranger using VISUAL instead of EDITOR
    alias r='TMP=${VISUAL}; export VISUAL=${EDITOR} && ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"; export VISUAL=${TMP}; TMP=""'
else
    echo "Warning: ranger not installed"
fi
alias scpalt='rsync avzP'
alias grep='grep -E -n --color=auto'

# Python
if [ -x "$(command -v python3)" ]; then
    alias python='python3'
    alias pip='pip3'
    alias mkenv='python3 -m venv env'
    alias senv='source env/bin/activate'
else
    echo "Warning: Python 3 not installed"
fi

# Miniconda
__conda_setup="$(CONDA_REPORT_ERRORS=false '$HOME/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

# Make
if [ -x "$(command -v make)" ]; then
    alias m='make -j7'
else
    echo "Warning: Make not installed"
fi

# Pygmentize and pcat
if [ -x "$(command -v pygmentize)" ]; then
    alias pcat='pygmentize -O style=vim -g'
else
    echo "Warning: Pygmentize not installed"
fi

# Meld
if [ "${PLATFORM}" = "mac" ]; then
    alias meld='open /Applications/Meld.app'
fi

# lldb
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

# Git
if [ ! -x "$(command -v git)" ]; then
    echo "Warning: Git not installed"
fi

# ccache
alias ccache-set-path='export PATH=/usr/local/opt/ccache/libexec:$PATH'

# icecream
if [ -x "/usr/local/opt/icecream/sbin/iceccd" ]; then
    alias icecream-start-daemon='/usr/local/opt/icecream/sbin/iceccd -vvv'
    alias icecream-set-ccache-prefix='export CCACHE_PREFIX=icecc'
    # To start the monitor, for example: icemon -s matlab 
fi

# Fzf
if [ -x "$(command -v fzf)" ]; then
    # Vim and Fzf interaction: vi mode, needs to come before fzf is loaded
    bindkey -v
    # Edit command line in vim by pressing Esc-v
    zle -N edit-command-line
    bindkey -M vicmd v edit-command-line
    export FZF_CTRL_T_OPTS='--height 90% --preview "pygmentize -l $(pygmentize -N {}) {}"'
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    echo "Warning: fzf not installed"
fi

# zsh completion
source ${HOME}/dev/repos/setup/invoke/zsh_completion.zsh

# Local profile
[ -f "${HOME}/.zshrc_local" ] && source ${HOME}/.zshrc_local
