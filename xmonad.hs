import XMonad
import XMonad.Config.Desktop

-- Utilities
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig(additionalKeysP)

-- Layouts
import XMonad.Layout.NoBorders

-- Hooks
import XMonad.Hooks.InsertPosition

-- xmonad :: XConfig -> IO ()
-- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad-Core.html#t:XConfig
main = xmonad $ desktopConfig
        { normalBorderColor  = "#292d3e"
        , focusedBorderColor = "#bbc5ff"
        , terminal           = "st"
        , layoutHook         = myLayouts
        , manageHook         = myManageHook
        , modMask            = mod4Mask       -- mod key to super
        , borderWidth        = 1
        , startupHook        = myStartupHook
        , focusFollowsMouse  = False          -- don't change window based on mouse position (need to click)
        } `additionalKeysP` myKeys

myLayouts = tiledBigMaster        -- bigger master for code and smaller slave for compiling
            ||| Mirror tiledEven  -- 50/50 horizontal split
            ||| noBorders Full    -- disable borders for fullscreen layout
    where tiledBigMaster = Tall 1 (3 / 100) (3 / 5)
          tiledEven      = Tall 1 (3 / 100) (1 / 2)

myStartupHook = do
    spawnOnce "xinput disable 'ETPS/2 Elantech Touchpad' &"        -- disable touchpad
    -- spawnOnce "redshift -c /home/charles/.config/redshift.conf &"  -- start redshift

myManageHook = insertPosition End Newer  -- insert new window at the end of the current layout

myKeys = [ ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")    -- volume up
         , ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")  -- volume down
         , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")  -- volume mute
         , ("<XF86MonBrightnessUp>",   spawn "xbacklight -inc 5")    -- backlight up
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 5")    -- backlight down
         , ("<XF86ScreenSaver>",       spawn "slock")                -- lock screen
         ]
