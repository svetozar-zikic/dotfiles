zinit ice lucid wait '!0'
zinit snippet PZT::modules/ssh/init.zsh
zstyle ':prezto:module:ssh:load' identities $(ls ${HOME}/.ssh | grep pub | cut -d '.' -f1 | xargs)
