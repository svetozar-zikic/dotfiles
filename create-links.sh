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

WORK_FILES=($(ls $WORK_DIR | egrep -v -i '\.md$|\.sh$'))

echo -e "The following config files will be symlinked to files in $WORK_DIR\n"

for i in ${WORK_FILES[@]}; do
  echo linking $i...
  if [[ -h ~/.$i ]]; then
    unlink ~/.$i
  fi
  if [[ -f ~/.$i ]]; then
    mv ~/.$i ~/.$i.$TIMESTAMP
  fi
  ln -s $WORK_DIR/$i ~/.$i
done
echo -e "\nDone. Enjoy your new config!"
