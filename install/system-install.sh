#!/bin/bash

# Apt Installations
apt_packages=(
	"build-essential"
	"cmake"
	"curl"
	"dconf"
	"dos2unix"
	"git"
	"thefuck"
	"python3-pip"
	"vim"
)

is_ubuntu_desktop && apt_packages += (
	"chromium-browser"
)

for package in "${apt_packages[@]}"
do
	sudo apt-get install -y $package
    check_successful ?$ "apt package '$package'"
	new_small_separator
done

pip3 install virtualenv
echo_message "pip3 package 'virtualenv' successfully installed"

# Snap Installations
if is_ubuntu_desktop; then
	new_small_separator
	snap=(
		"postman"
	)

	for package in "${snap[@]}"
	do
		sudo snap install --classic $package
		check_successful ?$ "snap package '$package'"
		new_small_separator
	done

	# Small Ubuntu Desktop related configurations
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
	echo_message "Dock set to position Bottom"
	new_small_separator

	setxkbmap -layout de
	echo_message "German keyboard layout set"

	# Remove Applications
	to_delete_apt=(
		"libreoffice*"
		"rhytmbox"
		"deja-dup"
		"gnome-calculator"
		"shotwell*"
	)

	for package in "${to_delete_apt[@]}"
	do
		sudo apt-get remove $package
		sudo apt-get clean
		sudo apt-get autoremove
		echo_message "Removed apt package '$package'"
		new_small_separator
	done
fi
