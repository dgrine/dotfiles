# Assuming ~/.zshrc only:
# - sets export ZSH="/path/to/oh-my-zsh"
# - sources this file
# Everything else in that file should be commented out

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gianu"

# Note that fzf must be before vi-mode for <C-t> and <C-r> to work correctly
plugins=(fzf vi-mode git pip python npm brew z docker)

source $ZSH/oh-my-zsh.sh

# Determing OS
if [ "${OSTYPE}" = "linux-gnu" ]; then
    PLATFORM="linux"
else
    PLATFORM="mac"
fi

# Environment
export PATH="$PATH:$HOME/dev/bin"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
#export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

# Git
alias gdt='git difftool'
alias glg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias gitsm='smartgit . &> /dev/null  &'

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
alias conf-nvim='e $HOME/.config/nvim/init.lua'
alias conf-nvim-mappings='e $HOME/.config/nvim/lua/mappings.lua'
alias conf-nvim-plugins='e $HOME/.config/nvim/lua/plugins.lua'
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
alias cddotfiles='cd $HOME/dotfiles'
alias cddev='cd $HOME/dev'
alias cdrepos='cd $HOME/dev/repos'
alias cdbin='cd $HOME/dev/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
if [ "${PLATFORM}" = "linux" ]; then
    function open() {
        xdg-open $1 &> /dev/null &
    }
fi

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
        python3 -m venv .venv
        senv
        pip3 install --upgrade pip
        pip3 install neovim black debugpy
    }
    function senv() {
        source .venv/bin/activate
    }
    function renv() {
            rm -rf .venv
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
    #export PYTHONBREAKPOINT="pudb.set_trace"
fi

# Docker
alias rmdocker-containers='docker rm -f $(docker ps -a -q)'
alias rmdocker-volumes='docker volume rm $(docker volume ls -q)'
alias rmdocker-clean='rmdocker-containers && rmdocker-volumes'

# Make
if [ -x "$(command -v make)" ]; then
    alias m='make -j32' # I've got a lot of cores :-)
fi

# pdf-reduce
function pdf-reduce() {
    if [ $# -lt 2 ]; then
        echo "error: input and output file are required"
        echo "usage: pdf-reduce input.pdf output.pdf"
        exit 1
    else
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$2 $1
    fi
}

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

# Bat (the cat alternative)
if [ -x "$(command -v bat)" ] || [ -x "$(command -v batcat)" ]; then
    export BAT_THEME="ansi"
fi


# Allow zsh nvim command line editing
autoload -U edit-command-line
zle -N edit-command-line 
bindkey -M vicmd v edit-command-line

# zsh completion
source ${HOME}/.zsh_completion.zsh

# Vi mode in zsh
bindkey -v

# Fzf
if [ -x "$(command -v fzf)" ]; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{node_modules/*,.git/*,.venv/*}"'
    if [ -x "$(command -v bat)" ]; then
        export FZF_PREVIEW_COMMAND="bat"
    elif [ -x "$(command -v batcat)" ]; then
        export FZF_PREVIEW_COMMAND="batcat"
    else
        export FZF_PREVIEW_COMMAND="cat"
    fi
    export FZF_PREVIEW_COMMAND="$FZF_PREVIEW_COMMAND --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
    export FZF_CTRL_T_OPTS="--min-height 30 --preview-window right:60% --preview-window noborder --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"

    # Fzf interaction 
    bindkey '^y' fzf-cd-widget

    # Edit command line in vim by pressing Esc-v
    zle -N edit-command-line
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    if [ "${PLATFORM}" = "mac" ]; then
        source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
        source "/opt/homebrew/opt/fzf/shell/completion.zsh"
    else
        source ~/.fzf/shell/key-bindings.zsh
    fi
fi

# Local zsh customization
# zsh profiles can extend sessions by appending to the following array
declare -a DOTFILES_TMUX_SESSIONS
DOTFILES_TMUX_SESSIONS=("main")
if [ -f "${HOME}/.zshrc_local" ]; then
    source ${HOME}/.zshrc_local
fi

# Tmux dev environment
function devenv() {
    if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
        pkill tmux; sleep 1;
        for SESSION in $DOTFILES_TMUX_SESSIONS; do
            tmux new-session -d -s $SESSION
        done
        tmux attach -t main
    fi
}

# Launch tmux if it hasn't started yet
if ! pgrep tmux &> /dev/null; then
    devenv
fi

# unfunction _bat
