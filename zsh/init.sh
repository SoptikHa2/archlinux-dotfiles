# Initialize pazi (like z)
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

# Run ssh agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 4h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

if [[ $(wc -l "$HOME/todo.md" | cut -d' ' -f1) -ge 1 ]]; then
    bat "$HOME"/todo.md --decorations=never --paging=never
fi
