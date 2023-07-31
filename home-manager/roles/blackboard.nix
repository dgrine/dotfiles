{ pkgs, ... }:

{
    programs.zsh = let BB_ROOT = "$HOME/dev/code/bb"; in {
        initExtra = ''
        # Add a root directory
        mkdir -p ${BB_ROOT}

        # Add a tmux session
        tmux new-session -d -s blackboard &> /dev/null
        '';
        shellAliases = {

        };
    };
}
