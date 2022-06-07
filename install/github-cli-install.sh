#!/usr/bin/env bash

cd "$(mktemp -d)" || exit 1

function install_github_cli() {
    local os
    local arch
    local latest_tag
    local latest_version
    local gh_cli_version

    if is_macos; then
        os="macOS"
    else
        os="$(uname | tr '[:upper:]' '[:lower:]')"
    fi

    arch="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')"
    latest_tag="$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep tag_name | cut -d '"' -f 4)"
    latest_version=$(echo "$latest_tag" | cut -d 'v' -f 2)
    gh_cli_version="gh_${latest_version}_${os}_${arch}"
    curl -fsSLO "https://github.com/cli/cli/releases/download/${latest_tag}/${gh_cli_version}.tar.gz"

    check_successful $? "GitHub CLI ${gh_cli_version}"

    tar zxf "${gh_cli_version}.tar.gz"
    sudo mv ./"${gh_cli_version}"/bin/gh /usr/local/bin/gh

}

install_github_cli
