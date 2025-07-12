{ pkgs, ... }:

{
    home.packages = with pkgs; [
        docker-compose
    ];
    programs.zsh = {
        oh-my-zsh.plugins = [
            "docker-compose"
        ];
    };
}


