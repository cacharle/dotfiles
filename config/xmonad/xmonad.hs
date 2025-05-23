import           Control.Monad
import           Data.List
import           System.Exit


import           XMonad
import           XMonad.Config.Desktop       (desktopConfig)
import           XMonad.ManageHook           (composeAll, willFloat, doFloat, doF, className, stringProperty, (-->), (=?), (<+>))

-- Utilities
import           XMonad.Util.Dmenu           (menuArgs)
import           XMonad.Util.EZConfig        (additionalKeys, additionalKeysP)
import           XMonad.Util.SpawnOnce       (spawnOnOnce)

-- Layouts
import           XMonad.Layout.NoBorders     (noBorders)
import           XMonad.Layout.Reflect       (reflectHoriz)
import           XMonad.Layout.Spacing       (Border (..), spacingRaw)
import           XMonad.Layout.Grid          (Grid (..))
import           XMonad.Layout.ThreeColumns  (ThreeCol (ThreeColMid))
import           XMonad.Layout.CenteredIfSingle (centeredIfSingle)
import           XMonad.Layout.OnHost           (onHost)
import           XMonad.Layout.MultiColumns     (multiCol)
import           XMonad.Layout.Gaps             (gaps, Direction2D(U))

-- Hooks
import           XMonad.Hooks.InsertPosition (Focus (..), Position (..),
                                              insertPosition)
import           XMonad.Hooks.WindowSwallowing
import           XMonad.Hooks.ManageHelpers  (isDialog)
import           XMonad.Hooks.ManageDocks    (manageDocks, avoidStruts, docks)

import           XMonad.StackSet             (swapUp)

-- TODO: no weird screen layout
--       put 2 window in master next to each other and the rest in a stack as usual
import XMonad.Layout.LayoutScreens
import XMonad.Layout.TwoPane

-- myTerminal = "alacritty"
myTerminal = "wezterm"


-- xmonad :: XConfig -> IO ()
-- https://hackage.haskell.org/package/xmonad-0.15/docs/XMonad-Core.html#t:XConfig
main = xmonad $ docks $ desktopConfig
        { normalBorderColor  = "#1c1c1c"
        , focusedBorderColor = "#8a8a8a"
        , terminal           = myTerminal
        , layoutHook         = layoutHook'
        , manageHook         = manageDocks <+> manageHook'
        , modMask            = mod4Mask       -- mod key to super
        , borderWidth        = 2
        , focusFollowsMouse  = False          -- don't change window based on mouse position (need to click)
        , workspaces         = ["code", "web"] ++ map show [3..9]
        -- , handleEventHook    = handleEventHook'
        -- , startupHook        = startupHook'
        } `additionalKeysP` keys'


layoutHook' = spacing' 4 $ avoidStruts $ onHost "charles-fractal" ultraWideLayout commonLayout
    where ultraWideLayout = threeColMid ||| multiCol [1, 1] 2 (-0.05) (-0.25) ||| commonLayout
          commonLayout = reflectHoriz tiledVerticalBigMaster  -- main monitor is slighly to the left
                         ||| tiledVerticalBigMaster           -- bigger master for code and smaller slave for compiling
                         ||| noBorders Full                   -- disable borders for fullscreen layout
                         ||| Mirror tiledHorizontalEven       -- 50/50 horizontal split
                         ||| Grid
                         -- ||| layoutScreens 2 (TwoPane 0.5 0.5)
          threeColMid = centeredIfSingle (1/2) (95/100) (ThreeColMid 1 (3/100) (1/2))
          tiledVerticalBigMaster =  Tall 1 (3 / 100) (3 / 5)
          tiledHorizontalEven    =  Tall 1 (3 / 100) (1 / 2)
          spacing' x             = spacingRaw True (Border x x x x) False (Border x x x x) True

manageHook' = composeAll
    [ insertPosition Below Newer  -- insert new window at the end of the current layout
    , fmap not willFloat --> insertPosition Below Newer
    , willFloat --> insertPosition Above Newer -- insert little pop up windows above all the rest
    , className =? "Anki"  --> doFloat
    , className =? "Steam" --> doFloat
    , className =? "CustomFloating" --> doFloat
    , stringProperty "WM_NAME(UTF8_STRING)" =? "Bitwarden" --> doFloat
    -- , className =? "Gimp" --> doFloat
    -- , className =? "OBS" --> doFloat
    , isDialog --> doF swapUp
    ]

keys' = [ ("<XF86AudioLowerVolume>",  spawn "pulseaudio-ctl down")
        , ("<XF86AudioRaiseVolume>",  spawn "pulseaudio-ctl up")
        , ("<XF86AudioMute>",         spawn "pulseaudio-ctl mute")
        , ("<XF86AudioMicMute>",      spawn "pulseaudio-ctl mute-input")
        , ("M--",                     spawn "pulseaudio-ctl down")
        , ("M-=",                     spawn "pulseaudio-ctl up")
        -- , ("M-g",                     layoutSplitScreen 2 (TwoPane 0.5 0.5))
        -- , ("M-f",                     rescreen)

        , ("<XF86MonBrightnessUp>",   spawn "backlight-ctl up")
        , ("<XF86MonBrightnessDown>", spawn "backlight-ctl down")
        , ("<XF86TouchpadToggle>",    spawn "touchpad-toggle")
        , ("<XF86ScreenSaver>",       spawn "i3lock")
        , ("M-<Delete>",              spawn "i3lock")

        , ("M-o",                     spawn "project-open")
        , ("M-p",                     spawn "rofi -show run")
        , ("<XF86Search>",            spawn "rofi -show run")
        , ("M-s",                     spawn "rofi -show ssh")
        , ("M-u",                     spawn "rofi -show window")
        , ("M-S-u",                   spawn "udiskie-umount-prompt")
        , ("M-i",                     spawn "insert-special-character")
        , ("M-S-i",                   spawn "insert-special-character copy")
        , ("M-S-t",                   spawn "translate-prompt")
        , ("M-a",                     spawn "screenshot-prompt")
        , ("M-S-l",                   spawn "logitec-litra-toggle")
        , ("M-S-d",                   spawn "notify-send -i x-office-calendar \"$(date +\"%H:%M %A %d/%m/%Y %B\")\"")
        , ("M-S-b",                   spawn "battery-notify")
        , ("M-S-m",                   spawn "xmobar-toggle")
        , ("M-S-s",                   spawn "toggle-screenkey")
        , ("M-q",                     spawn "notify-send 'Restarting xmonad'" >> spawn restartCmd)
        , ("M-S-q",                   spawn "exit-session-prompt")
        -- , ("M-S-q",                   confirm "Are you sure you want to shutdown?" $ io exitSuccess)

        -- , ("M1-a",                   spawn "xdotool type à")
        -- , ("M1-e",                   spawn "xdotool type à")
        ]

-- startupHook' :: X ()
-- startupHook' = do
    -- spawnOnOnce "code" myTerminal
    -- spawnOnOnce "web"  "qutebrowser"

confirm :: String -> X () -> X ()
confirm prompt f = do
    result <- menuArgs "rofi" ["-dmenu", "-p", prompt] ["yes", "no"]
    when (result == "yes") f

restartCmd :: String
restartCmd = intercalate "; " [ "if type xmonad"
                              , "then xmonad --recompile && xmonad --restart"
                              , "else xmessage xmonad not in \\$PATH: \"$PATH\""
                              , "fi"
                              ]

-- handleEventHook' = swallowEventHook (className =? "Alacritty" <||> className =? "Termite") (return True)
