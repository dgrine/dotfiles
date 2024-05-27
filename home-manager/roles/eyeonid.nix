{ pkgs, ... }:

let EOID_NAME = "eyeonid"; in {
    programs.zsh = let EOID_ROOT = "$HOME/dev/roles/${EOID_NAME}"; in {
        initExtra = ''
            # Add the root directory
            mkdir -p ${EOID_ROOT}

            # Add the repos directory
            mkdir -p ${EOID_ROOT}/repos

            # Add the docs directory
            mkdir -p ${EOID_ROOT}/docs

            # Add a tmux session
            tmux new-session -d -s ${EOID_NAME} &> /dev/null
        '';
        shellAliases = {
            eyeonid-ssh-breachserver = "ssh -i ${EOID_ROOT}/secrets/.ssh/id_rsa-breach-server djgr@44.206.52.68";
            eyeonid-sshfs-breachserver = "sudo sshfs -o debug,allow_other,IdentityFile=${EOID_ROOT}/secrets/.ssh/id_rsa-breach-server,reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 djgr@44.206.52.68:/ /Volumes/EyeOnID/Breaches/";
            eyeonid-port-forward-hoard-db-prod = "kubectl config use-context eyeonid-hoard-db-prod && kubectl -n db-hoard port-forward db-breachdb-0 4002:3306";
            eyeonid-port-forward-hoard-prod = "kubectl config use-context eyeonid-hoard-prod && kubectl -n indexer port-forward service/eyeonid-data-indexer 8090:8090";
            eyeonid-view-indexer-logs = "kubectl config use-context eyeonid-hoard-prod && kubectl -n indexer logs -l app=eyeonid-data-indexer -f --max-log-requests 8";
        };
        profileExtra = ''
            function eyeonid-menv() {
                python3 -m venv .venv
                senv
                source ${EOID_ROOT}/secrets/session.sh
                pip3 config set global.extra-index-url https://$EOID_NEXUS_USERNAME:$EOID_NEXUS_PASSWORD_ENCODED@repo.eyeontext.com/repository/eyeontext-pypi/simple --site
                pip3 install --upgrade pip
            }
        '';
    };
}

