
# List declared aliases
alias aliases="alias | sed 's/=.*//'"

# Show permision for files
alias perms="stat -c '%A %a %n' *"

#Python Alias
alias py=python3

source "/../dotfiles/.go"

# Set default editor
export EDITOR=code
