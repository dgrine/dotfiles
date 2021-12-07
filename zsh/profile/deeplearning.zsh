alias ssh_deeplearning='ssh -p 24 grine@deeplearning'
alias mount_deeplearning='mkdir -p ~/dev/mnt/deeplearning && sshfs -p 24 grine@deeplearning:/ ~/dev/mnt/deeplearning -ovolname=deeplearning,auto_cache,reconnect,defer_permissions,no_readahead,noappledouble,negative_vncache'
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
alias cddeeplearning='cdrepos; cd deeplearning'
