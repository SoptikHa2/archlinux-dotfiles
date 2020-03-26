# Setup oh-my-zsh
export ZSH="/home/petr/.oh-my-zsh"
ZSH_THEME="mrtazz"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Set secret variables
source ~/archlinux-dotfiles/bin/secret

# Set default paths
source ~/archlinux-dotfiles/zsh/defaults.sh

# Set aliases
source ~/archlinux-dotfiles/zsh/aliases.sh

# Initialization code
source ~/archlinux-dotfiles/zsh/init.sh

# Custom functions
source ~/archlinux-dotfiles/zsh/functions.sh
#echo "hacked very much"
