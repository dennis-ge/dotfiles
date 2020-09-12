#!/usr/bin/env bash

# https://github.com/romkatv/dotfiles-public/blob/master/bin/setup-machine.sh#L257
function win_install_fonts() {
	local dst_dir
	dst_dir="$(cmd.exe /c 'echo %LOCALAPPDATA%\Microsoft\Windows\Fonts' 2>/dev/null | sed 's/\r$//')"
	dst_dir="$(wslpath "$dst_dir")"
	mkdir -p "$dst_dir"
	local src
	for src in "$@"; do
    	local file="$(basename "$src")"
    	if [[ ! -f "$dst_dir/$file" ]]; then
			cp -f "$src" "$dst_dir/"
    	fi
    	local win_path
    	win_path="$(wslpath -w "$dst_dir/$file")"
    	# Install font for the current user. It'll appear in "Font settings".
    	reg.exe add                                                 \
		'HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' \
		/v "${file%.*} (TrueType)" /t REG_SZ /d "$win_path" /f 2>/dev/null
	done
}

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
	"thefuck"
	"zsh"
)

for package in "${apt_packages[@]}"
do
	echo_message "Starting to install apt package '$package'"
	sudo apt install -y $package
    check_successful ?$ "apt package '$package'"
	new_small_separator
done

if is_wsl_1 || is_wsl_2; then
	# Install Fonts
	echo_message "Installing fonts"
	fonts_dir="$(pwd)/../fonts"
	if [ ! -d "${fonts_dir}" ]; then
		mkdir -p "${fonts_dir}"
	else
		echo_message "Found fonts dir $fonts_dir"
	fi

	file_path="$(pwd)/../fonts/FiraCode-NF-Regular-Complete-Mono-Windows-Compatible.ttf"
	wget  -O "${file_path}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"
	check_successful ?$ "Fira Code Nerd Font Regular"
	win_install_fonts "$(pwd)/../fonts/FiraCode-NF-Regular-Complete-Mono-Windows-Compatible.ttf"
	check_successful ?$ "Fonts"
	new_small_separator

	sudo cp "$(pwd)/etc/wsl/wsl.conf" /etc
	echo_message "Copied wsl.conf to etc directory"
	new_small_separator

	sudo cp "$(pwd)/etc/windows_terminal/settings.json" "/c/Users/$USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
	echo_message "Copied settings.json to Windows Terminal directory"
	new_small_separator	
fi

echo_message "Installing dircolors"
[ -e ~/.dircolors ] || curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors
check_successful  $? "dircolors"


echo_message "Installing zsh stuff"
[ -d ~/.oh-my-zsh ] || git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
check_successful "oh-my-zsh"

[ -d ~/.oh-my-zsh/custom}/themes/powerlevel10k ] || git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
check_successful $? "powerlevel10k"

[ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
check_successful $? "zsh-syntax-highlighting"

[ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestion ] || git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
check_successful $? "zsh-autosuggestions"
new_small_separator

if is_ubuntu_desktop; then
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

chsh -s $(which zsh)
