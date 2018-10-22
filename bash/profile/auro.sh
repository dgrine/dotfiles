alias cdcd3='cdrepos; cd auro-codec-v3'
alias cdcd4='cdrepos; cd auro-codec-v4'
alias cdcx1='cdrepos; cd auro-cx-v1'
alias cdcx2='cdrepos; cd auro-cx-v2'
alias cdavs='cdrepos; cd fusion-avs'
alias cdtop='cdrepos; cd toplevel-fusion'
alias cdcook='cdrepos; cd cook-binary'
alias cd548='cdavs; cd story/code548'

function auro_reload {
    export auro_compiler="${auro_brand}-${auro_arch}-${auro_mode}-${auro_rtc}-${auro_postfix}"
}

function debug {
    export auro_mode="debug"
    auro_reload
    auro
}

function release {
    export auro_mode="release"
    auro_reload
    auro
}

function noverbose {
    unset auro_verbose
}

function verbose {
    export auro_verbose=1
}

function nortc {
    export auro_rtc=""
    auro_reload
    auro
}

function rtc {
    export auro_rtc="rtc"
    auro_reload
    auro
}

function auro {
    echo $auro_compiler
}

function default {
    export auro_brand="clang"
    export auro_arch="x64"
    debug
    rtc
    noverbose
    #export auro_compiler="clang-x64"
}

default > /dev/null
