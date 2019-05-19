source ~/dev/repos/setup/zsh/profile/humanhuman.zsh
alias senvpd='tmp=`pwd` && cdpd && senv && cd $tmp'
alias ssh_osmc='ssh osmc@192.168.1.2'

# Deeplearning
alias ssh_deeplearning='ssh -p 24 grine@deeplearning'
alias mount_deeplearning='mkdir -p ~/dev/mnt/deeplearning && sshfs -p 24 grine@deeplearning:/ ~/dev/mnt/deeplearning -ovolname=deeplearning,auto_cache,reconnect,defer_permissions,no_readahead,noappledouble,negative_vncache'

# Quadcore
alias ssh_qc='ssh grine@QuadCore -p 23'
alias mount_qc='mkdir -p ~/dev/mnt/QuadCore && sshfs -p 23 grine@QuadCore:/ ~/dev/mnt/QuadCore -ovolname=quadcore'

# Ezpada
alias ssh_ez='ssh sgrine@ezpzugstlinux.ezpada.local'
function ssh_deeplearning_fwd()
{
    port="$1"
    if [ "" = "$port" ]; then
        echo "Error: missing port"
        echo "Usage: ssh_deeplearning_fwd <port>"
        return 1
    else
        echo "Forwarding port $port ..."
        echo "Ctrl+C to stop"
        ssh_deeplearning -L "$port":localhost:"$port" -N
    fi
}
alias cdpd='cdrepos; cd py-dev'
alias cdargo='cdrepos; cd Argo'
alias cddrl='cdrepos; cd drl'
