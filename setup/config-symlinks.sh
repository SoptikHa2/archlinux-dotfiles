# X & i3 symlinks
ln -s ~/archlinux-dotfiles/xinitrc ~/.xinitrc
ln -s ~/archlinux-dotfiles/i3/config ~/.config/i3
for f in ~/archlinux-dotfiles/x/xorg.conf.d/*; do
	ln -s "$f" /etc/X11/xorg.conf.d
done

# Polybar
mkdir -p ~/.config/polybar
ln -s ~/archlinux-dotfiles/polybar/config ~/.config/polybar

# Rofi
ln -s ~/archlinux-dotfiles/rofi ~/.config/rofi

# Alacritty
ln -s ~/archlinux-dotfiles/alacritty.yml ~/.config/alacritty.yml

# Dunst
mkdir -p ~/.config/dunst
ln -s ~/archlinux-dotfiles/dunstrc ~/.config/dunst

# Custom scripts
for file in ~/archlinux-dotfiles/bin/*; do
	path_without_sh=$(basename "$file" | cut -d'.' -f1)
	ln -s "$file" /usr/bin/"$path_without_sh"
done
