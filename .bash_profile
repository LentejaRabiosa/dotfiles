# .bash_profile
# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

PS1='\[\e[0m\]$?\[\e[0;92m\] → \[\e[0;96m\]\W\[\e[0m\] \[\e[0m\]'

BP='~/.bash_profile'

alias edit='nvim /Users/alex/.bash_profile'
alias ..='cd ..'
alias ip='curl ifconfig.me; echo'
alias localip='ipconfig getifaddr en1'
alias la='ls -a'
alias l='ls -al'
alias ls='ls -color'
alias gs='git status'
alias config='/usr/bin/git --git-dir=/Users/alex/Documents/dotfiles --work-tree=$HOME'
alias v='nvim .'
# alias nv='nvim . "+Telescope find_files"'
alias ctags="~/./ctags/ctags"

export NVM_DIR="/Users/alex/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export BP
export PATH
export PATH="/path/to/cloned_folder/homebrew/bin:$PATH"
export EDITOR=nvim
export CLICOLOR=1
export TERM=xterm-256color
export VISUAL=nvim
