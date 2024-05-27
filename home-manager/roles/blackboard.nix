{ pkgs, ... }:

let BB_NAME = "blackboard"; in {
    imports = [
    ];

    programs.zsh = let BB_ROOT = "$HOME/dev/roles/${BB_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${BB_ROOT}

            # Add the repos directory
            mkdir -p ${BB_ROOT}/repos

            # Add the docs directory
            mkdir -p ${BB_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${BB_NAME} &> /dev/null
        '';
        shellAliases = {

        };
    };
}
