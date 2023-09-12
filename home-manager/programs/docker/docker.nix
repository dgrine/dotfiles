{ pkgs, ... }:

{
    home.packages = with pkgs; [
        docker
        docker-compose
    ];
    programs.zsh = {
        oh-my-zsh.plugins = [
            "docker"
            "docker-compose"
        ];
    };
    
}

