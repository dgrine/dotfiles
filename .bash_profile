export EDITOR=vi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
export PATH=$PATH:/usr/local/mysql/bin
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
alias e='mvim'
alias sshx='ssh -X -C -c blowfish-cbc,arcfour'
alias grep='grep --color=auto'
alias ebp='e ~/.bash_profile'
alias esp='source ~/.bash_profile'
alias scpalt='rsync avzP'
alias m='make -j8'
alias l='ls -alh'
alias gs='git status'
alias cddev='cd ~/dev'

if [ -f "${HOME}/.bash_profile_custom" ]; then
	source .bash_profile_custom
fi

