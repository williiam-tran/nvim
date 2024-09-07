-- require("mini.animate").setup()
neoscroll = require("neoscroll")
local keymap = {
	["J"] = function()
		neoscroll.scroll(0.3, { move_cursor = false, duration = 50 })
	end,
	["K"] = function()
		neoscroll.scroll(-0.3, { move_cursor = false, duration = 50 })
	end,
}

local modes = { "n", "v", "x" }
for key, func in pairs(keymap) do
	vim.keymap.set(modes, key, func)
end

require("neoscroll").setup({
	mappings = {},
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = false, -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = "quadratic",
	performance_mode = false, -- Disable "Performance Mode" on all buffers.
})

-- local t = {}

-- if not vim.g.vscode then
-- 	t["<C-y>"] = { "scroll", { "-0.35", "true", "100" } }
-- 	t["<C-e>"] = { "scroll", { "0.35", "true", "100" } }
-- end

-- require("neoscroll.config").set_mappings(t)
