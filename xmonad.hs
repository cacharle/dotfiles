import XMonad
import XMonad.Config.Desktop

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeysP)

-- Layouts
import XMonad.Layout.NoBorders


main = do
    xmonad $ desktopConfig
        { modMask            = mod4Mask       -- mod key to super
        , terminal           = "konsole"
        , borderWidth        = 1
        , focusFollowsMouse  = False          -- don't change window based on mouse position (need to click)
        , normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        , layoutHook         = myLayouts
        , startupHook        = myStartupHook
        } `additionalKeysP` myKeys

myLayouts = tiledBigMaster ||| Mirror tiledEven ||| noBorders Full
    where tiledBigMaster = Tall 1 (3 / 100) (3 / 5)
          tiledEven      = Tall 1 (3 / 100) (1 / 2)


myStartupHook = do
    spawnOnce "redshift -c /home/charles/.config/redshift.conf &"
    spawnOnce "xinput disable 'ETPS/2 Elantech Touchpad' &"

myKeys = [ ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")
         , ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")
         , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")
         , ("<XF86MonBrightnessUp>",   spawn "xbacklight -inc 5")
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")
         ]
