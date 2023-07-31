{ pkgs, ... }:

{
    home.packages = with pkgs; [
        (pkgs.writeShellScriptBin "eot-menv" ''
            python3 -m venv .venv
            source .venv/bin/activate
            pip3 config set global.extra-index-url https://$EOT_NEXUS_USERNAME:$EOT_NEXUS_PASSWORD_ENCODED@repo.eyeontext.com/repository/eyeontext-pypi/simple --site
        '')

        (pkgs.writeShellScriptBin "eot-menv-release" ''
            echo "Installing environment using releases"
            eot-menv
            senv
            if [ -f "install_requires.txt" ]; then
                echo "Installing install_requires.txt"
                pip3 install -r install_requires.txt
            fi
            if [ -f "install_requires_eot.txt" ]; then
                echo "Installing install_requires_eot (releases).txt"
                pip3 install -r install_requires_eot.txt
            fi
            if [ -f "dev_requires.txt" ]; then
                echo "Installing dev_requires.txt"
                pip3 install -r dev_requires.txt
            fi
            if [ -f "dev_requires_eot.txt" ]; then
                echo "Installing dev_requires_eot (releases).txt"
                pip3 install -r dev_requires_eot.txt
            fi
            if [ -f "build_requires.txt" ]; then
                echo "Installing build_requires.txt"
                pip3 install -r build_requires.txt
            fi
            if [ -f "build_requires_eot.txt" ]; then
                echo "Installing build_requires_eot (releases).txt"
                pip3 install -r build_requires_eot.txt
            fi
        '')

        (pkgs.writeShellScriptBin "eot-menv-pre" ''
            echo "Installing environment using pre-releases"
            eot-menv
            senv
            if [ -f "install_requires.txt" ]; then
                echo "Installing install_requires.txt"
                pip3 install -r install_requires.txt
            else
                echo "Skipping install_requires.txt"
            fi
            if [ -f "install_requires_eot.txt" ]; then
                echo "Installing install_requires_eot (pre-releases).txt"
                pip3 install --pre -r install_requires_eot.txt
            else
                echo "Skipping install_requires_eot.txt"
            fi
            if [ -f "dev_requires.txt" ]; then
                echo "Installing dev_requires.txt"
                pip3 install -r dev_requires.txt
            else
                echo "Skipping dev_requires.txt"
            fi
            if [ -f "dev_requires_eot.txt" ]; then
                echo "Installing dev_requires_eot (pre-releases).txt"
                pip3 install --pre -r dev_requires_eot.txt
            else
                echo "Skipping dev_requires_eot.txt"
            fi
            if [ -f "build_requires.txt" ]; then
                echo "Installing build_requires.txt"
                pip3 install -r build_requires.txt
            else
                echo "Skipping build_requires.txt"
            fi
            if [ -f "build_requires_eot.txt" ]; then
                echo "Installing build_requires_eot (pre-releases).txt"
                pip3 install --pre -r build_requires_eot.txt
            else
                echo "Skipping build_requires_eot.txt"
            fi
        '')
    ];

    programs.zsh = let EOT_ROOT = "$HOME/dev/code/eot"; in {
        initExtra = ''
        # Add a root directory
        mkdir -p ${EOT_ROOT}

        # Add a tmux session
        tmux new-session -d -s eot &> /dev/null
        '';
        shellAliases = {
            eot-kubectl-uat = "kubectl -n eyeontext-portal";
            eot-kubectl-dev = "kubectl -n eyeontext-portal-dev";
            eot-ssh-breachserver = "ssh djgr@44.206.52.68";
            eot-sshfs-breachserver = "sudo mkdir -p /mnt/eot/breachserver; sudo sshfs -o debug,allow_other,IdentityFile=\${HOME}/.ssh/id_rsa,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.206.52.68:/ /mnt/eot/breachserver";
            #eot-ssh-breachserver-phforest = "ssh phforest@44.206.52.68 -i ${HOME}/dev/code/blackboard/docs/eyeontext/data/breachserver-phforest";
            #eot-sshfs-breachserver-phforest = "sudo sshfs -o debug,allow_other,IdentityFile=/home/djamelg/.ssh/id_rsa,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,ssh_command = \"ssh -i \${HOME}/dev/code/blackboard/docs/eyeontext/data/breachserver-phforest\" phforest@44.206.52.68:/ /mnt/eot/breachserver";
            #cdcode-eot = "cd ${EOT_ROOT}";
            #cdbrext = "cd ${EOT_ROOT}/breach-extractor";
            #cdportal-app = "cd ${EOT_ROOT}/comp-wowool-portal-app";
            #cdportal-backend = "cd ${EOT_ROOT}/comp-wowool-portal-backend-py";
            #cdportal-client = "cd ${EOT_ROOT}/comp-wowool-portal-client-py";
            #cdportal-frontend = "cd ${EOT_ROOT}/comp-wowool-portal-frontend-js";
            #cdportal-lxware = "cd ${EOT_ROOT}/comp-wowool-portal-lxware";
            #cdportal-scraper = "cd ${EOT_ROOT}/comp-wowool-portal-scraper-py";
            #cdportal-sdk = "cd ${EOT_ROOT}/comp-wowool-portal-sdk-py";
            #cdcore-build = "cd ${EOT_ROOT}/core-build-py/";
            #cdcore-utility = "cd ${EOT_ROOT}/core-utility-py/";
            #cdcore-io = "cd ${EOT_ROOT}/core-io-py/";
            #cdwowool-docs = "cd ${EOT_ROOT}/wowool-docs";
        };
    };
}
