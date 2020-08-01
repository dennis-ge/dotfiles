#!/bin/bash


print_message() {
	tput setaf 2; echo $1; tput sgr0
}

print_error() {
	tput setaf 1; echo $1; tput sgr0
}

new_separator() {
	printf "%0.s-" {1..25}
	printf "\n"
}

sudo apt-get install golang 
if [ $? = 0 ]; 
then
	print_message "Go successfully installed"
	new_separator
	sudo snap install goland --classic
	print_message "Goland successfully installed"
else
	print_error "Go installation failed"
fi
