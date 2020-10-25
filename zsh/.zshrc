# Assuming ~/.zshrc only sets export ZSH="/path/to/oh-my-zsh"
# Sources this file.
# Everything else in that file should be commented out

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="arrow"

plugins=(git web-search pip python rake ruby fabric iterm2 npm brew z docker)

source $ZSH/oh-my-zsh.sh

# Determing OS
if [ "${OSTYPE}" = "darwin17.0" ]; then
    PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin18.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin19.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "linux-gnu" ]; then
	PLATFORM="linux"
else
	echo "Error: unsupported platform ${OSTYPE}"
    return
fi

# Environment
export PATH="$PATH:$HOME/dev/bin:$HOME/.local/bin:$HOME/.fzf/bin"
if [ "${PLATFORM}" = "mac" ]; then
    export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
fi
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
    export EDITOR="vim"
elif [ -x "$(command -v pico)" ]; then
    export EDITOR="pico"
elif [ -x "$(command -v nano)" ]; then
    export EDITOR="nano"
else
    echo "Warning: no suitable editor available"
fi
alias e='$EDITOR'

# General aliases
alias conf-nvim='e $HOME/.vimrc'
alias conf-tmux='e $HOME/.tmux.conf'
alias conf-zsh='e $HOME/.zshrc'
alias conf-zsh-local='e $HOME/.zshrc_local'
alias source-zsh='source $HOME/.zshrc'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias l='ls -alh'
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdsetup='cd $HOME/dev/repos/setup'
alias cddocs='cd $HOME/dev/repos/docs'
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
alias gdt='git difftool'

# Python
if [ -x "$(command -v python3)" ]; then
    alias python='python3'
    alias pip='pip3'
    alias senv='source env/bin/activate && if [ -f "requirements.txt" ]; then pip3 install -r requirements.txt; else touch requirements.txt; fi'
    alias mkenv='python3 -m venv env && senv && pip install --upgrade pip'
else
    echo "Warning: Python 3 not installed"
fi

# Miniconda
# Note: Output from conda init zsh, but moved to this location instead of end of this file
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup=$("$HOME/dev/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)
if [ $? -eq 0 ]; then
    eval "$__conda_setup" 2>/dev/null
else
    if [ -f "$HOME/dev/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/dev/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/dev/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# Prevent conda from automatically activating base environment (writes to .condarc)
if [ -x "$(command -v conda)" ]; then
    conda config --set auto_activate_base false
fi
# On macOS, conda seems to always activate the base environment
if [ "${PLATFORM}" = "mac" ]; then
    conda deactivate > /dev/null
fi

# Make
if [ -x "$(command -v make)" ]; then
    alias m='make -j7'
else
    echo "Warning: Make not installed"
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

# icecream
if [ "${PLATFORM}" = "mac" ]; then
    alias icecream-start-daemon='/usr/local/opt/icecream/sbin/iceccd -vvv'
    alias icecream-set-ccache-prefix='export CCACHE_PREFIX=icecc'
    #alias ccache-set-path='export PATH=/usr/local/opt/ccache/libexec:$PATH'
else
    export CCACHE_PREFIX=/usr/lib/icecream/bin/icecc
    export PATH="/usr/lib/ccache/bin:$PATH"
fi

# zsh completion
source ${HOME}/dev/repos/setup/invoke/zsh_completion.zsh

# Hostname profile and then local profile
if [ -f "${HOME}/.zshrc_local" ]; then
    source ${HOME}/.zshrc_local
fi

# Fzf
# Note: this really must be the last thing loaded
if [ -x "$(command -v fzf)" ]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'

    # Vim and Fzf interaction: vi mode, needs to come before fzf is loaded
    bindkey -v
    bindkey '^y' fzf-cd-widget

    # Edit command line in vim by pressing Esc-v
    zle -N edit-command-line
    #bindkey -M vicmd v edit-command-line
    if [ -x "$(command -v pygmentize)" ]; then
        export FZF_CTRL_T_OPTS='--height 90% --preview "pygmentize -l $(pygmentize -N {}) {}"'
    else
        export FZF_CTRL_T_OPTS='--height 90% --preview "cat {}"'
    fi
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
    echo "Warning: fzf not installed"
fi

