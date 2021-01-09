#!/usr/bin/env bash

# Abort if the System is not Ubuntu Desktop
is_ubuntu_desktop | is_macos || exit 1

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
if read_input "Install PyCharm CE?"; then
	echo_message "Starting to install PyCharm CE"
	if is_macos; then
		brew install --cask pycharm-ce
	else
	sudo snap install pycharm-community --classic
	pycharm-professional_pycharm-professional.desktop >> ../etc/favorite_apps/favorite_apps.txt
	fi
	check_successful $? "PyCharm Professional"
	new_small_separator
fi

if read_input "Install WebStorm?"; then
	echo_message "Starting to install WebStorm"
	if is_macos; then
		brew install --cask webstorm
	else
		sudo snap install webstorm --classic
		webstorm_webstorm.desktop >> ../etc/favorite_apps/favorite_apps.txt
	fi
	check_successful $? "Webstorm"
	new_small_separator
fi

if read_input "Install Goland?"; then
	echo_message "Starting to install Goland"
	if is_macos; then
		brew install --cask goland
	else
		sudo snap install goland --classic
		goland_goland.desktop >> ../etc/favorite_apps/favorite_apps.txt
	fi
	check_successful $? "Goland"
	new_small_separator
fi