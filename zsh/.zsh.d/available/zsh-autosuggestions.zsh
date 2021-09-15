# https://github.com/zsh-users/zsh-autosuggestions

export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=48
zinit ice wait'!1' silent atload'_zsh_autosuggest_start'
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("expand-or-complete")

