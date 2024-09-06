require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.install").prefer_git = true

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- vim.defer_fn(function()
configs.setup({
	auto_install = true,
	ensure_installed = { "c", "lua", "vim", "vimdoc", "go", "gomod", "gosum", "luadoc", "markdown" },
	refactor = {
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gnd",
				list_definitions = "gnD",
				list_definitions_toc = "gO",
				goto_next_usage = "<C-n>",
				goto_previous_usage = "<C-p>",
			},
		},
	},
	autopairs = {
		enable = true,
	},

	highlight = {
		enable = false, -- false will disable the whole extension
		-- additional_vim_regex_highlighting = true,
	},

	textobjects = {
		select = {
			enable = true,

			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
})
