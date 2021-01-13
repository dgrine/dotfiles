alias cdall='cd $HOME/dev/repos/all'

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
    if [ "${auro_vlc}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_vlc
    fi
    if [ "${auro_pic}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_pic
    fi
    if [ "${auro_postfix}" != "" ]
    then
        auro_compiler=$auro_compiler-$auro_postfix
    fi
    export auro_compiler=$auro_compiler
}

function auro-debug {
    export auro_mode="debug"
    auro-set-compiler
    auro
}

function auro-release {
    export auro_mode="release"
    auro-set-compiler
    auro
}
function auro-reldeb {
    export auro_mode="release-debug"
    auro-set-compiler
    auro
}

function auro-noverbose {
    unset auro_verbose
}

function auro-verbose {
    export auro_verbose=1
}

function auro-nortc {
    export auro_rtc=""
    auro-set-compiler
    auro
}

function auro-rtc {
    export auro_rtc="rtc"
    auro-set-compiler
    auro
}

function auro-nojuce {
    export auro_juce=""
    auro-set-compiler
    auro
}
function auro-juce {
    export auro_juce="juce"
    auro-set-compiler
    auro
}

function auro-novlc {
    export auro_vlc=""
    auro-set-compiler
    auro
}
function auro-vlc {
    export auro_vlc="vlc"
    auro-set-compiler
    auro
}

function auro-nopic {
    export auro_pic=""
    auro-set-compiler
    auro
}
function auro-pic {
    export auro_pic="pic"
    auro-set-compiler
    auro
}

function auro {
    echo $auro_compiler
}

function auro-init {
    if command -v clang++ &> /dev/null; then
        export auro_brand="clang"
    else
        export auro_brand="gnu"
    fi
    export auro_arch="x64"
    auro-debug
    auro-rtc
    auro-noverbose
    auro-nojuce
    auro-novlc
    auro-nopic
    export auro_j="40"
}

function auro-list-ut-tags {
    rg -t cpp 'TEST_CASE' -g '*_tests.cpp' | cut -d ',' -f 2 | rg '"\[[a-z_A-Z]+\]' --only-matching | rg '\[[a-z_A-Z]+\]' --only-matching | sort | uniq -c
}

auro-init > /dev/null

