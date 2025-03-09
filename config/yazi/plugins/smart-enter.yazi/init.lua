--- @since 25.2.26
--- @sync entry

-- from: https://yazi-rs.github.io/docs/tips#smart-enter
local function setup(self, opts) self.open_multi = opts.open_multi end

local function entry(self)
	local h = cx.active.current.hovered
	ya.mgr_emit(h and h.cha.is_dir and "enter" or "open", { hovered = not self.open_multi })
end

return { entry = entry, setup = setup }
