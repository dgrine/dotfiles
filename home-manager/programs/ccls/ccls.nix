{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ccls
    ];
}

