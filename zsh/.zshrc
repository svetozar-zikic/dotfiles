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
  VENDOR=$(cat /etc/issue | tr '[:upper:]' '[:lower:]')
  if [[ $OSTYPE == *"darwin"* ]]; then
    VENDOR=apple
  fi
  LINK=https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh
  if [[ "${VENDOR}" == *"ubuntu"* || "${VENDOR}" == *"debian"* ]]; then
      wget -O - ${LINK} | sh
    else
      sh -c "$(curl -fsSL ${LINK})"
  fi
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

export PATH=${HOME}/.dotfiles/scripts:$PATH
if [ -f $HOME/.aws/aws.gpg ]; then
  eval "$(aws-env)"
fi
