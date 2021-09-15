alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gco='git checkout '
alias gd='git diff '
alias gs='git status '
alias grv='git remote -v'
alias la='ls -la'
alias ll='ls -l'
alias s="systemctl"
alias sc="ktx"
alias sn="kns"
#alias history='history 0'
alias t='terraform'

if [[ "$OSTYPE" == "darwin"*  ]]; then alias ls='ls -G'; else alias ls='ls --color=auto'; fi
[[ "$OSTYPE" == "darwin"*  ]] && alias brew-full='brew cleanup && brew upgrade && brew upgrade --cask'
