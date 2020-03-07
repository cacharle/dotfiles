import XMonad
import XMonad.Config.Desktop

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeysP)

myModMask     = mod4Mask
myTerminal    = "st"
myTextEditor  = "vim"
myBorderWidth = 2

main = do
    xmonad $ desktopConfig
        { modMask            = myModMask
        , terminal           = myTerminal
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        } `additionalKeysP` myKeys

myKeys =  [  ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")
           , ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")
           , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")
           , ("<XF86MonBrightnessUp>",   spawn "xbacklight -inc 5")
           , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
           ]
