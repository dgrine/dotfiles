{ pkgs, ... }:

{
    xdg.configFile."zathura".source = ../../../zathura/.config/zathura;
    home.packages = with pkgs; [
        zathura
    ];
}

