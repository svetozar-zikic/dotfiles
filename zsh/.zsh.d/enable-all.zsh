#!/bin/zsh
cd ~/.dotfiles/zsh/.zsh.d/enabled
for i in $(ls ~/.dotfiles/zsh/.zsh.d/available | xargs -n1); do ln -s ../available/$i 2>/dev/null; done
