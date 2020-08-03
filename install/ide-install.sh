#!/bin/bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop || return 1

function read_input {
	read -n1 -r -p " $1 (Y/n) " key
	echo
	if [ "$key" = 'Y' ]; then
		return 0 # True
	else
        	return 1 # False
	fi
}

# JetBrains Products
if read_input "Install PyCharm?"; then
	sudo snap install pycharm-professional --classic
	if [ $? = 0 ]; 
	then
		echo_message "PyCharm Professional successfully installed"
    	else
		echo_error "Pycharm Proffessional installation failed"
	fi
	new_small_separator
	pycharm-professional_pycharm-professional.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi

if read_input "Install WebStorm?"; then
	sudo snap install webstorm --classic
	if [ $? = 0 ]; 
	then
		echo_message "Webstorm successfully installed"
    	else
		echo_error "Webstorm installation failed"
	fi
	new_small_separator
	webstorm_webstorm.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi

if read_input "Install Goland?"; then
	sudo snap install goland --classic
	if [ $? = 0 ]; 
	then
		echo_message "Goland successfully installed"
    	else
		echo_error "Goland installation failed"
	fi
	new_small_separator
	goland_goland.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi