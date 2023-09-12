{ pkgs, ... }:

{
    home.packages = with pkgs; [
        python311
    ];
    programs.zsh = {
        profileExtra = ''
            function menv() {
                python3 -m venv .venv
                senv
                pip3 install --upgrade pip
            }

            function senv() {
                source .venv/bin/activate
            }

            function renv() {
                rm -rf .venv
            }
        '';
        oh-my-zsh.plugins = [
            "python"
            "pip"
            "invoke"
        ];
    };
    
}
