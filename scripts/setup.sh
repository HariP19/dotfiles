#!/bin/bash

# Clone tmux plugins if they don't exist
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.tmux/plugins/tmux-resurrect ]; then
  git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect
fi

if [ ! -d ~/.tmux/plugins/tmux-cpu ]; then
  git clone https://github.com/tmux-plugins/tmux-cpu ~/.tmux/plugins/tmux-cpu
fi

if [ ! -d ~/.tmux/plugins/vim-tmux-navigator ]; then
  git clone https://github.com/christoomey/vim-tmux-navigator ~/.tmux/plugins/vim-tmux-navigator
fi

# Set up symlinks for config files
ln -sfn "${HOME}/dotfiles/.tmux.conf" ~/.tmux.conf
ln -sfn "${HOME}/dotfiles/.vimrc" ~/.vimrc
ln -sfn "${HOME}/dotfiles/.bashrc" ~/.bashrc
ln -sfn "${HOME}/dotfiles/.bash_aliases" ~/.bash_aliases

# Reload .bashrc
source ~/.bashrc