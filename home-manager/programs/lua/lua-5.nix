{ pkgs, ... }:

{
    home.packages = with pkgs; [
        lua51Packages.lua
    ];
}

