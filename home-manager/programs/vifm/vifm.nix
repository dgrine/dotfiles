{ pkgs, ... }:

{
    xdg.configFile."vifm".source = ../../../vifm/.config/vifm;

    programs.zsh.shellAliases = {
        nav = "cd $(TERM=xterm-256color command vifm --choose-dir - .)";
    };
    home.packages = with pkgs; [
        vifm
    ];
}
