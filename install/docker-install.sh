#!/usr/bin/env bash

# Docker Installation
# Source: https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository


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