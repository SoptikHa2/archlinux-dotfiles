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
myWorkspaces = map show [0..9] ++ ["Trash"]


------------------------------
--       KEYBINDINGS        --
------------------------------
myKeys = [ 
        -- On $mod+d, spawn rofi for starting new programs and switching to them
        ("M-d", spawn "rofi -show combi -combi-modi 'window,run' -modi combi"),
        -- On $mod+shift+e, spawn rofi menu that enables us to reboot/poweroff/reboot to uefi and other. TODO: Quit WM support
        ("M-S-e", spawn "exit-menu.sh")
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
    -- Bar
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
    
    xmonad $ defaultConfig
        {
            terminal = myTerminal,
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




