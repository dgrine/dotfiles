{ pkgs, ... }:

{
    home.packages = with pkgs; [
        nodejs
        yarn
    ];
    programs.zsh.oh-my-zsh.plugins = ["npm"];
}
