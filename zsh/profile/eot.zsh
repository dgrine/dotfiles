alias cdsdk='cd $HOME/dev/repos/fusion-wowool-sdk'
alias cdportal='cd $HOME/dev/repos/fusion-portal'

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
               https://nexus.eyeonid.com
index = https://nexus.eyeonid.com/repository/eyeontext-pypi/pypi
extra-index-url = https://nexus.eyeonid.com/repository/eyeontext-pypi/simple

[list]
format=columns
" > pip.conf
}

function eot-menv() {
    python3 -m venv env
    source env/bin/activate
    pip3 config set global.extra-index-url https://${EOT_NEXUS_USERNAME}:${EOT_NEXUS_PASSWORD_ENCODED}@nexus.eyeonid.com/repository/eyeontext-pypi/simple --site
    menv
}
