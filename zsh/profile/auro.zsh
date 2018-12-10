alias cdcd3='cdrepos; cd auro-codec-v3'
alias cdcd4='cdrepos; cd auro-codec-v4'
alias cdcx1='cdrepos; cd auro-cx-v1'
alias cdcx2='cdrepos; cd auro-cx-v2'
alias cdavs='cdrepos; cd fusion-avs'
alias cdtop='cdrepos; cd toplevel-fusion'
alias cdcook='cdrepos; cd cook-binary'
alias cd548='cdavs; cd story/code548'

function auro_init {
    auro_compiler=""
    if [ "${auro_brand}" != "" ]
    then
        auro_compiler=$auro_brand
    else
        echo "Error: Auro brand not set (e.g. clang, or gcc, ...)"
    fi
    if [ "${auro_arch}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_arch
    else
        echo "Error: Auro architecture not set (e.g. x64)"
    fi
    if [ "${auro_mode}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_mode
    else
        echo "Error: Auro mode not set (e.g. debug, release)"
    fi
    if [ "${auro_rtc}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_rtc
    fi
    if [ "${auro_postfix}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_postfix
    fi
    export auro_compiler=$auro_compiler
    export auro_j="8"
}

function debug {
    export auro_mode="debug"
    auro_init
    auro
}

function release {
    export auro_mode="release"
    auro_init
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
    auro_init
    auro
}

function rtc {
    export auro_rtc="rtc"
    auro_init
    auro
}

function auro {
    echo $auro_compiler
}

function default {
    if [ "${OSTYPE}" = "linux-gnu" ]; then
        export auro_brand="gcc"
    else
        export auro_brand="clang"
    fi
    export auro_arch="x64"
    debug
    rtc
    noverbose
}

default > /dev/null

