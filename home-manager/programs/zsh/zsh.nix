{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        extraConfig = ''
        source "${home.homeDirectory}/.zshrc_local"
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
