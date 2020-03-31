#!/bin/bash

TIMESTAMP=$(date +"%Y-%d-%m-%T")
WORK_DIR=$(pwd)

echo "This script will backup your current .zshrc, .vimrc and .tmux.conf files and link your settings to corresponding config files in $WORK_DIR"

while true
do
  read -p "Continue? Y/N " answer
  case $answer in
   [yY]* ) break;;
   [nN]* ) exit;;
   *     ) echo "Dude, just enter Y or N.";;
  esac
done

WORK_FILES=($(ls . ))
echo -e "The following config files will be symlinked to files in $WORK_DIR\n"

for i in ${WORK_FILES[@]}; do
  if [[ ! "$i" == "README.md" ]] && [[ "$i" != "update.sh" ]]; then
    echo $i
    if [[ -h ~/.$i ]]; then
      unlink ~/.$i
    fi
    if [[ -f ~/.$i ]]; then
      mv ~/.$i ~/.$i.$TIMESTAMP
    fi
    ln -s $WORK_DIR/$i ~/.$i 
  fi
done
echo -e "\nDone. Enjoy your new config!"

