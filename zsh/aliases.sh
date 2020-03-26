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

# Make xclip default selection clipboard
alias xclip="xclip -selection clipboard"

# Make bc load math libraries (-l) and start in quiet mode (-q)
alias bc="bc -lq"

# Don't ever page when using bat
alias bat="bat --paging never"

# Make x11vnc use password and ssl by default
alias x11vnc="x11vnc -usepw -ssl"

# Remote Desktop alias to work
alias remote="xfreerdp -u $rdesktop_username -d '$rdesktop_domain' /dynamic-resolution -f $rdesktop_pcname"

# System-inhibit that prevents laptop from going to sleep with closed lid. Useful when switching to bigger monitor.
# This is a blocking call, and stopping it <C-c> will stop the effect.
alias inhibit-sleep="systemd-inhibit --what=handle-lid-switch sleep 6h"

alias dd="echo 'NO YOU IDIOT. Shutting down.'; sleep 2; poweroff"
