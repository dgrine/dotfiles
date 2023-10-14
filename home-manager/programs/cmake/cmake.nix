{ pkgs, ... }:

{
    home.packages = with pkgs; [
        cmake
        cmake-format
    ];
}

