zstyle ':prezto:module:ssh:load' identities $(ls ${HOME}/.ssh | grep id_rsa | egrep -v pub | xargs) 
zinit ice lucid wait '!0'
zinit snippet PZT::modules/ssh/init.zsh
