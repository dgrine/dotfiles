source ~/dev/repos/setup/zsh/profile/humanhuman.zsh
source ~/dev/repos/setup/zsh/profile/quadcore.zsh
alias senvpd='tmp=`pwd` && cdpd && senv && cd $tmp'
alias ssh_osmc='ssh osmc@192.168.1.2'
alias ssh_deeplearning='ssh -p 24 grine@deeplearning -L 8080:localhost:8080'
alias cdpd='cdrepos; cd py-dev'
alias cdargo='cdrepos; cd Argo'
alias cddrl='cdrepos; cd drl'
