local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	-- lazy load this plugin
	extensions = {
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg", -- find command (defaults to `fd`)
			on_enter = function(filepath)
				vim.fn.setreg("+", filepath)
				vim.notify("The image path has been copied to system clipboard!")
			end,
		},
	},
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
		layout_config = {
			horizontal = {
				width_padding = 0.04,
				height_padding = 0.1,
				preview_width = 0.6,
			},
			vertical = {
				width_padding = 0.05,
				height_padding = 1,
				preview_height = 0.5,
			},
		},
	},
})
