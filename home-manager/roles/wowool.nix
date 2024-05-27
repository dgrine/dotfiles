{ pkgs, ... }:

let WOWOOL_NAME = "wowool"; in {
    programs.zsh = let WOWOOL_ROOT = "$HOME/dev/roles/${WOWOOL_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${WOWOOL_ROOT}

            # Add the repos directory
            mkdir -p ${WOWOOL_ROOT}/repos

            # Add the docs directory
            mkdir -p ${WOWOOL_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${WOWOOL_NAME} &> /dev/null
        '';
        profileExtra = ''
            function wowool-senv() {
                senv
                export CODEARTIFACT_AUTH_TOKEN=`aws codeartifact get-authorization-token --domain wowool --domain-owner 941166921781 --region eu-west-1 --query authorizationToken --output text`
                pip3 config --site set global.extra-index-url https://aws:$CODEARTIFACT_AUTH_TOKEN@wowool-941166921781.d.codeartifact.eu-west-1.amazonaws.com/pypi/wowool/simple/
            }

            function wowool-menv() {
                python3 -m venv .venv
                wowool-senv
                pip3 install --upgrade pip
            }
        '';
    };
}

