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



# Apt Installations
apt=(
	"chromium-browser"
	"python3"
	"python3-pip"
	"curl"
	"git"
	"dconf"
)

for package in "${apt[@]}"
do
	sudo apt-get install -y $package
    	if [ $? = 0 ]; 
	then
		print_message "apt package '$package' successfully installed"
    	else
		print_error "ERROR: apt package '$package' installation failed"
	fi
	new_separator
done

# Snap Installations
snap=(
	"postman"
)

for package in "${snap[@]}"
do
	sudo snap install --classic $package
	if [ $? = 0 ]; 
	then
		print_message "snap package '$package' successfully installed"
    	else
		print_error "ERROR: snap package '$package' installation failed"
	fi
	new_separator
done

# Small Ubuntu related configurations
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
echo "Dock set to position Bottom"
new_separator

setxkbmap -layout de
echo "German keyboard layout set"

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
	print_message "Removed apt package $package"
	new_separator
done
