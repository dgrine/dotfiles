{ pkgs, ... }:

{
    home.packages = with pkgs; [
        pandoc
        texlive.combined.scheme-basic
    ];
}
