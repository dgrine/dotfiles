{ pkgs, ... }:

let EZPADA_NAME = "ezpada"; in {
    imports = [
        ../programs/ccls/ccls.nix
        ../programs/cmake/cmake.nix
    ];

    programs.zsh = let EZPADA_ROOT = "$HOME/dev/"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${EZPADA_ROOT}

            # Add the repos directory
            mkdir -p ${EZPADA_ROOT}/repos

            # Add a tmux session
            tmux new-session -d -s ${EZPADA_NAME} &> /dev/null
        '';
    };
}

