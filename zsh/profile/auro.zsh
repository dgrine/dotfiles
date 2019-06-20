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

function auro-bs-ci-lin-gcc-x64 {
    build_id=$1
    build_name="gcc-x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI lin-${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving CI lin-${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-qc-lin-gcc-x64 {
    build_id=$1
    build_name="lin_gcc_x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving QC ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving QC ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-ci-lin-gcc-x86 {
    build_id=$1
    build_name="gcc-x86"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI lin-${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving CI lin-${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-qc-lin-gcc-x86 {
    build_id=$1
    build_name="lin_gcc_x86"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving QC ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving QC ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-ci-mac-x64 {
    build_id=$1
    build_name="mac-x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving CI ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-qc-mac-x64 {
    build_id=$1
    build_name="mac_x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving QC ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving QC ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd} | sed 's/\x1b\[[0-9;]*m//g'"
}
function auro-bs-ci-win-msvc-2017-x64 {
    build_id=$1
    build_name="msvc-2017-x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving CI ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd}"
}
function auro-bs-qc-win-msvc-2017-x64 {
    build_id=$1
    build_name="win_msvc_2017_x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving QC ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving QC ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd}"
}
function auro-bs-ci-win-msvc-2019-x64 {
    build_id=$1
    build_name="msvc-2019-x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving CI ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving CI ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/ci/jobs/ci-toplevel-fusion (${build_name})/branches/CI/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd}"
}
function auro-bs-qc-win-msvc-2019-x64 {
    build_id=$1
    build_name="win_msvc_2019_x64"
    if [ -t 1 ]; then
        cmd_print="tail -f"
    else
        cmd_print="cat"
    fi
    if [[ "${build_id}" == "" ]]; then;
        echo "Retrieving QC ${build_name} log of latest build"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/\" && cd \`ls -t -d */ | head -n 1\` && ${cmd_print} log"
    else
        echo "Retrieving QC ${build_name} log of build ${build_id}"
        cmd="cd \"/var/lib/jenkins/jobs/qc/jobs/qc-toplevel-fusion (${build_name})/builds/${build_id}\" && ${cmd_print} log"
    fi
    ssh auro@matlab.auro-technologies.com "${cmd}"
}

function auro-list-ut-tags {
    rg -t cpp 'TEST_CASE' -g '*_tests.cpp' | cut -d ',' -f 2 | rg '"\[[a-z_A-Z]+\]' --only-matching | rg '\[[a-z_A-Z]+\]' --only-matching | sort | uniq -c
}

auro-init > /dev/null
ccache-set-path
icecream-set-ccache-prefix

