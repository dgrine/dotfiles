{ pkgs, ... }:

{
    home = {
        file.".ipython/profile_default/ipython_config.py".source = ../../../ipython/.ipython/profile_default/ipython_config.py;
        file.".ipython/profile_default/startup".source = ../../../ipython/.ipython/profile_default/startup;
        packages = with pkgs; [
            python313
            python313Packages.pygments
        ];
    };
    programs.zsh = {
        profileExtra = ''
            function menv() {
                ~/.nix-profile/bin/python -m venv .venv
                senv
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
        ];
    };
    
}
