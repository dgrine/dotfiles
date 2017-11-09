#alias cdbea='cdrepos; cd auro-beautifier'
alias cdc3='cdrepos; cd auro-codec-v3'
alias cdc4='cdrepos; cd auro-codec-v4'
alias cdcx1='cdrepos; cd auro-cx-v1'
alias cdcx2='cdrepos; cd auro-cx-v2'
alias cdam4car='cdrepos; cd fusion-am4car'
alias cdbea4car='cdrepos; cd fusion-bea4car'
alias cdbuilds='cd core-build/cache/cbs/builds'
alias cdmake='cdbuilds; cd make'
alias cdmake-debug='cdmake; cd debug'
alias cdmake-release='cdmake; cd release'
alias cdcb='cd core-build'
alias bs-lin='ssh matlab.auro-technologies.com'
alias bs-mac='ssh 10.0.24.142'
alias docs='open core-build/docs/index.md'

function auro_reload {
    export auro_compiler="${auro_bs}-${auro_tool}-${auro_mode}${auro_postfix}"
}

function cbs {
    export auro_bs="cbs"
    auro_reload
    auro
}

function rbs {
    export auro_bs="rbs"
    auro_reload
    auro
}

function debug {
    export auro_mode="debug"
    auro_reload
    auro
}

function reldeb {
    export auro_mode="debug-release"
    auro_reload
    auro
}

function release {
    export auro_mode="release"
    auro_reload
    auro
}

function noverbose {
    export auro_compiler_verbose=0
}

function verbose {
    export auro_compiler_verbose=1
}

function nortc {
    export auro_postfix=""
    auro_reload
}

function rtc {
    export auro_postfix="-rtc"
    auro_reload
}

function auro {
    echo $auro_compiler
}

function default {
    cbs
    debug
    rtc
    noverbose
}

export auro_tool="clang-x64"
default > /dev/null

function fix-xcode-auro-cli {
    mode='Debug'
    cd core-build/cache/cbs/builds/xcode/${mode}/

    module='core-std'
    echo "Symbolic link for ${module}"
    mkdir -p ${module}/${mode}
    cd ${module}/${mode}
    ln -s ../auro-*.build/${mode}/${module}_C.build/Objects-normal/lib${module}_C.a lib${module}.a
    cd ../..

    module='core-io'
    echo "Symbolic link for ${module}"
    mkdir -p ${module}/${mode}
    cd ${module}/${mode}
    ln -s ../auro-*.build/${mode}/${module}_CXX.build/Objects-normal/lib${module}_CXX.a lib${module}.a
    cd ../..
    
    cd ../../../../../../
}
