{ pkgs, ... }:

let BB_NAME = "blackboard"; in {
    imports = [
    ];

    programs.zsh = let BB_ROOT = "$HOME/dev/${BB_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${BB_ROOT}

            # Add the admin directory
            if [ ! -d "${BB_ROOT}/admin" ] 
            then
                git clone git@gitlab.com:dgrine/${BB_NAME}-admin.git ${BB_ROOT}/admin
            fi

            # Add the code directory
            mkdir -p ${BB_ROOT}/code

            # Add a tmux session
            tmux new-session -d -s ${BB_NAME} &> /dev/null
        '';
        shellAliases = {

        };
    };
}
