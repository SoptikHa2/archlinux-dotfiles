-- example config: https://github.com/Minda1975/Minimal-Xmonad/blob/master/.xmonad/xmonad.hs

------------------------------
--         IMPORTS          --
------------------------------
-- Base
import XMonad
import qualified XMonad.StackSet as W
import Data.List (sortBy)
import Data.Function (on)
import Control.Monad (forM_, join)
import System.IO

-- Utilities
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.NamedWindows (getName)
import qualified XMonad.Util.ExtensibleState as XS

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Actions

-- Layout modifiers

-- Layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps

------------------------------
--      CONFIGURATION       --
------------------------------
myTerminal = "alacritty"
myExtraWorkspaces = [(xK_0, "Trash")]
myWorkspaces = map show [1..9] ++ map snd myExtraWorkspaces
myModMask = mod1Mask -- Alt

 ------------------------------
--       KEYBINDINGS        --
------------------------------
myKeys = [ 
        -- On $mod+d, spawn rofi for starting new programs and switching to them
        ("M-d", spawn "rofi -show combi -combi-modi 'window,run' -modi combi"),
        -- On $mod+shift+e, spawn rofi menu that enables us to reboot/poweroff/reboot to uefi and other. TODO: Quit WM support
        -- On $mod+ctrl+w, display window manager
        ("M-C-w", spawn "multimonitor-setup.sh"),
        ("M-S-e", spawn "exit-menu.sh"),
        -- Handle screen lock
        ("M-C-l", spawn "lock-custom.sh"),
        -- Handle screenshots.
        -- PrtSc to take screenshot, and save it to a file.
        -- Use Ctrl to save only current window, and shift to save to clipboard.
        -- This may be combined.
        -- Use Alt+PrtSc to display proper screenshot manager
        ("<Print>", spawn "maim ~/data/Pictures/Screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"),
        ("C-<Print>", spawn "maim -i $(xdotool getwindowfocus) ~/data/Pictures/Screenshot-$(date +%Y-%m-%d-%H-%M-%S).png"),
        ("S-<Print>", spawn "maim | xclip -selection clipboard -t image/png"),
        ("C-S-<Print>", spawn "maim -i $(xdotool getwindowfocus) | xclip -selection clipboard -t image/png"),
        ("M-<Print>", spawn "flameshot gui"),
        -- Handle brightness up/down
        ("<XF86MonBrightnessDown>", spawn "change-brightness.sh 0"),
        ("<XF86MonBrightnessUp>", spawn "change-brightness.sh 1"),
        -- Handle volume up/down + mute, autounmute
        ("<XF86AudioRaiseVolume>", spawn "pavolume.sh --up"),
        ("<XF86AudioLowerVolume", spawn "pavolume.sh --down"),
        ("<XF86AudioMute>", spawn "pavolume.sh --togmute"),
        -- Handle playing/pausing/skipping songs (eg Spotify)
        ("<XF86AudioPrev>", spawn "playerctl previous"),
        ("<XF86AudioNext>", spawn "playerctl next"),
        ("<XF86AudioPlay>", spawn "playerctl play-pause")

    ]


----------------------------
--     IMPLEMENTATION     --
----------------------------
main = do
    -- Spawn compositor and set background image
    spawn "picom --daemon --backend xrender"
    spawn "feh --bg-fill ~/archlinux-dotfiles/wallpaper.png"
    -- Notifications
    spawn "dunst"
    -- Lock screen when lid is closed
    spawn "xss-lid -- lock-custom.sh"
    -- Automount USBs
    spawn "udiskie"
    -- Redshift (first of all kill old instances)
    spawn "killall redshift; redshift -P"
    -- Bar
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    
    xmonad $ defaultConfig
        {
            terminal = myTerminal,
            workspaces = myWorkspaces,
            modMask = myModMask,
            -- Bar START
            manageHook = manageDocks <+> manageHook defaultConfig,
            layoutHook = avoidStruts $ layoutHook defaultConfig,
            handleEventHook = handleEventHook defaultConfig <+> docksEventHook,
            logHook = dynamicLogWithPP $ xmobarPP {
                    ppOutput = hPutStrLn xmproc,
                    ppTitle = xmobarColor "gray" "" . shorten 50
                }
            -- Bar END
        } `additionalKeysP` myKeys




