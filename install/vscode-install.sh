#!/usr/bin/env bash

extensions=(
	"bierner.markdown-mermaid"
	"charliermarsh.ruff"
	"christian-kohler.path-intellisense"
	"davidanson.vscode-markdownlint"
	"eamodio.gitlens"
	"esbenp.prettier-vscode"
	"golang.go"
	"hashicorp.hcl"
	"johnpapa.vscode-peacock"
	"ms-python.debugpy"
	"ms-python.python"
	"ms-python.vscode-pylance"
	"ms-python.vscode-python-envs"
	"ms-toolsai.jupyter"
	"ms-toolsai.jupyter-keymap"
	"ms-toolsai.jupyter-renderers"
	"ms-toolsai.vscode-jupyter-cell-tags"
	"ms-toolsai.vscode-jupyter-slideshow"
	"ms-vscode.notepadplusplus-keybindings"
	"oderwat.indent-rainbow"
	"pkief.material-icon-theme"
	"redhat.vscode-yaml"
	"tal7aouy.theme"
	"tamasfe.even-better-toml"
	"tim-koehler.helm-intellisense"
	"timonwong.shellcheck"
	"tomoki1207.pdf"
)


if is_ubuntu_desktop || is_macos; then
	if ! command -v code &> /dev/null
	then
		if is_macos; then
			brew install --cask visual-studio-code
		else 
			sudo snap install --classic code
		fi
		check_successful $? "vscode"
		new_small_separator
	else
		echo_message "vscode already installed"
	
	fi
	for extension in "${extensions[@]}"
	do
		code --install-extension $extension
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

	# Point the VS Code Kubernetes extension at an empty kubeconfig so it doesn't
	# enumerate the 30+ contexts from the shell's KUBECONFIG merge on activation.
	# Copied (not symlinked) so extension writes never dirty the repo.
	mkdir -p ~/.kube
	cp "$(pwd)/etc/kube/vscode-empty-kubeconfig.yaml" ~/.kube/vscode-empty.yaml
	echo_message "empty kubeconfig installed for vscode kubernetes extension"
else
	echo_message "vscode cannot be installed on this machine"
fi
