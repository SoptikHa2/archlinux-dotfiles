# This defines shell aliases
# Source this from zshrc (bashrc, ...)

# Requirements: source secret variables first

alias nano="feh \"/home/petr/nano.jpg\""

# Yay nvim
alias vim="nvim"
alias truevim="/usr/bin/vim"

# Git aliases
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gaa="git add -u"

# Misc aliases
alias sudo="sudo -E"
alias please="sudo"
alias wifi="please wifi-menu"
alias today="date +'%Y-%m-%d'"
alias now="date +'%Y-%m-%d %H-%M-%S'"

# Remote Desktop alias
alias remote="xfreerdp -u $rdesktop_username -d '$rdesktop_domain' /dynamic-resolution -f $rdesktop_pcname"