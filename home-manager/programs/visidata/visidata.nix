{ pkgs, ... }:

{
    home = {
        file.".visidatarc".source = ../../../visidata/config.py;
    };
}

