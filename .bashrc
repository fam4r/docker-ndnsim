# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias ..='cd ..'

PS1='[\u@\h \W]\$ '
