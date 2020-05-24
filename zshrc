# Setup oh-my-zsh
export ZSH="/home/petr/.oh-my-zsh"
ZSH_THEME="mrtazz"
HIST_STAMPS="yyyy-mm-dd"
MAGIC_ENTER_GIT_COMMAND='ls .'
MAGIC_ENTER_OTHER_COMMAND='ls .'
plugins=(magic-enter command-time)
source $ZSH/oh-my-zsh.sh
# Enable syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
