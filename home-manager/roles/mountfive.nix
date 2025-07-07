{ pkgs, ... }:

let M5_NAME = "mountfive"; in {
    programs.zsh = let M5_ROOT = "$HOME/dev/roles/${M5_NAME}"; in {
        initContent = ''
            # Add the root directory
            mkdir -p ${M5_ROOT}

            # Add the repos directory
            mkdir -p ${M5_ROOT}/repos

            # Add the docs directory
            mkdir -p ${M5_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${M5_NAME} &> /dev/null
        '';
        shellAliases = {

        };
    };
}

