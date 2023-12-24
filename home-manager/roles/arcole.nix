{ pkgs, ... }:

let ARCOLE_NAME = "arcole"; in {
    imports = [
        ../programs/ccls/ccls.nix
        ../programs/cmake/cmake.nix
    ];

    programs.zsh = let ARCOLE_ROOT = "$HOME/dev/${ARCOLE_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${ARCOLE_ROOT}

            # Add the code directory
            mkdir -p ${ARCOLE_ROOT}/code

            # Add a tmux session
            tmux new-session -d -s ${ARCOLE_NAME} &> /dev/null
        '';
    };
}

