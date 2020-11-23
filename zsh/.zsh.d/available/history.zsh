# history
zinit snippet PZT::modules/history/init.zsh
zinit snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh"
zinit snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

# enable reverse lookup
bindkey '^R' history-incremental-search-backward

# don't save commands that start with space
HISTCONTROL=ignorespace

# env
HISTSIZE=10000
HISTFILE=~/.zhistory
