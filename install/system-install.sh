#!/usr/bin/env bash

cd "$(mktemp -d)"


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

function macos_install_fonts() {
	for src in "$@"; do
		cp -f "$src" /Library/Fonts/
	done
}

function ubuntu_install_fonts(){
	local fonts_dir="$HOME/.local/share/fonts/"
	if [ ! -d "${fonts_dir}" ]; then
		mkdir -pv "${fonts_dir}"
	fi

	for src in "$@"; do
		cp -f "$src" $fonts_dir
	done
}

# Installations
packages=(
	"cmake"
	"curl"
	"dos2unix"
	"git"
	"httpie"
	"plantuml"
	"python3-pip"
	"thefuck"
	"vim"
	"wget"
	"zsh"
)

is_wsl_1 || is_wsl_2 || is_ubuntu_desktop && packages+=(
	"build-essential"
	"python3-pip"
	"nodejs"
)
is_ubuntu_desktop && packages+=(
	"chromium-browser"
)

is_macos && packages+=(
	"graphviz"
	"helm"
	"hey"
	"kustomize"
	"pyenv"
	"node"
	"fig"
)

if is_macos; then 
	brew update
else 
	sudo apt update
fi

for package in "${packages[@]}"
do
	echo_message "Starting to install package '$package'"
	if is_macos; then 
		echo ""
		brew install -v $package
	else 
		sudo apt install -y $package
	fi
    check_successful ?$ "package '$package'"
	new_small_separator
done

if is_wsl_1 || is_wsl_2; then

	sudo cp "$(pwd)/etc/wsl/wsl.conf" /etc
	echo_message "Copied wsl.conf to etc directory"
	new_small_separator

	sudo cp "$(pwd)/etc/windows_terminal/settings.json" "/c/Users/$USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
	echo_message "Copied settings.json to Windows Terminal directory"
	new_small_separator	
fi

# Install FiraCode Font
echo_message "Installing fonts"
fonts_dir="$HOME/Documents/fonts"
if [ ! -d "${fonts_dir}" ]; then
	mkdir -pv "${fonts_dir}"
else
	echo_message "Found fonts dir $fonts_dir"
fi

font_path="$fonts_dir/FiraCode-NF-Regular-Complete-Mono-Windows-Compatible.ttf"
wget  -O "${font_path}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"
check_successful ?$ "Fira Code Nerd Font Regular Download"

if is_wsl_1 || is_wsl_2; then 
	win_install_fonts "$font_path"
	check_successful ?$ "Fonts"
elif is_macos; then 
	echo "$font_path"
	macos_install_fonts "$font_path"
	check_successful ?$ "Fonts"
elif is_ubuntu_desktop; then
	ubuntu_install_fonts  "$font_path"
	check_successful ?$ "Fonts"
fi

new_small_separator

dircolors_download_dir="$HOME/.dircolors"
dircolors_download_cmd="curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output $dircolors_download_dir"
download_in_dir "dircolors" "$dircolors_download_dir" "$dircolors_download_cmd"

oh_my_zsh_download_dir="$HOME/.oh-my-zsh"
oh_my_zsh_download_cmd="git clone https://github.com/robbyrussell/oh-my-zsh.git $oh_my_zsh_download_dir"
download_in_dir "oh-my-zsh" "$oh_my_zsh_download_dir" "$oh_my_zsh_download_cmd"

powerlevel10k_download_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
powerlevel10k_download_cmd="git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $powerlevel10k_download_dir"
download_in_dir "powerlevel10k" "$powerlevel10k_download_dir" "$powerlevel10k_download_cmd"

zsh_syntax_highlighting_download_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
zsh_syntax_highlighting_download_cmd="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $zsh_syntax_highlighting_download_dir"
download_in_dir "zsh-syntax-highlighting" "$zsh_syntax_highlighting_download_dir" "$zsh_syntax_highlighting_download_cmd"

zsh_autosuggestions_download_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
zsh_autosuggestions_download_cmd="git clone https://github.com/zsh-users/zsh-autosuggestions.git $zsh_autosuggestions_download_dir"
download_in_dir "zsh-autosuggestions" "$zsh_autosuggestions_download_dir" "$zsh_autosuggestions_download_cmd"

zsh_history_substring_search_download_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
zsh_history_substring_search_download_cmd="git clone https://github.com/zsh-users/zsh-history-substring-search.git $zsh_history_substring_search_download_dir"
download_in_dir "zsh-history-substring-search" "$zsh_history_substring_search_download_dir" "$zsh_history_substring_search_download_cmd"

new_small_separator


curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
nvm install node
npm install -g git-split-diffs

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
