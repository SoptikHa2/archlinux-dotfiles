#!/bin/zsh

# X
ln -sf ~/archlinux-dotfiles/xinitrc ~/.xinitrc
for f in ~/archlinux-dotfiles/x/xorg.conf.d/*; do
	echo "Linking $f -> /etc/X11/xorg.conf.d"
	sudo ln -sf "$f" /etc/X11/xorg.conf.d
done

# i3
mkdir -p ~/.config/i3
ln -s ~/archlinux-dotfiles/i3/{config,i3_master.ini,i3-master-stack} ~/.config/i3

# Sysctl
ln -sf ~/archlinux-dotfiles/sysctl.d/*.conf /etc/sysctl.d

# Polybar
mkdir -p ~/.config/polybar
ln -sf ~/archlinux-dotfiles/polybar/config ~/.config/polybar

# Rofi
mkdir -p ~/.config/rofi
ln -sf ~/archlinux-dotfiles/rofi ~/.config/rofi

# Alacritty
ln -sf ~/archlinux-dotfiles/alacritty.yml ~/.config/alacritty.yml

# Dunst
mkdir -p ~/.config/dunst
ln -sf ~/archlinux-dotfiles/dunstrc ~/.config/dunst

# Git
ln -sf ~/archlinux-dotfiles/gitconfig ~/.gitconfig

# Zsh
ln -sf ~/archlinux-dotfiles/zshrc ~/.zshrc

# Nvim
ln -sf ~/archlinux-dotfiles/nvim ~/.config/nvim

# Gdb
ln -sf ~/archlinux-dotfiles/gdbinit ~/.gdbinit

# SSH
mkdir -p ~/.ssh
ln -sf ~/archlinux-dotfiles/ssh-config ~/.ssh/config
ln -sf ~/archlinux-dotfiles/pam_environment ~/.pam_environment

# Xbindkeysrc
ln -sf ~/archlinux-dotfiles/xbindkeysrc ~/.xbindkeysrc

# Custom scripts
for file in ~/archlinux-dotfiles/bin/*; do
	path_without_sh=$(basename "$file" | cut -d'.' -f1)
	echo "Linking $file -> /usr/bin/$path_without_sh"
	sudo ln -sf "$file" /usr/bin/"$path_without_sh"
done
