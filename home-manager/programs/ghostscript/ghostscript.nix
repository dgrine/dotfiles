{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ghostscript_headless
    ];
}
