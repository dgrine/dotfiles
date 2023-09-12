{ pkgs, ... }:

{
    home.packages = with pkgs; [
        nodejs
    ];
    programs.zsh.oh-my-zsh.plugins = ["npm"];
}
