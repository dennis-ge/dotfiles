#!/bin/bash

new_separator() {
	printf "%0.s-" {1..25}
	printf "\n"
}
sudo apt-get install -y vim
if [ $? = 0 ]; 
then
	tput setaf 2; echo "vim successfully installed"; tput sgr0
	new_separator

	ln -sfv "$(pwd)/etc/vim/.vimrc" ~
	tput setaf 2; echo "global .vimrc file linked to local one"; tput sgr0
else
	tput setaf 1; echo "ERROR: vim installation failed"; tput sgr0
fi
