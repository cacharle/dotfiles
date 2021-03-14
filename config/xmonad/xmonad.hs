import           Control.Monad
import           Data.List
import           System.Exit


import           XMonad
import           XMonad.Config.Desktop       (desktopConfig)

-- Utilities
import           XMonad.Util.Dmenu           (menuArgs)
import           XMonad.Util.EZConfig        (additionalKeys, additionalKeysP)
import           XMonad.Util.SpawnOnce       (spawnOnOnce)

-- Layouts
import           XMonad.Layout.NoBorders     (noBorders)
import           XMonad.Layout.Reflect       (reflectHoriz)
import           XMonad.Layout.Spacing       (Border (..), spacingRaw)

-- Hooks
import           XMonad.Hooks.InsertPosition (Focus (..), Position (..),
                                              insertPosition)

-- xmonad :: XConfig -> IO ()
-- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad-Core.html#t:XConfig
main = xmonad $ desktopConfig
        { normalBorderColor  = "#1c1c1c"
        , focusedBorderColor = "#8a8a8a"
        , terminal           = "st"
        , layoutHook         = layoutHook'
        , manageHook         = manageHook'
        , modMask            = mod4Mask       -- mod key to super
        , borderWidth        = 2
        , focusFollowsMouse  = False          -- don't change window based on mouse position (need to click)
        , workspaces         = ["code", "web"] ++ map show [3..9]
        , startupHook        = startupHook'
        } `additionalKeysP` keys'


layoutHook' = spacing' 4 $ reflectHoriz tiledVerticalBigMaster  -- main monitor is slighly to the left
                           ||| tiledVerticalBigMaster           -- bigger master for code and smaller slave for compiling
                           ||| noBorders Full                   -- disable borders for fullscreen layout
                           ||| Mirror tiledHorizontalEven       -- 50/50 horizontal split
    where tiledVerticalBigMaster =  Tall 1 (3 / 100) (3 / 5)
          tiledHorizontalEven    =  Tall 1 (3 / 100) (1 / 2)
          spacing' x             = spacingRaw True (Border x x x x) False (Border x x x x) True

manageHook' = insertPosition End Newer  -- insert new window at the end of the current layout

keys' = [ ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")
        , ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")
        , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")
        , ("M--",                     spawn "pulseaudio-ctl down")
        , ("M-=",                     spawn "pulseaudio-ctl up")

        , ("<XF86MonBrightnessUp>",   spawn "backlight-ctl up")
        , ("<XF86MonBrightnessDown>", spawn "backlight-ctl down")
        , ("<XF86ScreenSaver>",       spawn "slock")
        , ("<XF86TouchpadToggle>",    spawn "touchpad-toggle")

        , ("M-o",                     spawn "project-open")
        , ("M-i",                     spawn "st -e zsh -c 'source ~/.config/zsh/.zshrc && rc'")
        , ("M-m",                     spawn "st -e mocp -C /home/cacharle/.config/moc/config")
        , ("M-S-d",                   spawn "notify-send -i x-office-calendar \"$(date +\"%H:%M %A %d/%m/%Y %B\")\"")
        , ("M-S-b",                   spawn "notify-send \"battery: $(cat /sys/class/power_supply/BAT0/capacity)\"")
        , ("M-q",                     spawn "notify-send 'Restarting xmonad'" >> spawn restartCmd)
        , ("M-S-q",                   confirm "Are you sure you want to shutdown?" $ io (exitWith ExitSuccess))
        ]

startupHook' :: X ()
startupHook' = do
    spawnOnOnce "code" "st"
    spawnOnOnce "web"  "qutebrowser"

confirm :: String -> X () -> X ()
confirm prompt f = do
    result <- menuArgs "dmenu" ["-p", prompt] ["yes", "no"]
    when (result == "yes") f

restartCmd :: String
restartCmd = intercalate "; " [ "if type xmonad"
                              , "then xmonad --recompile && xmonad --restart"
                              , "else xmessage xmonad not in \\$PATH: \"$PATH\""
                              , "fi"
                              ]
