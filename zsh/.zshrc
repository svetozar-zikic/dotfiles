#!/bin/zsh

# --- initial installation for zinit --- #
# https://github.com/zdharma/zinit#automatic-installation-recommended
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

# --- source zinit per instructions --- #
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# --- updating plugins --- #
# update all plugins every 7 days
# zinit update --all
# zinit self update every 7 days
# zinit self-update

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

# --- load aws env variables --- #
if [ -f $HOME/.aws/aws.gpg ]; then
  eval "$(aws-env)"
fi

# --- exports --- #
export PASSWORD_STORE_DIR=$HOME/.pass

# --- direct load --- #
source $HOME/.dotfiles/zsh/.zsh.d/available/history.zsh
