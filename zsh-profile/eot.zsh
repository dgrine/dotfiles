# Extending a tmux session
DOTFILES_TMUX_SESSIONS+=('eot')

# Aliases
alias conf-zsh-eot='e $HOME/dotfiles/zsh-profile/eot.zsh'
alias cdbrext='cd $HOME/dev/repos/eyeontext/breach-extractor'
alias cdportal-app='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-app'
alias cdportal-test='cd $HOME/dev/repos/eyeontext/test-wowool-portal'
alias cdportal-backend='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-backend-py'
alias cdportal-client='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-client-py'
alias cdportal-frontend='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-frontend-js'
alias cdportal-lxware='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-lxware'
alias cdportal-sdk='cd $HOME/dev/repos/eyeontext/comp-wowool-portal-sdk-py'
alias cdwowool-docs='cd $HOME/dev/repos/eyeontext/wowool-docs'
alias eot-kubectl="kubectl -n eyeontext-portal"
alias eot-ssh-devserver='ssh -vv -i ${HOME}/dev/repos/blackboard/docs/docs-eot/data/debian-buildserver.pem dev@3.64.83.152'
alias eot-ssh-devserver-root='ssh -i ${HOME}/dev/repos/blackboard/docs/docs-eot/data/debian-buildserver.pem ubuntu@3.64.83.152'
alias eot-ssh-buildserver-root='ssh -vv -i ${HOME}/dev/repos/docs/docs-eot/data/debian-buildserver.pem builder@ec2-35-158-194-216.eu-central-1.compute.amazonaws.com'
alias eot-ssh-breachserver='ssh djgr@44.206.52.68'
alias eot-sshfs-breachserver='sudo mkdir -p /mnt/eot-breachserver && sudo sshfs -o debug,allow_other,IdentityFile=/home/djamelg/.ssh/id_rsa,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.206.52.68:/ /mnt/eot-breachserver'
alias 'eot-brext-markers'='rg "(([A-Z][a-z]+)+Marker)" -o --no-heading | cut -d: -f2 | sort | uniq'
alias 'eot-brext-values'='rg "(([A-Z][a-z]+)+Value)" -o --no-heading | cut -d: -f2 | sort | uniq'

function eot-rebuild-tir {
    unset EOT_KEY
    unset EOT_ROOT

    cdsdk
    senv
    inv pull
    
    cd tir
    inv glf
    inv cpp.config --release
    inv cpp.build/release

    cd ..

    cd stage/lxware
    #rm *-entity.dom

    cd ../..

    cd lingware
    inv lid.build
    inv lxcommon.build
    inv english.build-entity
    inv english.build-entity-extended
}

function eot-create-pip-conf() {
    echo "# Do not edit this file directly
# Generated by setup/zsh/profile/eot.zsh:eot-pip-conf
[global]
trusted-host = https://pypi.org/simple
               https://$EOT_NEXUS_USERNAME:$EOT_NEXUS_PASSWORD@nexus.eyeonid.com
index = https://$EOT_NEXUS_USERNAME:$EOT_NEXUS_PASSWORD@nexus.eyeonid.com/repository/eyeontext-pypi/pypi
extra-index-url = https://$EOT_NEXUS_USERNAME:$EOT_NEXUS_PASSWORD@nexus.eyeonid.com/repository/eyeontext-pypi/simple

[list]
format=columns
" > .venv/pip.conf
}

function eot-menv() {
    python3 -m venv .venv
    source .venv/bin/activate
    pip3 config set global.extra-index-url https://${EOT_NEXUS_USERNAME}:${EOT_NEXUS_PASSWORD_ENCODED}@repo.eyeontext.com/repository/eyeontext-pypi/simple --site
    menv
}
function eot-menv-release() {
    eot-menv
    senv
    if [ -f "install_requires.txt" ]; then
        echo "Installing install_requires.txt"
        pip3 install -r install_requires.txt
    fi
    if [ -f "install_requires_eot.txt" ]; then
        echo "Installing install_requires_eot (releases).txt"
        pip3 install -r install_requires_eot.txt
    fi
    if [ -f "dev_requires.txt" ]; then
        echo "Installing dev_requires.txt"
        pip3 install -r dev_requires.txt
    fi
    if [ -f "dev_requires_eot.txt" ]; then
        echo "Installing dev_requires_eot (releases).txt"
        pip3 install -r dev_requires_eot.txt
    fi
    if [ -f "build_requires.txt" ]; then
        echo "Installing build_requires.txt"
        pip3 install -r build_requires.txt
    fi
    if [ -f "build_requires_eot.txt" ]; then
        echo "Installing build_requires_eot (releases).txt"
        pip3 install -r build_requires_eot.txt
    fi
}
function eot-menv-dev() {
    echo "Installing development environment"
    eot-menv
    senv
    if [ -f "install_requires.txt" ]; then
        echo "Installing install_requires.txt"
        pip3 install -r install_requires.txt
    else
        echo "Skipping install_requires.txt"
    fi
    if [ -f "install_requires_eot.txt" ]; then
        echo "Installing install_requires_eot (pre-releases).txt"
        pip3 install --pre -r install_requires_eot.txt
    else
        echo "Skipping install_requires_eot.txt"
    fi
    if [ -f "dev_requires.txt" ]; then
        echo "Installing dev_requires.txt"
        pip3 install -r dev_requires.txt
    else
        echo "Skipping dev_requires.txt"
    fi
    if [ -f "dev_requires_eot.txt" ]; then
        echo "Installing dev_requires_eot (pre-releases).txt"
        pip3 install --pre -r dev_requires_eot.txt
    else
        echo "Skipping dev_requires_eot.txt"
    fi
    if [ -f "build_requires.txt" ]; then
        echo "Installing build_requires.txt"
        pip3 install -r build_requires.txt
    else
        echo "Skipping build_requires.txt"
    fi
    if [ -f "build_requires_eot.txt" ]; then
        echo "Installing build_requires_eot (pre-releases).txt"
        pip3 install --pre -r build_requires_eot.txt
    else
        echo "Skipping build_requires_eot.txt"
    fi
}
function eot-ienv() {
    senv
    echo "Installing pre-releases listed in install_requires_eot.txt"
    pip3 install --pre -r install_requires_eot.txt
    echo "Install stable releases listed in install_requires.txt"
    pip3 install -r install_requires.txt
    echo "Installing pre-releases listed in dev_requires_eot.txt"
    pip3 install --pre -r dev_requires_eot.txt
    echo "Install stable releases listed in dev_requires.txt"
    pip3 install -r dev_requires.txt
    echo "Installing pre-releases listed in build_requires_eot.txt"
    pip3 install --pre -r build_requires_eot.txt
    echo "Install stable releases listed in build_requires.txt"
    pip3 install -r build_requires.txt
}

