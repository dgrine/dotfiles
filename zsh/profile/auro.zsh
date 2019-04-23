alias cdcd3='cdrepos; cd auro-codec-v3'
alias cdcd4='cdrepos; cd auro-codec-v4'
alias cdcx1='cdrepos; cd auro-cx-v1'
alias cdcx2='cdrepos; cd auro-cx-v2'
alias cdavs='cdrepos; cd fusion-avs'
alias cdtop='cdrepos; cd toplevel-fusion'
alias cdcook='cdrepos; cd cook-binary'
alias cd548='cdavs; cd story/code548'

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
    export auro_j="40"
}

auro-init > /dev/null

ccache-set-path
icecream-set-ccache-prefix

function auro-log-bs-ci-lin-gcc-x64 {
    build_id=$1
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI lin-gcc-x64 log of latest build"
        cmd='cd "/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (gcc-x64)/branches/CI/builds/" && cd `ls -t -d */ | head -n 1` && cat log'
    else
        echo "Retrieving CI lin-gcc-x64 log of build #{build_id}"
        cmd='cd "/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (gcc-x64)/branches/CI/builds/${build_id}" && cat log'
    fi
    ssh auro@matlab "$cmd"
}
function auro-log-bs-ci-lin-gcc-x86 {
    build_id=$1
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI lin-gcc-x86 log of latest build"
        cmd='cd "/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (gcc-x86)/branches/CI/builds/" && cd `ls -t -d */ | head -n 1` && cat log'
    else
        echo "Retrieving CI lin-gcc-x86 log of build #{build_id}"
        cmd='cd "/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (gcc-x86)/branches/CI/builds/${build_id}" && cat log'
    fi
    ssh auro@matlab "$cmd"
}
