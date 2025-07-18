{ pkgs, ... }:

let ARCOLE_NAME = "arcole"; in {
    programs.zsh = let ARCOLE_ROOT = "$HOME/dev/roles/${ARCOLE_NAME}"; in {
        initContent = ''
            # Add the root directory
            mkdir -p ${ARCOLE_ROOT}

            # Add the repos directory
            mkdir -p ${ARCOLE_ROOT}/repos

            # Add the docs directory
            mkdir -p ${ARCOLE_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${ARCOLE_NAME} &> /dev/null
        '';
    };
}

