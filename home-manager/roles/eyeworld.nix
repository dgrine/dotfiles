{ pkgs, ... }:

let EW_NAME = "eyeworld"; in {
    programs.zsh = let EW_ROOT = "$HOME/dev/roles/${EW_NAME}"; in {
        initContent = ''
            # Add the root directory
            mkdir -p ${EW_ROOT}

            # Add the repos directory
            mkdir -p ${EW_ROOT}/repos

            # Add the docs directory
            mkdir -p ${EW_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${EW_NAME} &> /dev/null
        '';
        shellAliases = {
            eyeworld-ssh-breachserver = "ssh -i ${EW_ROOT}/secrets/.ssh/id_rsa-breach-server djgr@44.215.69.55";
            eyeworld-sshfs-breachserver = "sudo sshfs -o debug,allow_other,IdentityFile=${EW_ROOT}/secrets/.ssh/id_rsa-breach-server,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.215.69.55:/ /Volumes/EyeWorld/Breaches/";
            eyeworld-port-forward-hoard-db-prod = "kubectl config use-context eyeworld-hoard-db-prod && kubectl -n db-hoard port-forward db-breachdb-0 4002:3306";
            eyeworld-port-forward-hoard-prod = "kubectl config use-context eyeworld-hoard-prod && kubectl -n indexer port-forward service/eyeworld-data-indexer 8090:8090";
            eyeworld-view-indexer-logs = "kubectl config use-context eyeworld-hoard-prod && kubectl -n indexer logs -l app=eyeworld-data-indexer -f --max-log-requests 8";
        };
        profileExtra = ''
            function eyeworld-menv() {
                python3 -m venv .venv
                senv
                source ${EW_ROOT}/secrets/session.sh
                pip3 config set global.extra-index-url https://$NEXUS_USERNAME:$NEXUS_PASSWORD_ENCODED@repo.eyeontext.com/repository/eyeontext-pypi/simple --site
                pip3 install --upgrade pip
            }
        '';
    };
}

