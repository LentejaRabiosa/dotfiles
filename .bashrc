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
alias t="l -T"
alias grep="grep --color=auto"

PS1="\h@\u at \w "

# nvm
source /usr/share/nvm/init-nvm.sh

# uv
export PATH="/home/alex/.local/bin:$PATH"
