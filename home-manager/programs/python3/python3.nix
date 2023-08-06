{ pkgs, ... }:

{
    home.packages = with pkgs; [
        python311
    ];
    programs.zsh.profileExtra = ''
        function menv() {
            python3 -m venv .venv
        }

        function senv() {
            source .venv/bin/activate
        }

        function renv() {
            rm -rf .venv
        }
    '';
}
