import           XMonad
import           XMonad.Config.Desktop

-- Utilities
import           XMonad.Util.EZConfig        (additionalKeysP, additionalKeys)
import           XMonad.Util.SpawnOnce

-- Layouts
import           XMonad.Layout.NoBorders

-- Hooks
import           XMonad.Hooks.InsertPosition

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
        , focusFollowsMouse  = False          -- don't change window based on mouse position (need to click)
        , workspaces         = ["code", "compile", "web"] ++ map show [4..9]
        } `additionalKeysP` myKeys

myLayouts = tiledBigMaster        -- bigger master for code and smaller slave for compiling
            ||| Mirror tiledEven  -- 50/50 horizontal split
            ||| noBorders Full    -- disable borders for fullscreen layout
    where tiledBigMaster = Tall 1 (3 / 100) (3 / 5)
          tiledEven      = Tall 1 (3 / 100) (1 / 2)

myManageHook = insertPosition End Newer  -- insert new window at the end of the current layout

myKeys = [ ("<XF86AudioRaiseVolume>",  spawn "~/bin/volume-ctl up")
         , ("<XF86AudioLowerVolume>",  spawn "~/bin/volume-ctl down")
         , ("<XF86AudioMute>",         spawn "~/bin/volume-ctl mute")
         , ("<XF86MonBrightnessUp>",   spawn "~/bin/backlight-ctl up")
         , ("<XF86MonBrightnessDown>", spawn "~/bin/backlight-ctl down")
         , ("<XF86ScreenSaver>",       spawn "slock")

         , ("M-o",                     spawn "~/bin/project-open")
         , ("M-S-o",                   spawn "cd ~/test && st")
         , ("M-d",                     spawn "cd ~/Downloads && st")
         , ("M-m",                     spawn "st -e mocp")
         , ("M-S-d",                   spawn "notify-send \"$(date +\"%H:%M %A %d/%m/%Y %B\")\"")
         ]
