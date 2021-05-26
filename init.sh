# Creating directory for nvim config
echo "Executing initialization script for dotfiles"
mkdir -p ~/.config/nvim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/vimrc ~/.config/nvim/init.vim
