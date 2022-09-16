#!/usr/bin/env bash

# Docker Installation
# Source: https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository

cd "$(mktemp -d)" || exit 1

function install_docker {
    if is_macos; then
        echo_message "Skipping docker installation for MacOS"
        return
    fi

    # Uninstall old versions:
    sudo apt-get remove docker docker-engine docker.io containerd runc

    # Update the apt package index:
    sudo apt-get update
    # Install packages to allow apt to use a repository over HTTPS:
    sudo apt-get -y install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    # Add Docker’s official GPG key
    curl -4fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Setup a stable repository:
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

    # Update the apt package index:
    sudo apt-get update

    # Install the latest version of Docker Engine - Community and containerd
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io -y
    docker --version
    check_successful $? "docker"

    # Add docker to sudo group
    sudo groupadd docker
    sudo usermod -aG docker "$USER"
    check_successful $? "docker group"

}

function install_dive {
    local os="$(uname | tr '[:upper:]' '[:lower:]')"
    local arch="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    local latest_tag=$(get_latest_gh_tag "wagoodman" "dive")
    local latest_version=$(get_gh_version_for_tag "$latest_tag")
    local version="dive_${latest_version}_${os}_${arch}"
    curl -fsSLO "https://github.com/wagoodman/dive/releases/download/${latest_tag}/${version}.tar.gz"

    check_successful $? "Dive ${latest_tag}"

    tar zxf "${version}.tar.gz" 
    sudo mv ./dive /usr/local/bin/dive
}


install_docker
install_dive