# DOTFILES

config files for vim, zsh, tmux, etc

### install:

git clone https://github.com/svetozar-zikic/dotfiles.git ~/.dotfiles
git clone git@github.com:svetozar-zikic/dotfiles.git ~/.dotfiles

pacman -S stow tmux vim zsh --noconfirm

cd ~/.dotfiles

stow -v tmux vim zsh
