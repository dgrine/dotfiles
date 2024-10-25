{ pkgs, ... }:

{
    programs.zsh = {
        oh-my-zsh.plugins = [
            "docker"
            "docker-compose"
        ];
    };
}
