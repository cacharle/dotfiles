import platform
from pathlib import Path
import socket


config.load_autoconfig(True)

c.aliases = {
    "q": "close",
    "sc": "config-source",
    # "bw": """spawn --userscript qute-bitwarden -d "dmenu -P -p "master password"" """,
    "bw": """spawn --userscript qute-bitwarden""",
}

try:
    socket.getaddrinfo("searx.home", 80)
except socket.gaierror:
    searx_url = "https://searx.cacharle.xyz"
else:
    searx_url = "http://searx.home"
default_search_engine = "https://google.com"

c.url.start_pages = [default_search_engine]
c.url.searchengines = {
    "DEFAULT": default_search_engine + "?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "g": "https://google.com/?q={}",
    "sp": "https://www.startpage.com/sp/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "w": "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1",
    "wfr": "https://fr.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1",
    "gh": "https://github.com/search?q={}",
    "h": "https://hoogle.haskell.org/?hoogle={}",
    "cpp": "http://cplusplus.com/search.do?q={}",
    "lar": "https://www.larousse.fr/dictionnaires/francais/{}",
    "pypi": "https://pypi.org/search/?q={}",
    "intra": "https://profile.intra.42.fr/searches/search?query={}",
    "aw": "https://wiki.archlinux.org/index.php?search={}",
    "pd": "https://pandas.pydata.org/pandas-docs/stable/search.html?q={}",
    "sk": "https://scikit-learn.org/stable/search.html?q={}",
    "imdb": "https://www.imdb.com/find?q={}",
    "wiby": "https://wiby.me/?q={}",
    "dlfren": "https://www.deepl.com/translator#fr/en/{}",
    "dlenfr": "https://www.deepl.com/translator#en/fr/{}",
    "dldeen": "https://www.deepl.com/translator#de/en/{}",
    "dlende": "https://www.deepl.com/translator#en/de/{}",
}

c.window.hide_decoration = False
config.bind("<Command-Return>", "config-cycle window.hide_decoration true false", mode="normal")

# package noto-fonts-emoji on ArchLinux
c.fonts.default_family = ["Fira Mono", "Baekmuk", "Noto Color Emoji", "Symbola"]
c.fonts.hints = "bold 11pt default_family"
if platform.system() == "Darwin":
    c.fonts.default_family = ["FiraCode Nerd Font Mono", "FiraMono"]
    c.fonts.default_size = "13pt"
    c.fonts.hints = "bold 12pt default_family"

c.hints.chars = "asdfghjkl;"  # use key in the main row for hints

c.editor.command = "/usr/bin/alacritty -e /usr/bin/vim {file} +{line} -c startinsert!".split(" ")

c.messages.timeout = 4000

config.bind(
    ";v",
    """
        hint links spawn
            /usr/bin/mpv
            --ytdl-raw-options=yes-playlist=
            --ytdl-format="bestvideo[height<=?1440][fps<=?60]+bestaudio/best"
            {hint-url} ;;
        message-info "opening in video player"
    """.replace(
        "\n", " "
    ),
)

config.bind("<Ctrl-J>", "completion-item-focus next", "command")
config.bind("<Ctrl-K>", "completion-item-focus prev", "command")

config.bind("J", "tab-prev", "normal")
config.bind("K", "tab-next", "normal")

config.bind("gJ", "tab-move -", "normal")
config.bind("gK", "tab-move +", "normal")

config.bind("<F12>", "devtools", "normal")

config.bind("j", "scroll-page 0  0.05", "normal")
config.bind("k", "scroll-page 0 -0.05", "normal")

config.unbind("d", "normal")
config.bind("dd", "tab-close", "normal")

# Can"t create a shortcut to toggle darkmode since it requires a restart
# (qute://help/settings.html#colors.webpage.darkmode.enabled)
c.colors.webpage.darkmode.enabled = True  # Convert light themed sites to dark theme
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "smart"

config.bind(
    "<Ctrl-Shift-t>", "config-cycle -p content.proxy socks://localhost:9050/ system", mode="normal"
)
c.content.autoplay = False
c.content.notifications.enabled = False
c.content.prefers_reduced_motion = True
c.content.headers.do_not_track = True
# c.content.cookies.accept = "no-3rdparty"

# adblock on youtube isn"t supported: https://github.com/qutebrowser/qutebrowser/issues/6480
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
]

c.content.headers.user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/{webkit_version} (KHTML, like Gecko) {qt_key}/{qt_version}"
c.auto_save.session = True
c.session.lazy_restore = True

download_path = Path("~").expanduser() / "dl"
if not download_path.exists():
    download_path.mkdir()
c.downloads.location.directory = str(download_path)
c.downloads.remove_finished = 5000

c.tabs.last_close = "startpage"
c.tabs.title.format = "{audio}{current_title}"
c.tabs.select_on_remove = "last-used"

# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Gruvbox dark, hard scheme by Dawid Kurek (dawikur@gmail.com), morhetz (https://github.com/morhetz/gruvbox)

base00 = "#1d2021"
base01 = "#3c3836"
base02 = "#504945"
base03 = "#665c54"
base04 = "#bdae93"
base05 = "#d5c4a1"
base06 = "#ebdbb2"
base07 = "#fbf1c7"
base08 = "#fb4934"
base09 = "#fe8019"
base0A = "#fabd2f"
base0B = "#b8bb26"
base0C = "#8ec07c"
base0D = "#83a598"
base0E = "#d3869b"
base0F = "#d65d0e"

# set qutebrowser colors

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base05

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base01

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base0A

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base00

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base00

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base05

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base02

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = base02

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = base02

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base0B

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = base01

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = base04

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg = base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base02

# Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = base05

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Font color for hints.
c.colors.hints.fg = base00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = base0A

# Font color for the matched part of hints.
c.colors.hints.match.fg = base05

# Text color for the keyhint widget.
c.colors.keyhint.fg = base05

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = base05

# Background color of the keyhint widget.
c.colors.keyhint.bg = base00

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base02

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B

# Background color of the statusbar.
c.colors.statusbar.normal.bg = base00

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = base00

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = base0D

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base01

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = base05

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = base00

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base0D

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = base05

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = base0C

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = base0B

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base0E

# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base01

# Foreground color of unselected odd tabs.
c.colors.tabs.even.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.even.bg = base01

# # Foreground color of unselected even tabs.
# c.colors.tabs.even.fg = base05
#
# # Background color of unselected even tabs.
# c.colors.tabs.even.bg = base00

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base0C

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = base07

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.odd.bg = base0C

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.odd.fg = base07

# # Background color of pinned unselected odd tabs.
# c.colors.tabs.pinned.odd.bg = base0B
#
# # Foreground color of pinned unselected odd tabs.
# c.colors.tabs.pinned.odd.fg = base07

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base02

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = base05

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base02

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = base05

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base02

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base05

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base02

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base05

# Background color for webpages if unset (or empty to use the theme"s
# color).
c.colors.webpage.bg = base00
