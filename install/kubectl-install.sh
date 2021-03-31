#!/usr/bin/env bash

# https://kubernetes.io/docs/tasks/tools/

function to_lower_case() {
    local string=$1
    echo "${string,,}"
}


function install_kubectl() {
    local system=$(to_lower_case $(uname -s))
    local stable_version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -LO "https://dl.k8s.io/release/$stable_version/bin/$system/amd64/kubectl"

    curl -LO "https://dl.k8s.io/$stable_version/bin/$system/amd64/kubectl.sha256"

    if is_macos; then 
        echo "$(<kubectl.sha256)  kubectl" | shasum -a 256 --check
    else
        echo "$(<kubectl.sha256) kubectl" | sha256sum --check
    fi

    check_successful $? "kubectl $stable_version"

    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
    sudo chown root: /usr/local/bin/kubectl
    kubectl version --client
    rm kubectl.sha256
}

install_kubectl