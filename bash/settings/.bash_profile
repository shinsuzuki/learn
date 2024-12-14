# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH

LANG=ja_JP.UTF-8
export LANG

export PS1='\e[32m\u@\h:\e[34m\W \e[0m\$'

# alias la='ls -a'
# alias ll='ls -alh'
# alias tree='tree -N'
alias cls='clear'
# alias ..='cd ../'
alias cat='batcat'
alias ls='exa'

export LESS=-q
