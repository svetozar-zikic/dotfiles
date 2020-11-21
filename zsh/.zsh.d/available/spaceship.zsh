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

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  kubecontext   # Kubectl context section
  char          # Prompt character
)

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
