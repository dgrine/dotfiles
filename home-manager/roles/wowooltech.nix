{ pkgs, ... }:

let WOWOOLTECH_NAME = "wowooltech"; in {
    imports = [
    ];

    programs.zsh = let WOWOOLTECH_ROOT = "$HOME/dev/${WOWOOLTECH_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${WOWOOLTECH_ROOT}

            # Add the code directory
            mkdir -p ${WOWOOLTECH_ROOT}/code

            # Add the docs directory
            mkdir -p ${WOWOOLTECH_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${WOWOOLTECH_NAME} &> /dev/null
        '';
    };
}

