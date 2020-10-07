# if [[ "$(tty)" = "/dev/tty1" ]]; then
#     startx
    # xset r rate 200 40
#     poweroff
# fi

# # Disable natural scrolling
# defaults write "Apple Global Domain" com.apple.swipescrolldirection -bool false
#
# # Enable dark theme
# osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
#
# # Keyrepeat delay
# defaults write NSGlobalDomain InitialKeyRepeat -int 15
# defaults write NSGlobalDomain KeyRepeat -int 2
#
# # Change desktop picture
# # osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"/Users/$(whoami)/background.jpg\""
#
# # Night shift
# defaults write com.apple.universalaccess lastNightShiftActive  -int 1
# defaults write com.apple.universalaccess lastNightShiftEnabled -int 1
# defaults write com.apple.universalaccess lastNightShiftMode    -int 0
