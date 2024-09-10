require("Comment").setup({

	padding = true,
	sticky = true,
	-- ignore = nil,

	toggler = {
		---Line-comment toggle keymap
		line = "<C-_>",
		---Block-comment toggle keymap
		-- block = "gbc",
	},

	opleader = {
		line = "gc",
		block = "cq",
	},

	extra = {
		-- above = "gcO",
		below = "co",
		eol = "cA",
	},

	mappings = {
		basic = true,
		extra = true,
	},

	-- pre_hook = nil,
	-- post_hook = nil,
})
