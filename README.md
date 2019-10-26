# archlinux-dotfiles
Archlinux i3 dotfiles

## Useful hotkeys

|Key combo|Effect|
|---|---|
|`<Esc>`|Acts as capslock|
|`<CapsLock>`|Acts as escape|
|`<A-d>`|Opens rofi - start/switch programs|
|`<A-Q>`|Kills currently focused program|
|`<A-w>`|Opens wireless menu in rofi: switch wifi/ethernet, connect to VPN|
|`<A-t>`|Opens monitor setup menu in rofi: switch between monitors, or combine them together in multiple ways|
|`<A-Tab>`|Switch keyboards (currently: US and Czech Qwerty)|
|`<A-g>`|Enter gaming mode - most hotkeys are disabled (incl. window/workspace i3 hotkeys) (except kill, fullscreen, and exit gaming mode)|
|`<A-Esc>`|Exit gaming mode|
|`<A-f>`|Toggle fullscreen on currently focused window|
|`<A-[1,2..0]>`|Switch to i3 workspace 1,2..10|
|`<A-Enter>`|Start terminator|
|`<A-E>`|Exit i3|
|`<A-jkl;>`|Move window focus|
|`<A-JKL:>`|Move windows|
|`<PrtSc>`|Take a screenshot and save it into `~/data/Pictures`|
|`<S-PrtSc>`|Take a screenshot and save it into clipboard|
|`<C-PrtSc>`|Take a screenshot of current window and save it into `~/data/Pictures`|
|`<S-C-PrtSc>`|Take a screenshot of current window and save it into clipboard|
|`<C-Space>`|Dismiss notification|

## Useful aliases
|Alias|Real command|
|---|---|
|`please`|`sudo`|
|`ga`|`git add`|
|`gc`|`git commit`|
|`gs`|`git status`|
|`gd`|`git diff`|
|`gds`|`git diff --staged` (works on files that were `ga`'ed)|
|`gaa`|`git add -u` (adds all tracked modified files)|
|`wifi`|`please wifi-menu`|

## Tips & tricks
|Trick|Description|
|---|---|
| FF config: `full-screen-api.ignore-widgets = true` | Fullscreen videos are not really fullscreen, but are borderless intead. See first screenshot, but it's quite nice feature. |

## Screenshots

Borderless fullscreen video in Firefox (!, not via youtubedl)

![Borderless fullscreen video in Firefox](https://raw.githubusercontent.com/SoptikHa2/archlinux-dotfiles/master/screenshots/firefox-video-fullscreen-in-window.png)

Neofetch and firefox (the tree style tabs window shrinks when I don't have mouse over it):
![Screenshot Archlinux Rice i3 - Neofetch](https://raw.githubusercontent.com/SoptikHa2/archlinux-dotfiles/master/screenshots/firefox-neofetch.png)

Locked with i3lock and custom image:
![Screenshot Archlinux Rice i3 - locked](https://raw.githubusercontent.com/SoptikHa2/archlinux-dotfiles/master/lockscreen.png)
