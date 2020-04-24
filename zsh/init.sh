# Initialize pazi (like z)
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

# Enable syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

