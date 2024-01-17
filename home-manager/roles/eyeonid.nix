{ pkgs, ... }:

let EOID_NAME = "eyeonid"; in {
    imports = [
        ../programs/nodejs/nodejs.nix
    ];

    programs.zsh = let EOID_ROOT = "$HOME/dev/${EOID_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${EOID_ROOT}

            # Add the code directory
            mkdir -p ${EOID_ROOT}/code

            # Add a tmux session
            tmux new-session -d -s ${EOID_NAME} &> /dev/null
        '';
        shellAliases = {
            eoid-ssh-breachserver = "ssh -i ${EOID_ROOT}/secrets/.ssh/id_rsa-breach-server djgr@44.206.52.68";
            eoid-sshfs-breachserver = "sudo sshfs -o debug,allow_other,IdentityFile=${EOID_ROOT}/secrets/.ssh/id_rsa-breach-server,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.206.52.68:/ /Volumes/EyeOnID/Breaches/";
        };
    };
}

