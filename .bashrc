#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ..="cd .."
alias ls="eza -1 -s type"
alias l="eza -1 -a -s type"
alias ll="eza -l -a -s type"
alias grep="grep --color=auto"
alias rebash="source ~/.bashrc"
alias renvm="source /usr/share/nvm/init-nvm.sh"

PS1="\h@\u at \w "

export PATH="~/.local/bin:$PATH"
