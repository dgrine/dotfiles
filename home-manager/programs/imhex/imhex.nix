# Not available on macOS
# https://search.nixos.org/packages?channel=23.05&show=imhex&from=0&size=50&sort=relevance&type=packages&query=imhex

{ pkgs, ... }:

{
    home.packages = with pkgs; [
        imhex
    ];
}
