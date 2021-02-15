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

cal -3

if [[ $(wc -l "$HOME/todo.md" | cut -d' ' -f1) -ge 1 ]]; then
    bat "$HOME"/todo.md --decorations=never --paging=never
fi

# System maintanance
LOW_SPACE_WARNING="10G"


systemctl is-failed '*' --quiet && (systemctl --failed; echo "\n\n")
current_rootfs_diskspace="$(df -h | grep '/$' | awk '{print $4}')"
[[ $(echo "$current_rootfs_diskspace" | paste <<<"$LOW_SPACE_WARNING" | sort -h | head -1) != "$LOW_SPACE_WARNING" ]] &&
	echo "WARNING: Low on disk space. Currently has $current_rootfs_diskspace space left."

