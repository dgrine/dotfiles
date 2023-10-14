{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ghostscript
    ];
}
