if [[ $(uname -a | grep -q Darwin) ]]; then
  # Fig pre block. Keep at the top of this file.
  . "$HOME/.fig/shell/bashrc.pre.bash"
fi
# Check if current session is interactive
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend;


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize;

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar;

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Source dotfiles
for file in ~/.{bash_aliases,bash_prompt,exports,go}; 
do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [[ $(uname -a | grep -q Darwin) ]]; then
  # Fig post block. Keep at the bottom of this file.
  . "$HOME/.fig/shell/bashrc.post.bash"
fi