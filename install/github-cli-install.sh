#!/usr/bin/env bash

wget -P ~/ --no-hsts https://github.com/cli/cli/releases/download/v1.0.0/gh_1.0.0_linux_amd64.deb

sudo apt install ~/gh_1.0.0_linux_amd64.deb
check_successful $? "GitHub CLI v1.0.0"
