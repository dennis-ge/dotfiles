# -------------------------------------------------------------------------- #
# ls aliases & color support                                                 #
# -------------------------------------------------------------------------- #

# aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    LS_COLORS=$LS_COLORS'tw=0;43:ow=0;42:'
    export LS_COLORS
    
fi

# -------------------------------------------------------------------------- #
# Git, see global .gitconfig                                                 #
# -------------------------------------------------------------------------- #
alias g='git'
alias gc='git c'
alias gca='git ca'
alias gs='git s'
alias gg='git g'
alias gp='git p'

# -------------------------------------------------------------------------- #
# Miscellaneous                                                              #
# -------------------------------------------------------------------------- #

# cd aliases
alias ..='cd ..'
alias cd..='cd ..'

# enable easy search through history
alias gh='history|grep'

# Python 
alias py='python3'
alias ve='pip3 -m venv ./venv'
alias va='source ./venv/bin/activate'


alias c='clear'
alias untar='tar -zxvf '

# Add an "alert" alias for long running commands.  Use like so:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
