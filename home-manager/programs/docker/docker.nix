{ pkgs, ... }:

{
    home.packages = with pkgs; [
        docker
    ];
    programs.zsh = {
        oh-my-zsh.plugins = [
            "docker"
        ];
    };
}

