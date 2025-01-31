#!/usr/bin/env bash

extensions=(
	"charliermarsh.ruff"
	"christian-kohler.path-intellisense"
	"DavidAnson.vscode-markdownlint"
	"eamodio.gitlens"
	"Equinusocio.vsc-material-theme"
	"esbenp.prettier-vscode"
	"GitHub.copilot"
	"GitHub.copilot-chat"
	"GitHub.vscode-pull-request-github"
	"golang.go"
	"jebbs.plantuml"
	"joselitofilho.ginkgotestexplorer"
	"ms-python.black-formatter"
	"ms-python.isort"
	"ms-python.python"
	"ms-python.vscode-pylance"
	"ms-toolsai.jupyter"
	"ms-toolsai.jupyter-keymap"
	"ms-toolsai.jupyter-renderers"
	"ms-toolsai.vscode-jupyter-cell-tags"
	"ms-toolsai.vscode-jupyter-slideshow"
	"ms-vscode-remote.remote-containers"
	"ms-vscode-remote.remote-ssh"
	"ms-vscode.live-server"
	"oderwat.indent-rainbow"
	"PKief.material-icon-theme"
	"sdras.night-owl"
	"redhat.vscode-yaml"
	"streetsidesoftware.code-spell-checker"
	"tamasfe.even-better-toml"
	"VisualStudioExptTeam.vscodeintellicode"
)


if is_ubuntu_desktop || is_macos; then
	if ! command -v code-insiders &> /dev/null
	then
		if is_macos; then
			brew install --cask visual-studio-code
		else 
			sudo snap install --classic code
		fi
		check_successful ?$ "vscode"
		new_small_separator
	else
		echo_message "vscode already installed"
	
	fi
	for extension in "${extensions[@]}"
	do
		code-insiders --install-extension $extension
	done
	new_small_separator

	if is_macos; then
		rm ~/Library/Application\ Support/Code/User/settings.json
		cp "$(pwd)/etc/vscode/settings.json" ~/Library/Application\ Support/Code/User/
	else 
		rm ~/.config/Code/User/settings.json
		cp "$(pwd)/etc/vscode/settings.json" ~/.config/Code/User/
	fi
	echo_message "global settings.json file linked to local one"
else
	echo_message "vscode cannot be installed on this machine"
fi
