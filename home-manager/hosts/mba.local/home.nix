{ config, pkgs, ... }:

{
    imports = [
        ../../programs/alacritty/alacritty.nix
        ../../programs/aws/aws.nix
        ../../programs/bat/bat.nix
        ../../programs/btop/btop.nix
        ../../programs/coreutils/coreutils.nix
        ../../programs/exa/exa.nix
        ../../programs/fzf/fzf.nix
        ../../programs/ghostscript/ghostscript.nix
        ../../programs/git/git.nix
        ../../programs/gnu-sed/gnu-sed.nix
        ../../programs/jq/jq.nix
        ../../programs/kubectl/kubectl.nix
        ../../programs/latex/latex.nix
        ../../programs/macos/stree.nix
        ../../programs/macos/upgrades.nix
        ../../programs/neofetch/neofetch.nix
        ../../programs/neovim/neovim.nix
        ../../programs/nodejs/nodejs.nix
        ../../programs/perforce-p4merge/perforce-p4merge.nix
        ../../programs/python3/python3-11.nix
        ../../programs/readline/readline.nix
        ../../programs/ripgrep/ripgrep.nix
        ../../programs/sshfs/sshfs.nix
        ../../programs/tldr/tldr.nix
        ../../programs/tmux/tmux.nix
        ../../programs/vifm/vifm.nix
        ../../programs/zathura/zathura.nix
        ../../programs/zoxide/zoxide.nix
        ../../programs/zsh/zsh.nix

        ../../roles/blackboard.nix
        ../../roles/wowool.nix
        ../../roles/eyeonid.nix
        ../../roles/arcole.nix
    ];

    home = {
        username = "djamelg";
        homeDirectory = "/Users/djamelg";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        stateVersion = "23.05"; # Please read the comment before changing.

        # The home.packages option allows you to install Nix packages into your
        # environment.
        packages = with pkgs; [

            # # It is sometimes useful to fine-tune packages, for example, by applying
            # # overrides. You can do that directly here, just don't forget the
            # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
            # # fonts?
            (pkgs.nerdfonts.override { fonts = [ "UbuntuMono" ]; })

            # # You can also create simple shell scripts directly inside your
            # # configuration. For example, this adds a command 'my-hello' to your
            # # environment:
            # (pkgs.writeShellScriptBin "my-hello" ''
            #   echo "Hello, ${config.home.username}!"
            # '')
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