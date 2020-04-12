# This defines some defaults and paths that I set my shell to
# Some are aliases, some are global variables
# Source this from rc file


# Unlimited history in file
export SAVEHIST=999999999

# Add rust path
source ~/.cargo/env
export PATH=~/.local/bin:$PATH
# Add ruby path
export PATH=/home/petr/.gem/ruby/2.7.0/bin:$PATH

# Make neovim the default editor (except for ssh, in that case use vim)
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='/usr/bin/nvim'
fi

# Disable .net core telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Remap capslock and escape
setxkbmap -option caps:swapescape

# Add compose key
# (so meta-~-n produces ñ or meta-^-8 produces ⁸)
setxkbmap -option compose:lwin
