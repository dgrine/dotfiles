alias cdtop='cdrepos; cd toplevel-fusion'
alias cdcook='cdrepos; cd cook-binary'
alias cdall='cdrepos; cd all'

function auro-set-compiler {
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
    if [ "${auro_juce}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_juce
    fi
    if [ "${auro_postfix}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_postfix
    fi
    export auro_compiler=$auro_compiler
}

function debug {
    export auro_mode="debug"
    auro-set-compiler
    auro
}

function release {
    export auro_mode="release"
    auro-set-compiler
    auro
}
function reldeb {
    export auro_mode="release-debug"
    auro-set-compiler
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
    auro-set-compiler
    auro
}

function rtc {
    export auro_rtc="rtc"
    auro-set-compiler
    auro
}

function nojuce {
    export auro_juce="nojuce"
    auro-set-compiler
    auro
}
function juce {
    export auro_juce=""
    auro-set-compiler
    auro
}

function auro {
    echo $auro_compiler
}

function auro-init {
    if [ "${OSTYPE}" = "linux-gnu" ]; then
        export auro_brand="gcc"
    else
        export auro_brand="clang"
    fi
    export auro_arch="x64"
    debug
    rtc
    noverbose
    nojuce
    export auro_j="40"
}

function auro-list-ut-tags {
    rg -t cpp 'TEST_CASE' -g '*_tests.cpp' | cut -d ',' -f 2 | rg '"\[[a-z_A-Z]+\]' --only-matching | rg '\[[a-z_A-Z]+\]' --only-matching | sort | uniq -c
}

auro-init > /dev/null

