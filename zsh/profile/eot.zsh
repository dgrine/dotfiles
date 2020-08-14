alias cdfusion='cdrepos; cd fusion'

function eot-tir-rebuild {
    unset EOT_KEY
    unset EOT_ROOT

    cdrepos
    cd fusion-wowool-sdk
    senv
    inv pull
    
    cd tir
    inv glf
    inv cpp.config --release
    inv cpp.build/release

    cd ..

    cd stage/lxware
    rm *-entity.dom

    cd ../..

    cd lingware
    inv lid.build
    inv lxcommon.build
    inv english.build

    
    cdfusion
    export EOT_KEY=EOTDEV 
    export EOT_ROOT=~/dev/repos/fusion-wowool-sdk/stage
    senv
    inv pull
    inv comp-wowool-sdk-native-py-cpp.clean
    inv comp-wowool-sdk-native-py-cpp.build
    inv ut
}
