#!/usr/bin/env bash

function setup_brew(){
	echo_message "Starting to install Homebrew"
	if ! command -v brew >/dev/null 2>&1; then
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		check_successful ?$ "Homebrew"
	else
		echo_message "Homebrew already installed"
	fi
}

function setup_packages(){
	echo_message "Starting to install packages"
	local packages
	packages=(
		"cmake"
		"curl"
		"dos2unix"
		"exa"
		"git"
		"httpie"
		"plantuml"
		"vim"
		"wget"
		"zoxide"
		"zsh"
	)

	is_wsl_1 || is_wsl_2 || is_ubuntu_desktop && packages+=( 
		"build-essential"
		"python3-pip"
	)
	is_ubuntu_desktop && packages+=(
		"chromium-browser"
	) 
	is_macos && packages+=(
		"fig"
		"git-fls"
		"helm"
		"pyenv"
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
			brew install -v "$package"
		else 
			sudo apt install -y "$package" # TODO check if brew can be used
		fi
		check_successful ?$ "package '$package'"
		new_small_separator
	done

	echo_message "installing git lfs extension"
	git lfs install
}

function setup_wsl(){
	echo_message "Setting up WSL"
	sudo cp "$(pwd)/etc/wsl/wsl.conf" /etc
	echo_message "Copied wsl.conf to etc/wsl"

	sudo cp "$(pwd)/etc/windows_terminal/settings.json" "/c/Users/$USER/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/"
	echo_message "Copied Windows Terminal settings to AppData"
	new_small_separator
}

function setup_ubuntu_desktop(){
	echo_message "Setting up Ubuntu Desktop"
	local snap_packages
	snap_packages=(
		"postman"
	)

	for package in "${snap_packages[@]}"
	do
		echo_message "Starting to install snap package '$package'"
		sudo snap install --classic "$package"
		check_successful ?$ "snap package '$package'"
		new_small_separator
	done

	echo_message "Setting Ubuntu Desktop related configurations"
	gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
	echo_message "Dock set to position Bottom"
	
	new_small_separator

	echo_message "Removing unneeded applications"
	local to_delete
	to_delete=(
		"libreoffice*"
		"rhytmbox"
		"deja-dup"
		"gnome-calculator"
		"shotwell*"
	)

	for package in "${to_delete_apt[@]}"
	do
		echo_message "Starting to remove apt package '$package'"
		sudo apt-get remove "$package"
		sudo apt-get clean
		sudo apt-get autoremove
		echo_message "Removed apt package '$package'"
		new_small_separator
	done
}

# https://github.com/romkatv/dotfiles-public/blob/master/bin/setup-machine.sh#LL309-L327C2
function win_install_fonts() {
	local dst_dir
	dst_dir="$(cmd.exe /c 'echo %LOCALAPPDATA%\Microsoft\Windows\Fonts' 2>/dev/null | sed 's/\r$//')"
	dst_dir="$(wslpath "$dst_dir")"
	mkdir -p "$dst_dir"
	local src
	for src in "$@"; do
    	local file
		file="$(basename "$src")"
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
	local fonts_dir
	fonts_dir="$HOME/.local/share/fonts/"
	if [ ! -d "${fonts_dir}" ]; then
		mkdir -pv "${fonts_dir}"
	fi

	for src in "$@"; do
		cp -f "$src" "$fonts_dir"
	done
}

function setup_fonts(){ 
	echo_message "Setting up fonts"

	local fonts_dir
	fonts_dir="$HOME/Documents/fonts"
	if [ ! -d "${fonts_dir}" ]; then
		mkdir -pv "${fonts_dir}"
	else
		echo_message "Found fonts dir $fonts_dir"
	fi

	local font_path
	font_path="$fonts_dir/FiraCode-NF-Regular-Complete-Mono-Windows-Compatible.ttf"
	wget  -O "${font_path}" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete%20Mono%20Windows%20Compatible.ttf"
	check_successful ?$ "Fira Code Nerd Font Regular Download"

	if is_wsl_1 || is_wsl_2; then 
		win_install_fonts "$font_path"
		check_successful ?$ "Fonts"
	elif is_macos; then 
		macos_install_fonts "$font_path"
		check_successful ?$ "Fonts"
	elif is_ubuntu_desktop; then
		ubuntu_install_fonts  "$font_path"
		check_successful ?$ "Fonts"
	fi
	new_small_separator
}

function setup_version_managers() {
	echo_message "Starting to install node version manager (nvm)"
	
	export NVM_DIR="$XDG_CONFIG_HOME/nvm" && (
	git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	cd "$NVM_DIR"
	git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
	) && \. "$NVM_DIR/nvm.sh"

	echo_message "Starting to install node"
	nvm install node
	check_successful ?$ "node"

	local global_node_packages
	global_node_packages=(
		git-split-diffs
	)
	for package in "${global_node_packages[@]}"
	do
		echo_message "Starting to install node package '$package'"
		npm install -g "$package"
		check_successful ?$ "node package '$package'"
		new_small_separator
	done

	echo_message "Starting to install go version manager (gvm)"
	# master is the last release. next branch is current branch
	wget  https://raw.githubusercontent.com/stefanmaric/g/master/bin/g -O $GOPATH/bin/gvm
	chmod +x $GOPATH/bin/gvm
	$GOPATH/bin/gvm --version
	check_successful ?$  "go version manager (gvm)"

	echo_message "Starting to install latest go version"
	$GOPATH/bin/gvm install latest 
	check_successful ?$  "go"
}

function setup_download_files() {
	local dir
	local cmd

	dir="$ZSH"
	cmd="git clone https://github.com/robbyrussell/oh-my-zsh.git $dir"
	download_in_dir "oh-my-zsh" "$dir" "$cmd"

	dir="${ZSH_CUSTOM:-$ZSH/custom}/themes/powerlevel10k"
	cmd="git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $dir"
	download_in_dir "powerlevel10k" "$dir" "$cmd"

	dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-syntax-highlighting"
	cmd="git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $dir"
	download_in_dir "zsh-syntax-highlighting" "$dir" "$cmd"

	dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-autosuggestions"
	cmd="git clone https://github.com/zsh-users/zsh-autosuggestions.git $dir"
	download_in_dir "zsh-autosuggestions" "$dir" "$cmd"

	dir="${ZSH_CUSTOM:-$ZSH/custom}/plugins/zsh-history-substring-search"
	cmd="git clone https://github.com/zsh-users/zsh-history-substring-search.git $dir"
	download_in_dir "zsh-history-substring-search" "$dir" "$cmd"


}

cd "$(mktemp -d)" || exit 1

setup_brew
new_small_separator
setup_packages
new_small_separator
if is_wsl_1 || is_wsl_2; then
	setup_wsl
	new_small_separator
fi
if is_ubuntu_desktop; then
	setup_ubuntu_desktop
	new_small_separator
fi
setup_fonts
new_small_separator
setup_version_managers
new_small_separator
setup_download_files

# chsh -s "$(which zsh)"
