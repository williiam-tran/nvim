require("copilot").setup({
	panel = {
		enabled = false,
		auto_refresh = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = false,
		hide_during_completion = true,
		debounce = 75,
		keymap = {
			accept = "<CR>",
			accept_word = false,
			accept_line = true,
		},
	},
})
