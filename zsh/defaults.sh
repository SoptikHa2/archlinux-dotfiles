# This defines some defaults and paths that I set my shell to
# Some are aliases, some are global variables
# Source this from rc file


# Unlimited history in file
export SAVEHIST=999999999
setopt EXTENDED_HISTORY # logs the start and elapsed time

# Add rust path
export PATH=~/.local/bin:~/.cargo/bin:$PATH
# Add ruby path
export PATH=/home/petr/.gem/ruby/2.7.0/bin:$PATH
# Add perl path
export PATH=/usr/bin/vendor_perl:$PATH
# Add all my scripts
export PATH=~/.local/scripts:$PATH

# Make neovim the default editor (except for ssh, in that case use vim)
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='/usr/bin/nvim'
fi

# Disable .net core telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Tell address sanitizer to call abort, which can be catched by debugger
export ASAN_OPTIONS='abort_on_error=1'
