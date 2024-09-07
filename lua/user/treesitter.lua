require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.install").prefer_git = true

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	auto_install = true,
	refactor = {
		ensure_installed = {
			"c",
			"lua",
			"vimdoc",
			"vim",
			"go",
			"gomod",
			"gosum",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
		},
		navigation = {
			enable = true,
			keymaps = {
				goto_definition = "gd",
				list_definitions = "gD",
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
		enable = true,
		additional_vim_regex_highlighting = false,
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
