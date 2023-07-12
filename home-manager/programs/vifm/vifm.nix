{ pkgs, ... }:

{
    xdg.configFile."vifm".source = ../../../vifm/.config/vifm;

    home.packages = with pkgs; [
        vifm
    ];
}
