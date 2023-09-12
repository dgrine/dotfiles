{ pkgs, ... }:

{
    home.packages = with pkgs; [
        kubectl
    ];
    programs.zsh.oh-my-zsh.plugins = ["kubectl"];
}

