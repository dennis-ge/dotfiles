#!/usr/bin/env bash

function install_go {
    local version="1.16.7"
    local system=$(to_lower_case $(uname -s))
    wget -P ~/ --no-hsts https://dl.google.com/go/go$version.$system-amd64.tar.gz 

    sudo tar -C /usr/local -xzf ~/go$version.$system-amd64.tar.gz
    source ~/.go
    go version
    check_successful $? "Go $version"
    rm -rf ~/go$version.$system-amd64.tar.gz
}

install_go