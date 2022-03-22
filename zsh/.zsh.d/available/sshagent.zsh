#export SSH_ASKPASS=/home/zk/.dotfiles/scripts/ssh-askpass
#export SSH_ASKPASS_REQUIRE=force
zstyle ':prezto:module:ssh:load' identities $(ls ${HOME}/.ssh | grep pub | cut -d '.' -f1 | xargs)
zinit snippet PZT::modules/ssh/init.zsh
