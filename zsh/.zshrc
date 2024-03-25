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
# manual update:
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

# --- create enabled plugins folder --- #
if [ ! -d $HOME/.zsh.d/enabled ]; then
  mkdir -p $HOME/.zsh.d/enabled
  $HOME/.zsh.d/enable-all.zsh
fi

# --- load existing enabled plugins --- #
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

# --- load env variables with sops --- #
if [ -f $HOME/.secrets/list ]; then
  for i in $(cat $HOME/.secrets/list); do
    if [ -f $HOME/.$i ]; then
      for line in $(sops -d $HOME/.$i); do
        eval $(echo export $line)
      done
    fi
  done
fi

# load starship
eval "$(starship init zsh)"

# history custom commands
export SAVEHIST=100000
export HISTSIZE=100000
