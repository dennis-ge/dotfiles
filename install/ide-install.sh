#!/bin/bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop || exit 1

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
	echo_message "Starting to install snap package 'PyCharm Professional'"
	sudo snap install pycharm-professional --classic
	check_successful $? "PyCharm Professional"
	new_small_separator
	pycharm-professional_pycharm-professional.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi

if read_input "Install WebStorm?"; then
	echo_message "Starting to install snap package 'WebStorm'"
	sudo snap install webstorm --classic
	check_successful $? "Webstorm"
	new_small_separator
	webstorm_webstorm.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi

if read_input "Install Goland?"; then
	echo_message "Starting to install snap package 'Goland'"
	sudo snap install goland --classic
	check_successful $? "Goland"
	new_small_separator
	goland_goland.desktop >> ../etc/favorite_apps/favorite_apps.txt
fi