#!/bin/bash

# Docker Installation
# Source: https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-repository


# Uninstall old versions:
sudo apt-get remove docker docker-engine docker.io containerd runc

# Update the apt package index:
sudo apt-get update
# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Setup a stable repository:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  disco stable"

# Update the apt package index:
sudo apt-get update

# Install the latest version of Docker Engine - Community and containerd
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Add docker to sudo group
sudo groupadd docker
sudo usermod -aG docker $USER