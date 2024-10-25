{ pkgs, ... }:

{
    imports = [
        ./docker-completion-zsh.nix
    ];
    home.packages = with pkgs; [
        docker
        docker-compose
    ];
}

