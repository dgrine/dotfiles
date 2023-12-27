{ pkgs, ... }:

{
    home = {
        file.".ipython/profile_default/ipython_config.py".source = ../../../ipython/ipython_config.py;
        packages = with pkgs; [
            python310
            python310Packages.pygments
        ];
    };
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
