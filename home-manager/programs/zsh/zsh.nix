{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        initExtra = ''
        mkdir -p $HOME/dev/code/
        mkdir -p $HOME/dev/tmp/
        '';
        shellAliases = import ../shellAliases.nix;
        oh-my-zsh = {
            enable = true;
            plugins = [
                "docker"
                "git"
                "kubectl"
                "npm"
                "pip"
                "python"
                "vi-mode"
                "z"
            ];
            theme = "gianu";
        };
    };

    home.packages = with pkgs; [
        oh-my-zsh
    ];
}
