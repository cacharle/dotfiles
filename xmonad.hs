import XMonad
import XMonad.Config.Desktop

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeysP)

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
        } `additionalKeysP` myKeys

myStartupHook = do
    spawnOnce "redshift -c /home/charles/.config/redshift.conf &"
    spawnOnce "xinput disable 'ETPS/2 Elantech Touchpad' &"

myKeys =  [  ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")
           , ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")
           , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")
           ]
           -- , ("<XF86AudioPlay>",         spawn "playerctl play-pause")
           -- , ("<XF86AudioPrev>",         spawn "playerctl previous")
           -- , ("<XF86AudioNext>",         spawn "playerctl next")
           -- , ("<XF86MonBrightnessUp>",   spawn "lux -a 5%")
           -- , ("<XF86MonBrightnessDown>", spawn "lux -s 5%")
