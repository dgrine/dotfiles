{ pkgs, ... }:

{
    home.packages = with pkgs; [
        wimlib
    ];
}

