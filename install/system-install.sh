#!/usr/bin/env bash

# Apt Installations
apt_get_packages=(
	"build-essential"
	"cmake"
	"curl"
	"git"
	"vim"
	"wget"
)

is_ubuntu_desktop && apt_get_packages+=(
	"chromium-browser"
)

sudo apt update


for package in "${apt_get_packages[@]}"
do
	echo_message "Starting to install apt-get package '$package'"
	sudo apt-get install -y $package
    check_successful ?$ "apt-get package '$package'"
	new_small_separator
done

apt_packages=(
	"python3-pip"
	"dos2unix"
  	"fonts-firacode"
	"thefuck"
)

for package in "${apt_packages[@]}"
do
	echo_message "Starting to install apt package '$package'"
	sudo apt install -y $package
    check_successful ?$ "apt package '$package'"
	new_small_separator
done

if is_wsl_1 || is_wsl_2; then
	sudo cp "$(pwd)/etc/wsl/wsl.conf" /etc
	echo_message "Copied wsl.conf to etc directory"
  	new_small_separator

	sudo cp "$(pwd)/etc/windows_terminal/settings.json" "/c/Users/$USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
	echo_message "Copied settings.json to Windows Terminal directory"
  	new_small_separator

	fonts_dir="$(pwd)/../fonts"
	if [ ! -d "${fonts_dir}" ]; then
		echo "mkdir -p $fonts_dir"
		mkdir -p "${fonts_dir}"
	else
		echo "Found fonts dir $fonts_dir"
	fi

	for type in Bold Light Medium Regular Retina; do
    file_path="$(pwd)/../fonts/FiraCode-${type}.ttf"
		file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
		if [ ! -e "${file_path}" ]; then
				echo "wget -O $file_path $file_url"
				wget -O "${file_path}" "${file_url}"
		else
			echo "Found existing file $file_path"
		fi;
  	done

  	# Cascadia is needed for Windows Terminal
  	wget -O "$(pwd)/../fonts/CascadiaCode" "https://github.com/microsoft/cascadia-code/releases/latest"
fi

if is_ubuntu_desktop; then
	new_small_separator
	# Snap Installations
	snap_packages=(
		"postman"
	)

	for package in "${snap_packages[@]}"
	do
		echo_message "Starting to install snap package '$package'"
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
	new_small_separator

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
		echo_message "Starting to remove apt package '$package'"
		sudo apt-get remove $package
		sudo apt-get clean
		sudo apt-get autoremove
		echo_message "Removed apt package '$package'"
		new_small_separator
	done
fi
