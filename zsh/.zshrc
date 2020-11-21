#!/bin/zsh

# -- options
# auto-correct commands
setopt correctall
# ignore recording duplicate commands
setopt hist_ignore_all_dups
# ignore recording commands prefixed with a space
setopt hist_ignore_space
# allow reg-ex style matching
setopt extendedglob
# tab completion tweaks
setopt menucomplete
setopt noalwayslastprompt
# allow files to be clobbered
setopt clobber
# enable comments on the command line
setopt interactivecomments

# install zinit if file doesn't exist
if [[ ! -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
  source "${HOME}/.zinit/bin/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
  zinit update --all
fi

# source zinit as per instructions
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# forget completions provided up to this moment
zinit cdclear -q
setopt promptsubst

zinit snippet OMZ::plugins--golang/golang.plugin.zsh

# prezto
zinit snippet PZT::modules/helper/init.zsh
zinit snippet PZT::modules/gpg/init.zsh

# syntax highlighting
zinit light "zdharma/fast-syntax-highlighting"

# completions
zinit light "zsh-users/zsh-completions"

# fish-like style autocompletion
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=48
zinit ice wait'!1' silent atload'_zsh_autosuggest_start'
zinit light "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("expand-or-complete")

# complete pairing brackets
zinit light "hlissner/zsh-autopair"

# spaceship
zinit light "denysdovhan/spaceship-prompt"

# overwrite dir function
spaceship_dir() {
  local pwd="${PWD/#$HOME/~}"
  if [[ "$pwd" == (#m)[/~] ]]; then
    SPACESHIP_DIR_PWD="$MATCH"
    unset MATCH
  else
    SPACESHIP_DIR_PWD="${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
  fi

  spaceship::section \
  "$SPACESHIP_DIR_COLOR" \
  "$SPACESHIP_DIR_PREFIX" \
  "$SPACESHIP_DIR_PWD" \
  "$SPACESHIP_DIR_SUFFIX"
}

# overwrite kubecontext function
spaceship_kubecontext() {
  [[ $SPACESHIP_KUBECONTEXT_SHOW == false ]] && return

  spaceship::exists kubectl && spaceship::exists ~/.kube/config || return
  local kube_context=$(kubectl config current-context 2>/dev/null)
  local kube_namespace=$(kubectl config view -o "jsonpath={.contexts[?(@.name==\"$kube_context\")].context.namespace}")
  [[ -z $kube_context || -z $kube_namespace ]] && return

  case "$kube_context" in
    kube*) SPACESHIP_KUBECONTEXT_COLOR="red";;
#    dev*) SPACESHIP_KUBECONTEXT_COLOR="blue";;
#    **) SPACESHIP_KUBECONTEXT_COLOR="yellow";;
    [qQ-zZ]*) SPACESHIP_KUBECONTEXT_COLOR="green";;
    *) SPACESHIP_KUBECONTEXT_COLOR="cyan";;
  esac

  spaceship::section \
    "$SPACESHIP_KUBECONTEXT_COLOR" \
    "$SPACESHIP_KUBECONTEXT_PREFIX" \
    "$SPACESHIP_KUBECONTEXT_SYMBOL${kube_context}/${kube_namespace}" \
    "$SPACESHIP_KUBECONTEXT_SUFFIX"
}

# spaceship configuration
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  kubecontext   # Kubectl context section
  char          # Prompt character
)

#SPACESHIP_RPROMPT_ORDER=(
#)

SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_USER_PREFIX=""
SPACESHIP_USER_SUFFIX=""
SPACESHIP_USER_COLOR="blue"
SPACESHIP_USER_SHOW="true"
SPACESHIP_HOST_SHOW="true"
SPACESHIP_HOST_PREFIX="@"
SPACESHIP_HOST_COLOR="blue"
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_DIR_COLOR="green"
SPACESHIP_GIT_PREFIX="("
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_PREFIX=""
SPACESHIP_GIT_BRANCH_COLOR="cyan"
SPACESHIP_GIT_STATUS_PREFIX="|"
SPACESHIP_GIT_STATUS_SUFFIX=""
SPACESHIP_GIT_STATUS_COLOR="gray"
SPACESHIP_GIT_STATUS_MODIFIED="✘"
SPACESHIP_GIT_STATUS_DELETED="-"
SPACESHIP_KUBECONTEXT_PREFIX="["
SPACESHIP_KUBECONTEXT_SUFFIX="] "
SPACESHIP_KUBECONTEXT_SYMBOL=""
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always

# -- dircolors
autoload -U colors && colors
[[ -f $HOME/.dircolors ]] && eval $(dircolors -b ${HOME}/.dircolors)

# -- completion
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
zstyle ":completion:*" rehash true
zstyle ":completion:*" completer _complete _correct _ignored _approximate
zstyle ":completion:::*:default" menu no select
zstyle ":completion:*" use-cache on
zstyle ":completion:*" cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}"

# autocomplete style, taken from gentoo
zstyle ":completion:*:warnings" format "%BSorry, no matches for: %d%b"
zstyle ":completion:*:commands" rehash 1

# -- key bindings
bindkey -v
bindkey "^A" beginning-of-line      # ctrl-a
bindkey "^E" end-of-line            # ctrl-e
bindkey "^F" forward-word           # ctrl-f
bindkey "^B" backward-word          # ctrl-b
bindkey "^K" vi-change-whole-line   # ctrl-k
bindkey "^[OF" end-of-line          # end key
bindkey "^[OH" beginning-of-line    # home key
bindkey "^[[2~" overwrite-mode      # insert key
bindkey "^[[3~" delete-char         # del key
bindkey "^[[1;5C" forward-word      # ctrl-rightarrow - move forward one word
bindkey "^[[1;5D" backward-word     # ctrl-leftarrow  - move backward one word

if [ -d ${HOME}/.zsh.d ]; then
  for file in ${HOME}/.zsh.d/enabled/*.zsh; do
    source $file
  done
fi
