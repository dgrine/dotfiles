# Assuming ~/.zshrc only:
# - sets export ZSH="/path/to/oh-my-zsh"
# - sources this file
# Everything else in that file should be commented out

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="arrow"
#ZSH_THEME="clean"
#ZSH_THEME="jonathan"
#ZSH_THEME="mortalscumbag"

plugins=(git web-search pip python rake ruby fabric iterm2 npm brew z docker)

source $ZSH/oh-my-zsh.sh

# Determing OS
if [ "${OSTYPE}" = "darwin17.0" ]; then
    PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin18.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin19.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "darwin20.0" ]; then
	PLATFORM="mac"
elif [ "${OSTYPE}" = "linux-gnu" ]; then
	PLATFORM="linux"
else
	echo "Warning: unsupported platform ${OSTYPE}"
fi

# Environment
export PATH="$PATH:$HOME/dev/repos/setup/bin:$HOME/dev/bin:$HOME/.local/bin:$HOME/.fzf/bin:$HOME/.cargo/bin"
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
fi
alias e='$EDITOR'

# Aliases - configuration
alias conf-alacritty='e $HOME/.config/alacritty/alacritty.yml'
alias conf-nvim='e $HOME/.config/nvim/init.vim'
alias conf-tmux='e $HOME/.tmux.conf'
alias conf-zsh='e $HOME/.zshrc'
alias conf-zsh-local='e $HOME/.zshrc_local'
alias conf-vifm='e $HOME/.config/vifm/vifmrc'
alias source-zsh='source $HOME/.zshrc'

# Aliases - SSH
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'

# Alias ls
if [ -x "$(command -v exa)" ]; then
    alias l='exa -al --color=always --group-directories-first' # my preferred listing
    alias la='exa -a --color=always --group-directories-first'  # all files and dirs
    alias ll='exa -l --color=always --group-directories-first'  # long format
    alias lt='exa -aT --color=always --group-directories-first' # tree listing
else
    alias l='ls -alh'
fi



# Aliases - Navigation
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdsetup='cd $HOME/dev/repos/setup'
alias cdblackboard='cd $HOME/dev/repos/blackboard/'
alias cddocs='cd $HOME/dev/repos/docs'
alias cdbin='cd $HOME/dev/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
#if [ -x "$(command -v ranger)" ]; then
    ## Doing a silly little dance to work-around Ranger using VISUAL instead of EDITOR
    #alias r='TMP=${VISUAL}; export VISUAL=${EDITOR} && ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"; export VISUAL=${TMP}; TMP=""'
#fi
if [ "${PLATFORM}" = "mac" ]; then
    function open() {
        open $1
    }
else
    function open() {
        xdg-open $1 &> /dev/null &
    }
fi

# Aliases - Fun
alias rr='rickroll.sh'

# Navigation
function r() {
    local dst="$(command vifm --choose-dir - "$@" .)"
    if [ -z "$dst" ]; then
        echo "Directory picking cancelled/failed"
        return 1
    fi
    cd "$dst"
}

# rsync
alias scpalt='rsync avzP'

# grep
alias grep='grep -E -n --color=auto'

# Python
if [ -x "$(command -v python3)" ]; then
    alias python='python3'
    alias pip='pip3'
    function menv() {
        python3 -m venv env
        senv
        pip3 install --upgrade pip
        pip3 install neovim black
    }
    function ienv() {
        echo "> Installing requirements.txt"
        pip3 install -r requirements.txt
        if [ -f "requirements-unittest.txt" ]; then
            echo "> Installing requirements-unittest.txt"
            pip3 install -r requirements-unittest.txt
        fi
        if [ -f "requirements-uninstall.txt" ]; then
            echo "> Uninstalling requirements-uninstall.txt"
            pip3 uninstall -y -r requirements-uninstall.txt
        fi
    }
    function senv() {
        source env/bin/activate
    }
    function renv() {
            rm -rf env
    }
    function pip-clear-cache() {
        if [ -d "$HOME/.cache/pip" ]; then
            # Linux
            rm -rf $HOME/.cache/pip
        elif [ -d "$HOME/Library/Caches/pip" ]; then
            # macOS
            rm -rf $HOME/Library/Caches/pip
        fi
    }
    function pip-list() {
        pip3 list -v | grep $1 | cut -d':' -f 2 | awk '{printf("%s %s\n", $1, $3);}'
    }
    export PYTHONBREAKPOINT="pudb.set_trace"
fi

# Docker
alias rmdocker-containers='docker rm -f $(docker ps -a -q)'
alias rmdocker-volumes='docker volume rm $(docker volume ls -q)'
alias rmdocker-clean='rmdocker-containers && rmdocker-volumes'

# Miniconda
if [ -x "$(command -v conda)" ]; then
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
    conda config --set auto_activate_base false
    # On macOS, conda seems to always activate the base environment
    if [ "${PLATFORM}" = "mac" ]; then
        conda deactivate > /dev/null
    fi
fi

# Make
if [ -x "$(command -v make)" ]; then
    alias m='make -j7'
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

# Fzf
if [ -x "$(command -v fzf)" ]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules/*,.git/*}"'

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
    if [ "${PLATFORM}" = "mac" ]; then
        source "/usr/local/opt/fzf/shell/key-bindings.zsh"
        source "/usr/local/opt/fzf/shell/completion.zsh"
    else
        source "/usr/share/fzf/key-bindings.zsh"
        source "/usr/share/fzf/completion.zsh"
    fi
fi

# Launch tmux if it hasn't started yet
if ! pgrep tmux &> /dev/null; then
    if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
        tmux new-session -d -s main
        tmux new-session -d -s blackboard
        tmux new-session -d -s auro
        tmux new-session -d -s eot
        tmux attach -t main
    fi
fi
alias tmux='tmux attach -t main'

# Local zsh customization
if [ -f "${HOME}/.zshrc_local" ]; then
    source ${HOME}/.zshrc_local
fi

#neofetch
