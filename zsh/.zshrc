#!/bin/zsh

# --- initial installation for zinit --- #
LOCAL_PATH=$HOME/.local/share/zinit/zinit.git
if [[ ! -f "$LOCAL_PATH/zinit.zsh" ]]; then
  VENDOR=$(cat /etc/issue | tr '[:upper:]' '[:lower:]')
  if [[ $OSTYPE == *"darwin"* ]]; then
    VENDOR=apple
  fi
  LINK=https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh
  if [[ "${VENDOR}" == *"ubuntu"* || "${VENDOR}" == *"debian"* ]]; then
      wget -O - ${LINK} | sh
    else
      sh -c "$(curl -fsSL ${LINK})"
  fi
  source "$LOCAL_PATH/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
  zinit update --all
fi

# --- source zinit per instructions --- #
source "$LOCAL_PATH/zinit.zsh"
autoload -Uz _zinit
autoload -U +X compinit && compinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# --- updating plugins --- #
# update all plugins every 7 days
# zinit self-update && zinit update --all

# --- shell options --- #
# https://zsh.sourceforge.io/Intro/intro_16.html#SEC16
setopt correct
setopt extendedglob
setopt menucomplete
setopt noalwayslastprompt
setopt clobber
setopt interactivecomments
setopt promptsubst

# --- load enabled plugins --- #
if [ ! -d $HOME/.zsh.d/enabled ]; then
  mkdir -p $HOME/.zsh.d/enabled
  $HOME/.zsh.d/enable-all.zsh
fi

if [ -d ${HOME}/.zsh.d ]; then
  for file in ${HOME}/.zsh.d/enabled/*; do
    source $file
  done
fi

# --- add scripts to PATH --- #
if [[ $PATH != *${HOME}/.dotfiles/scripts* ]]; then
  export PATH=${HOME}/.dotfiles/scripts:$PATH
fi
typeset -U PATH


# --- load env variables --- #
if [ -f $HOME/.github/github.gpg ] && [ -f $HOME/.github/github-id.gpg ]; then
  eval "$(set-env $HOME/.github/github.gpg $HOME/.github/github-id.gpg 1)"
fi

if [ -f $HOME/.ddns/remote_home.gpg ] && [ -f $HOME/.ddns/remote_vars.gpg ]; then
  eval "$(set-env $HOME/.ddns/remote_home.gpg $HOME/.ddns/remote_vars.gpg 2)"
fi

# load starship
eval "$(starship init zsh)"
