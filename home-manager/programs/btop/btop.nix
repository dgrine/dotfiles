{ pkgs, ... }:

{
    programs.btop = {
        enable = true;
        settings = {
            vim_keys = true;
        };
    };
    xdg.configFile."btop" = {
        source = ../../../btop/.config/btop;
        recursive = true;
    };
}


