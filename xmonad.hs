import XMonad
import XMonad.Config.Desktop

-- Utilities
import XMonad.Util.SpawnOnce

myModMask     = mod4Mask
myTerminal    = "konsole"
myTextEditor  = "vim"
myBorderWidth = 2

main = do
    xmonad $ desktopConfig
        { modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        }

myStartupHook = do
    spawnOnce "redshift &"
    spawnOnce "xinput disable 'ETPS/2 Elantech Touchpad' &"
