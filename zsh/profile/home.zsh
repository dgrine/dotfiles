source ~/dev/repos/setup/zsh/profile/humanhuman.zsh
source ~/dev/repos/setup/zsh/profile/quadcore.zsh
alias senvpd='tmp=`pwd` && cdpd && senv && cd $tmp'
alias ssh_osmc='ssh osmc@192.168.1.2'
alias ssh_deeplearning='ssh -p 24 grine@deeplearning'
function ssh_deeplearning_fwd()
{
    port="$1"
    echo "Forwarding port $port ..."
    ssh_deeplearning -L "$port":localhost:"$port" -N
}
alias cdpd='cdrepos; cd py-dev'
alias cdargo='cdrepos; cd Argo'
alias cddrl='cdrepos; cd drl'
