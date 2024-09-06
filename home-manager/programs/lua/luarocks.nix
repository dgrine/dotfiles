{ pkgs, ... }:

{
    home.packages = with pkgs; [
        luajitPackages.luarocks
    ];
}

