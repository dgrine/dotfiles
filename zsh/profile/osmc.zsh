alias ssh_osmc='ssh -p 22 osmc@osmc'
alias mount_osmc='mkdir -p ~/dev/mnt/osmc && sshfs -p 22 osmc@osmc:/ ~/dev/mnt/osmc -ovolname=osmc,auto_cache,reconnect,defer_permissions,no_readahead,noappledouble,negative_vncache'

