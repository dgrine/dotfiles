{ pkgs, ... }:

{
    programs.bat = {
        enable = true;
    };
    xdg.configFile."bat".source = ../../../bat/.config/bat;
}

