{ config, pkgs, ... }:

{
    imports = [
        ../../programs/alacritty/alacritty.nix
        ../../programs/aws/aws.nix
        ../../programs/bat/bat.nix
        ../../programs/btop/btop.nix
        ../../programs/cmake/cmake.nix
        ../../programs/coreutils/coreutils.nix
        ../../programs/docker/docker-completion-zsh.nix
        ../../programs/docker/docker-compose.nix
        ../../programs/exa/exa.nix
        ../../programs/fzf/fzf.nix
        ../../programs/ghostscript/ghostscript.nix
        ../../programs/git/git.nix
        ../../programs/gnu-sed/gnu-sed.nix
        ../../programs/jq/jq.nix
        ../../programs/kubectl/kubectl.nix
        # ../../programs/latex/latex.nix
        ../../programs/macos/upgrades.nix
        ../../programs/macos/wimlib.nix
        # ../../programs/neofetch/neofetch.nix
        ../../programs/neovim/neovim.nix
        ../../programs/ninja/ninja.nix
        ../../programs/nodejs/nodejs.nix
        ../../programs/perforce-p4merge/perforce-p4merge.nix
        ../../programs/python3/python3-13.nix
        ../../programs/readline/readline.nix
        ../../programs/ripgrep/ripgrep.nix
        ../../programs/sshfs/sshfs.nix
        ../../programs/tldr/tldr.nix
        ../../programs/tmux/tmux.nix
        ../../programs/tree-sitter/tree-sitter.nix
        ../../programs/tree/tree.nix
        ../../programs/vifm/vifm.nix
        ../../programs/zoxide/zoxide.nix
        ../../programs/zsh/zsh.nix

        ../../roles/arcole.nix
        ../../roles/eyeworld.nix
        ../../roles/wowool.nix
    ];

    home = {
        # Default value is true, which means that Home Manager will check if the
        # Nixpkgs release is compatible with the Home Manager release.
        # I've set it to false temporarily to avoid issues with the
        # Home Manager release check.
        enableNixpkgsReleaseCheck = false;
        username = "djamelg";
        homeDirectory = "/Users/djamelg";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "24.05"; # Please read the comment before changing.

        # The home.packages option allows you to install Nix packages into your
        # environment.
        packages = with pkgs; [
            pkgs.nerd-fonts.ubuntu-mono
        ];

        # Home Manager is pretty good at managing dotfiles. The primary way to manage
        # plain files is through 'home.file'.
        file = {
            # # Building this configuration will create a copy of 'dotfiles/screenrc' in
            # # the Nix store. Activating the configuration will then make '~/.screenrc' a
            # # symlink to the Nix store copy.
            # ".screenrc".source = dotfiles/screenrc;

            # # You can also set the file content immediately.
            # ".gradle/gradle.properties".text = ''
            #   org.gradle.console=verbose
            #   org.gradle.daemon.idletimeout=3600000
            # '';
        };

        # You can also manage environment variables but you will have to manually
        # source
        #
        #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
        #
        # or
        #
        #  /etc/profiles/per-user/djamelg/etc/profile.d/hm-session-vars.sh
        #
        # if you don't want to manage your shell through Home Manager.
        sessionVariables = {
        };
    };
    fonts.fontconfig.enable = true;

    programs = {
        home-manager.enable = true;
    };
}
