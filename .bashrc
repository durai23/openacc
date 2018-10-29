# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
alias ls='ls --color=auto'
alias ll='ls -lh'               # ll list with long format
alias la='ls -la'               # la list also hidden files
alias la='ls -la |pg'   # la list also hidden files page by page
alias l='ll'

if [ -f ~train001/group-bashrc.sh ]; then
	source ~train001/group-bashrc.sh
fi
