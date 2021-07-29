local mp = require 'mp'

local description_cache = nil
function description()
    if description_cache ~= nil then
        return description_cache
    end
    local url = mp.get_property("path")
    mp.osd_message("Fetching description", 2)
    local process = io.popen("youtube-dl --get-description '" .. url .. "'", "r")
    description_cache = process:read("*a")
    return description_cache
end

function open_editor()
    os.execute("st -e /usr/bin/zsh -c 'echo \"" .. description() .. "\" | vim -'")
end

mp.add_key_binding("Ctrl+Shift+d", "open-description", open_editor)
