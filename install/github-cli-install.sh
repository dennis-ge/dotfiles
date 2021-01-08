#!/usr/bin/env bash

if is_macos; then 
    brew install gh
else 
    wget -P ~/ --no-hsts https://github.com/cli/cli/releases/download/v1.0.0/gh_1.4.0_linux_amd64.deb
    sudo apt install ~/gh_1.4.0_linux_amd64.deb
fi
check_successful $? "GitHub CLI v1.4.0"
