#######################################
# Deeplearning
#######################################
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

#######################################
# Ezpada
#######################################
alias ssh_ez='ssh sgrine@ezpzugstlinux.ezpada.local'

#######################################
# HumanHuman
#######################################
alias cdhh='cdrepos; cd HumanHuman'
alias ssh_hhs='ssh www.humanhuman.com'
alias hhr='./project run job db create --user root --drop && ./project run job db migrate && ./project run job db update --skip-scraping'
alias hhw='./project run web'
alias hhdb='./project run job db create --drop; ./project run job db fetch --version safe --user sennevdb'

#######################################
# Quadcore
#######################################
alias ssh_qc='ssh grine@QuadCore -p 23'
alias mount_qc='mkdir -p ~/dev/mnt/QuadCore && sshfs -p 23 grine@QuadCore:/ ~/dev/mnt/QuadCore -ovolname=quadcore'

