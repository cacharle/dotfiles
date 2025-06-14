# dotfiles

## Installation

Make sure to backup your current configuration files, they will be overwritten.

```
$ git clone --recursive git://git.cacharle.xyz/dotfiles
$ cd dotfiles
$ ./install
```

## Tools I use

| Name        | Link                               | Description                     |
|-------------|------------------------------------|---------------------------------|
| vim         | https://github.com/vim/vim         | Terminal text editor            |
| zsh         | https://www.zsh.org/               | Interactive shell               |
| xmonad      | https://xmonad.org                 | Window manager                  |
| qutebrowser | https://www.qutebrowser.org        | Vim like browser                |
| mutt        | http://www.mutt.org/               | Email client                    |
| newsboat    | https://newsboat.org/              | RSS feed reader                 |
| zathura     | https://pwmt.org/projects/zathura/ | PDF viewer with vim keybindings |
| sxiv        | https://github.com/muennich/sxiv   | Simple image viewer             |
| mpv         | https://mpv.io/                    | Simple video player             |
| moc         | https://moc.daper.net/             | Music player                    |
| redshift    | http://jonls.dk/redshift/          | Change screen color temperature |

## Credit

* mpv script youtube quality - <https://github.com/jgreco/mpv-youtube-quality>

## TODO

- [ ] atuin - <https://github.com/atuinsh/atuin?tab=readme-ov-file>
- [ ] difftastic - <https://github.com/Wilfred/difftastic?tab=readme-ov-file#can-i-use-difftastic-with-git>
- [x] yazi - <https://github.com/sxyazi/yazi>
    <https://yazi-rs.github.io/docs/tips>
    - [x] image preview with ueberzug++
    - [x] drag and drop with dragon
    - [x] make default file opener https://github.com/GermainZ/xdg-desktop-portal-termfilechooser
        - [ ] Fix selection of multiple files (--chosen-file seems to work with multiple tho)
    - [ ] add nvim shortcut to open yazi in current directory and in the git root
- [ ] zoxide - <https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file>
- [x] script to mount/unmount things (encrypted or not) - https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/mounter
    OR setup a similar thing as most DE where there is a daemon listening for new usb and automatically mounting them
- [x] monero-cli
- [x] bisq
- [x] electrum for bitcoin
- [ ] Figure out how to have centered floating window in xmonad
- [ ] Figure out how to have window swallowing (for file preview mainly)
- [ ] Start obs and turn on the light (with  litra-driver (lc)) with keybinding
    - [ ] Add keybindings to control the light brightness and temperature
- [ ] Run whisper for speach as keyboard input with shortcut
