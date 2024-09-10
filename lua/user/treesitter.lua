require("nvim-treesitter.install").compilers = { "clang", "gcc" }
require("nvim-treesitter.install").prefer_git = true

local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	auto_install = true,
	refactor = {
		ensure_installed = { "c", "lua", "vimdoc", "vim", "go", "gomod", "gosum", "luadoc", "markdown" },
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

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	autopairs = {
		enable = true,
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
local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.keymap.set("n", "gl", function()
	require("various-textobjs").url()
	local foundURL = vim.fn.mode():find("v")
	if foundURL then
		vim.cmd.normal('"zy')
		local url = vim.fn.getreg("z")
		vim.ui.open(url)
	else
		-- find all URLs in buffer
		local urlPattern = require("various-textobjs.charwise-textobjs").urlPattern
		local bufText = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		local urls = {}
		for url in bufText:gmatch(urlPattern) do
			table.insert(urls, url)
		end
		if #urls == 0 then
			return
		end

		-- Use Telescope picker
		pickers
			.new({}, {
				prompt_title = "URLs in Buffer",
				finder = finders.new_table({
					results = urls,
				}),
				sorter = conf.generic_sorter({}),
				initial_mode = "normal",
				sorting_strategy = "ascending",
				layout_config = {
					height = 0.5,
					width = 0.5,
					prompt_position = "top",
				},
				previewer = false,
				attach_mappings = function(prompt_bufnr, map)
					actions.select_default:replace(function()
						actions.close(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						vim.ui.open(selection[1])
					end)
					return true
				end,
			})
			:find()
	end
end, { desc = "URL Opener" })

require("pounce").setup({
	accept_keys = "ASDJKLQWEUIO",
	accept_best_key = "<Tab>",
	multi_window = true,
	debug = false,
})
