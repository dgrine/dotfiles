{ pkgs, config, ... }:

{
    home.packages = with pkgs; [
        black
    ];
}

