# .zshrc
# zsh configuration file

###############################################################################
# General
###############################################################################

# Platform
if [ "${OSTYPE}" = "linux-gnu" ]; then
    PLATFORM="linux"
else
    PLATFORM="mac"
fi

# Path
#TODO: check if this shouldn't be .local/bin (like where Python installs)
export PATH="$PATH:$HOME/bin"

###############################################################################
# Shell
###############################################################################

# UI
ZSH_THEME="gianu"
if [ "${PLATFORM}" = "mac" ]; then
    export CLICOLOR=1
fi

# Plugins
# Note that fzf must be before vi-mode for <C-t> and <C-r> to work correctly
plugins=(fzf vi-mode git pip python npm brew z docker kubectl)

# Paths
export ZSH="$HOME/.oh-my-zsh"
if [ -d "$HOME/.fzf/shell/" ]; then
    export FZF_BASE="$HOME/.fzf/"
elif [ -d "/usr/share/doc/fzf/examples/" ]; then
    export FZF_BASE="/usr/share/doc/fzf/examples/"
elif [ -d "/usr/local/opt/fzf/shell/" ]; then
    export FZF_BASE="/usr/local/opt/fzf/shell/"
elif [ -d "/opt/homebrew/opt/fzf/shell/" ]; then
    export FZF_BASE="/opt/homebrew/opt/fzf/shell/"
fi

source $ZSH/oh-my-zsh.sh
#
# Completion
source ${HOME}/.zsh_completion.zsh

# VI command line editing
autoload -U edit-command-line
zle -N edit-command-line 
bindkey -M vicmd v edit-command-line
bindkey -v

###############################################################################
# Configuration
###############################################################################
alias conf-alacritty='e $HOME/.config/alacritty/alacritty.yml'
alias conf-nvim='e $HOME/.config/nvim/init.lua'
alias conf-nvim-mappings='e $HOME/.config/nvim/lua/mappings.lua'
alias conf-nvim-plugins='e $HOME/.config/nvim/lua/plugins.lua'
alias conf-tmux='e $HOME/.tmux.conf'
alias conf-git='e $HOME/.gitconfig'
alias conf-zsh='e $HOME/.zshrc'
alias conf-zsh-local='e $HOME/.zshrc_local'
alias conf-vifm='e $HOME/.config/vifm/vifmrc'
alias source-zsh='source $HOME/.zshrc'

###############################################################################
# Editing
###############################################################################
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

# Bat (the cat alternative)
if [ -x "$(command -v bat)" ] || [ -x "$(command -v batcat)" ]; then
    export BAT_THEME="ansi"
fi

###############################################################################
# Navigation
###############################################################################

# Aliases
alias cddotfiles='cd $HOME/dotfiles'
alias cddev='cd $HOME/dev'
alias cdcode='cd $HOME/dev/code'
alias cdbin='cd $HOME/bin'
alias cdtmp='mkdir -p $HOME/dev/tmp && cd $HOME/dev/tmp';
if [ "${PLATFORM}" = "linux" ]; then
    function open() {
        xdg-open $1 &> /dev/null &
    }
fi

# Vifm
function r() {
    local dst="$(command vifm --choose-dir - "$@" .)"
    if [ -z "$dst" ]; then
        echo "Directory picking cancelled/failed"
        return 1
    fi
    cd "$dst"
}

# Listing
if [ -x "$(command -v exa)" ]; then
    alias l='exa -al --icons --color=always --group-directories-first' # my preferred listing
else
    alias l='ls -alh'
fi
export LSCOLORS=GxFxCxDxBxegedabagaced

# SSH
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'

###############################################################################
# Versioning
###############################################################################
# Git
alias gdt='git difftool'
alias gdtui='git difftool --tool meld'
# see `git help log` for detailed help.
#   %h: abbreviated commit hash
#   %d: ref names, like the --decorate option of git-log(1)
#   %cn: commiter name
#   %ce: committer email
#   %cr: committer date, relative
#   %ci: committer date, ISO 8601-like format
#   %an: author name
#   %ae: author email
#   %ar: author date, relative
#   %ai: author date, ISO 8601-like format
#   %s: subject
alias glg='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ai)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias gurl='git remote -v | cut -d: -f2 | cut -d"(" -f1 | uniq'

###############################################################################
# Coding
###############################################################################

# Python
if [ -x "$(command -v python3)" ]; then
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
        if [ "${PLATFORM}" = "mac" ]; then
            rm -rf $HOME/Library/Caches/pip
        else
            rm -rf $HOME/.cache/pip
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
alias rmdocker-images='docker rmi -f $(docker images -aq)'
alias rmdocker-clean='rmdocker-containers && rmdocker-volumes'

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

###############################################################################
# Searching
###############################################################################

# grep
alias grep='grep -E -n --color=auto'

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
    source "$FZF_BASE/key-bindings.zsh"
    source "$FZF_BASE/completion.zsh"
fi

###############################################################################
# Localization
# -- zsh profiles can extend sessions by appending to the following array
###############################################################################

declare -a DOTFILES_TMUX_SESSIONS
DOTFILES_TMUX_SESSIONS=("main")
if [ -f "${HOME}/.zshrc_local" ]; then
    source ${HOME}/.zshrc_local
fi

# Tmux
function devenv() {
    if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
        pkill tmux; sleep 1;
        for SESSION in $DOTFILES_TMUX_SESSIONS; do
            tmux new-session -d -s $SESSION
        done
        tmux attach -t main
    fi
}
if ! pgrep tmux &> /dev/null; then
    devenv
fi

