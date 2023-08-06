{ pkgs, ... }:

let EOT_NAME = "eyeontext"; in {
    programs.zsh = let EOT_ROOT = "$HOME/dev/${EOT_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${EOT_ROOT}

            # Add the code directory
            mkdir -p ${EOT_ROOT}/code

            # Add the docs directory
            if [ ! -d "${EOT_ROOT}/docs" ] 
            then
                git clone git@gitlab.com:dgrine/${EOT_NAME}-docs.git ${EOT_ROOT}/docs
            fi

            # Add the secrets directory
            if [ ! -d "${EOT_ROOT}/secrets" ] 
            then
                git clone git@gitlab.com:dgrine/${EOT_NAME}-secrets.git ${EOT_ROOT}/secrets
            fi
            source ${EOT_ROOT}/secrets/session.sh

            # Add a tmux session
            tmux new-session -d -s ${EOT_NAME} &> /dev/null
        '';
        shellAliases = {
            eot-kubectl-dev = "AWS_SHARED_CREDENTIALS_FILE=${EOT_ROOT}/secrets/.aws/credentials kubectl -n ${EOT_NAME}-portal-dev";
            eot-kubectl-uat = "AWS_SHARED_CREDENTIALS_FILE=${EOT_ROOT}/secrets/.aws/credentials kubectl -n ${EOT_NAME}-portal-uat";
            eot-ssh-breachserver = "ssh djgr@44.206.52.68";
            eot-sshfs-breachserver = "sudo mkdir -p /mnt/eot/breachserver; sudo sshfs -o debug,allow_other,IdentityFile=\${HOME}/.ssh/id_rsa,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.206.52.68:/ /mnt/eot/breachserver";
        };
        profileExtra = ''
            function eot-menv() {
                python3 -m venv .venv
                senv
                pip3 config set global.extra-index-url https://$EOT_NEXUS_USERNAME:$EOT_NEXUS_PASSWORD_ENCODED@repo.eyeontext.com/repository/eyeontext-pypi/simple --site
            }

            function eot-menv-release() {
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
            }

            function eot-menv-pre() {
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
            }
        '';
    };
}
