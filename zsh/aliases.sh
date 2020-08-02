# This defines shell aliases
# Source this from zshrc (bashrc, ...)

# Requirements: source secret variables first

alias nano="feh \"/home/petr/nano.jpg\""

# Yay nvim
alias vim="nvim"
alias truevim="/usr/bin/vim"

# Git aliases
alias ga="git add"
alias gc="git commit -v"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gaa="git add -u"

# Misc aliases
alias sudo="sudo -E -H" # -E to preserve env variables, -H to not preserve $HOME variable and set it to target user instead
alias wifi="please wifi-menu"
alias today="date +'%Y-%m-%d'"
alias now="date +'%Y-%m-%d %H-%M-%S'"

# Make xclip default selection clipboard
alias xclip="xclip -selection clipboard"

# Make bc load math libraries (-l) and start in quiet mode (-q)
alias bc="bc -lq"

# Make bat behave more like cat and less like less
alias bat="bat ---style=plain,header,grid --paging never"

# Make x11vnc use password and ssl by default
alias x11vnc="x11vnc -usepw -ssl"

# Remote Desktop alias to work
alias remote="xfreerdp -u $rdesktop_username -d '$rdesktop_domain' /dynamic-resolution -f $rdesktop_pcname"

# Nice python interpreter
alias p="ipython"

# System-inhibit that prevents laptop from going to sleep with closed lid. Useful when switching to bigger monitor.
# This is a blocking call, and stopping it <C-c> will stop the effect.
alias inhibit-sleep="systemd-inhibit --what=handle-lid-switch sleep 12h"

alias dd="echo 'NO YOU IDIOT. Shutting down.'; sleep 2; poweroff"

# Open man pages with vim
viman () { text=$(\man "$@") && echo -E "$text" | nvim -R +":set ft=man|so ~/.config/nvim/init.vim" - ; }
alias man="viman"

# Use wine as separate user for at least a bit of security
runaswine() { xhost +SI:localuser:wineuser && sudo -u wineuser env HOME=/home/wineuser USER=wineuser USERNAME=wineuser LOGNAME=wineuser wine "$@"; }
alias wine="runaswine"

# Protect myself
alias rm="rm -I"

# Kira!
alias kira="killall"

# Fuck! run it as root
alias fuck='sudo $(fc -ln -1)'

# I meant to quit
alias :q='exit'

alias nmapa='nmap'

# Yeah, I really felt the need to script this for a solid hour
alias alterncase="sed '"'s/(.)(.)?/\u\1\l\2/g'"' -E"

# This file is becoming absurd the more you scroll
alias whoami="printf \"nobody. You're nothing and you'll never acomplish anything. You're just a void, a hole in this universe full of awesomness. Thousands of years,\
humans lived and died just for you to exist for few years! And what are you doing? Reading my dotfiles instead of doing something useful. What are you\
waiting for? Just go! Go outside! GO OUTSIDE! Do you have a crush on someone? TELL THEM. RIGHT NOW. Don't wait. MESSAGE THEM RIGHT NOW. Did you already\
find the one? TELL THEM. RIGHT NOW. It'll make them happy. You have noone yet? GO OUTSIDE. Grab few friends AND GO. There is whole world ahead of you.\
Who knows, you could be root tomorrow. Btw, you are %s.\n\" \"$(\whoami)\""
