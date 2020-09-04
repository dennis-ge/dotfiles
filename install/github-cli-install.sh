#!/usr/bin/env bash

wget -P ~/ --no-hsts https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.deb

sudo apt install ./gh_0.11.1_linux_amd64.deb
check_successful $? "GitHub CLI v0.11.1"
