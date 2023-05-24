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
    latest_tag=$(get_latest_gh_tag "cli" "cli")
    latest_version=$(get_gh_version_for_tag "$latest_tag")
    gh_cli_version="gh_${latest_version}_${os}_${arch}"
    curl -fSLO "https://github.com/cli/cli/releases/download/${latest_tag}/${gh_cli_version}.zip"

    check_successful $? "GitHub CLI ${gh_cli_version}"

    unzip "${gh_cli_version}.zip"
    sudo mv ./"${gh_cli_version}"/bin/gh /usr/local/bin/gh
}

install_github_cli
