zinit ice lucid wait '!1'
zinit snippet OMZ::plugins/kubectl/kubectl.plugin.zsh

# https://kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/
source <(kubectl completion zsh)
#complete -F __start_kubectl k
