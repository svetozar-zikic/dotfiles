#!/usr/bin/zsh

LIST_PATH=$HOME/.dotfiles/zsh/.zsh.d/
ENABLE_LIST=list

cd $LIST_PATH
if [ -f $LIST_PATH/$ENABLE_LIST ]; then 
  while read line; do 
    ln -s ../available/$line enabled/
  done < $ENABLE_LIST
fi
