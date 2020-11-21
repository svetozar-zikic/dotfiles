# history
zinit snippet PZT::modules/history/init.zsh
zinit snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh"
zinit snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

# shell specific commands
HISTFILE=~/.zhistory
HISTCONTROL=ignorespace             # shell commands that start with space will NOT be added to history
HISTSIZE=10000
