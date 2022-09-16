#!/usr/bin/env bash

# Docker-Compose Installation
# Source: https://docs.docker.com/compose/install/

function install_docker_compose() {
    local OS="$(uname | tr '[:upper:]' '[:lower:]')"
    local MACHINE_HW_NAME="$(uname -m)"
    local latest_tag=$(get_latest_gh_tag "docker" "compose")
    echo "Downloaded latest release of docker compose: $latest_tag"

    echo "https://github.com/docker/compose/releases/download/$latest_tag/docker-compose-$OS-$MACHINE_HW_NAME" 
    sudo curl -L "https://github.com/docker/compose/releases/download/$latest_tag/docker-compose-$OS-$MACHINE_HW_NAME" -o /usr/local/bin/docker-compose
    
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    check_successful $? "docker-compose"
}

install_docker_compose