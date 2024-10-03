#!/usr/bin/env bash

# Docker-Compose Installation
# Source: https://docs.docker.com/compose/install/


function install_docker_compose() {
    local os
    local machine_hw_name
    local latest_tag
    
    os="$(uname | tr '[:upper:]' '[:lower:]')"
    machine_hw_name=$(uname -m | sed -e 's/arm64/aarch64/')
    latest_tag=$(get_latest_gh_tag "docker" "compose")
    echo "Downloaded latest release of docker compose: $latest_tag"

    echo "https://github.com/docker/compose/releases/download/$latest_tag/docker-compose-$os-$machine_hw_name" 
    sudo curl -L "https://github.com/docker/compose/releases/download/$latest_tag/docker-compose-$os-$machine_hw_name" -o /usr/local/bin/docker-compose
    
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    check_successful $? "docker-compose"
}

install_docker_compose