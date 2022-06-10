# Assuming ~/.zshrc only:
# - sets export ZSH="/path/to/oh-my-zsh"
# - sources this file
# Everything else in that file should be commented out

export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="arrow"
ZSH_THEME="clean"

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
export PATH="$PATH:$HOME/dev/repos/setup/bin:$HOME/dev/bin:$HOME/.local/bin:$HOME/.fzf/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/3.0.0/bin"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
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
alias conf-coc='e $HOME/dev/repos/setup/nvim/coc-settings.json'
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
        pip3 install neovim black pudb
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
    alias m='make -j32'
fi

# C++
if [ -x "$(command -v cpp)" ]; then
    function cpp-create() {
        # CMakeLists.txt
        cat <<EOT > CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
project(app)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
enable_testing()
add_subdirectory(lib)
add_subdirectory(ut)
EOT

        # .gitignore
        cat <<EOT > .gitignore
build/
.vscode
.ccls-*
.clang-format
compile_commands.json
EOT

        # .vscode/launch.json
        mkdir -p .vscode/
        cat <<EOT > .vscode/launch.json
{
    "version": "0.2.0",
    "configurations": [
        {
            "type": "lldb",
            "request": "launch",
            "name": "app",
            "program": "`pwd`/build/debug/ut/app_ut",
            "env": {
                "ASAN_OPTIONS=detect_leaks": "0"
            },
            "args": [],
            "cwd": "`app`"
        }
    ]
}
EOT

        # extern
        mkdir -p extern/doctest/public/doctest
        cd extern/doctest/public/doctest
        curl -O -j https://raw.githubusercontent.com/onqtam/doctest/master/doctest/doctest.h
        cd ../../../..

        # lib
        mkdir -p lib/public/app
        mkdir -p lib/private/app
        cd lib
        # lib/CMakeLists.txt
        cat <<EOT > CMakeLists.txt
set(appLibrarySources "private/app/hello_world.cpp")
add_library(app_lib \${appLibrarySources})
target_include_directories(app_lib
    PUBLIC public/
    PRIVATE private/
)
EOT
        # lib/public/app/hello_world.hpp
        cat <<EOT > public/app/hello_world.hpp
void hello_world();
EOT
        # lib/private/app/hello_world.cpp
        cat <<EOT > private/app/hello_world.cpp
#include <iostream>

void hello_world()
{
    std::cout << "Unit-test\n";
}
EOT
        cd ..

        # ut
        mkdir -p ut/private
        cd ut
        # ut/CMakeLists.txt
        cat <<EOT > CMakeLists.txt
set(appUnitTestSources "private/main.cpp")
add_executable(app_ut \${appUnitTestSources})
target_link_libraries(app_ut PUBLIC app_lib)
target_include_directories(app_ut PRIVATE ../extern/doctest/public)
target_compile_definitions(app_ut PRIVATE DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN)

add_test(NAME ut COMMAND app_ut)
EOT
        # ut/private/main.cpp
        cat <<EOT > private/main.cpp
#include <app/hello_world.hpp>
#include <doctest/doctest.h>

TEST_CASE("unit-test")
{
    hello_world();
}
EOT
        cd ..
        cpp-configure
    }

    function cpp-configure() {
        cpp-clean()
        local dir=""

        dir="build/debug-rtc-address"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../toolchain/clang.cmake -DBB_RTC=address
        cd ../..

        dir="build/debug"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../toolchain/clang.cmake
        cd ../..

        dir="build/reldeb-rtc-address"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_TOOLCHAIN_FILE=../../toolchain/clang.cmake -DBB_RTC=address
        cd ../..

        dir="build/release"
        echo "Configuring $dir"
        rm -rf ${dir}
        mkdir -p ${dir}
        cd ${dir}
        cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../../toolchain/clang.cmake
        cd ../..

        # .clang-complete
        ln -sf ~/dev/repos/setup/clang-format/.clang-format
        python3 ~/dev/repos/setup/coc/generate_compile_commands.py
    }

    function cpp-build() {
        if [ $# -lt 1 ]; then
            echo "error: build dir must be specified"
            ls build/
            echo "usage: cpp-build build/debug-rtc-address"
            exit 1
        else
            local dir="$1"
            echo "Building ${dir}"
            cd $dir && make -j32
            cd -
        fi
    }

    function cpp-clean() {
        rm -rf build/
    }
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

# icecream
if [ "${PLATFORM}" = "mac" ]; then
    alias icecream-start-daemon='/usr/local/opt/icecream/sbin/iceccd -vvv'
    alias icecream-set-ccache-prefix='export CCACHE_PREFIX=icecc'
    #alias ccache-set-path='export PATH=/usr/local/opt/ccache/libexec:$PATH'
else
    export CCACHE_PREFIX=/usr/lib/icecream/bin/icecc
    export PATH="/usr/lib/ccache/bin:$PATH"
fi

# LateX
export TEXLIVE_PATH='/usr/share/texmf-dist/scripts/texlive'

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
        source ~/.fzf/shell/key-bindings.zsh
        # source "/usr/share/fzf/shell/key-bindings.zsh"
        # source /usr/share/doc/fzf/examples/key-bindings.zsh
        #source "/usr/share/fzf/shell/completion.zsh"
    fi
fi

function launch_tmux() {
    if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
        tmux new-session -d -s main
        tmux new-session -d -s blackboard
        tmux new-session -d -s eot
        tmux attach -t main
    fi
}
# Launch tmux if it hasn't started yet
if ! pgrep tmux &> /dev/null; then
    launch_tmux
fi
alias tmux='tmux attach -t main'

# Local zsh customization
if [ -f "${HOME}/.zshrc_local" ]; then
    source ${HOME}/.zshrc_local
fi

# Allow zsh nvim command line editing
autoload -U edit-command-line
zle -N edit-command-line 
bindkey -M vicmd v edit-command-line

#neofetch

