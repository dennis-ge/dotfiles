#!/usr/bin/env bash

# https://kubernetes.io/docs/tasks/tools/

cd "$(mktemp -d)" || exit 1
OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"

function install_kubectl() {
    local stable_version
    stable_version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -fsSLO "https://dl.k8s.io/release/$stable_version/bin/$OS/$ARCH/kubectl"

    curl -fsSLO "https://dl.k8s.io/$stable_version/bin/$OS/$ARCH/kubectl.sha256"

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

    append_to_local_if_not_present "source <(kubectl completion zsh)"
    append_to_local_if_not_present "compdef __start_kubectl k"
    append_to_local_if_not_present "autoload -U compinit"
    append_to_local_if_not_present "compinit -i"
}

function install_k9s() {
    local k9s_version
    k9s_version="k9s_$(uname -s)_$(uname -m)"
    curl -fsSLO "https://github.com/derailed/k9s/releases/latest/download/${k9s_version}.tar.gz"
    tar zxvf "${k9s_version}.tar.gz"
    
    check_successful $? "k9s $k9s_version"
    
    sudo mv ./k9s /usr/local/bin/k9s
    k9s version 
}

function install_krew() {
    local krew_version
    krew_version="krew-${OS}_${ARCH}"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${krew_version}.tar.gz"
    tar zxvf "${krew_version}.tar.gz"
    ./"${krew_version}" install krew

    check_successful $? "krew $krew_version"

    append_to_local_if_not_present "source <(kubectl krew completion zsh)"
    append_to_local_if_not_present 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'
}

install_kubectl
install_k9s
install_krew

kubectl krew install ctx
kubectl krew install ns
kubectl krew install tree
kubectl krew install konfig
