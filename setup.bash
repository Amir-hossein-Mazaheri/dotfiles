#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RESET='\033[0m'

base_path_to_confg="$HOME/.config/dotfiles"

if [ $# -eq 0 ]; then
    echo -e "${GREEN}Using the default path to the config file which ${YELLOW} \b${base_path_to_confg}${RESET}\n"
fi

path_to_config=""

if [ -z "$1" ]; then
    path_to_config=$base_path_to_confg
else
    path_to_config=$1
fi

echo $path_to_config

if [ ! -d "$path_to_config" ]; then
    echo -e "${RED}The path to the config file does not exist. Please check the path and try again.${RESET}"
    exit 1
fi

# after some checks, we can now create the symlinks to dotfiles 
ln -s $path_to_config/.tmux.conf $HOME/.tmux.conf
ln -s $path_to_config/.zshrc $HOME/.zshrc
ln -s $path_to_config/.p10k.zsh $HOME/.p10k.zsh
ln -s $path_to_config/.oh-my-zsh/ $HOME/.oh-my-zsh/

