zinit ice lucid wait '!1'
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

source <(kubectl completion zsh)
complete -F __start_kubectl k
