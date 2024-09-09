local telescope = require("telescope")
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup({
	-- lazy load this plugin
	extensions = {
		live_grep_args = {
			previewer = false,
			auto_quoting = false, -- enable/disable auto-quoting
			-- define mappings, e.g.
			-- ... also accepts theme settings, for example:
			-- theme = "dropdown", -- use dropdown theme
			-- theme = { }, -- use own theme spec
			layout_config = { mirror = true }, -- mirror preview pane
		},
		file_browser = {
			path = vim.fn.expand("%:p:h"),
			previewer = false,
			initial_mode = "insert",
			select_buffer = true,
			files = false,
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					["<A-n>"] = fb_actions.create,
					["<CR>"] = fb_actions.create_from_prompt,
					-- ["<A-r>"] = fb_actions.rename,
					-- ["<A-m>"] = fb_actions.move,
					-- ["<A-y>"] = fb_actions.copy,
					-- ["<A-d>"] = fb_actions.remove,
					-- ["<C-o>"] = fb_actions.open,
					-- ["<C-g>"] = fb_actions.goto_parent_dir,
					-- ["<C-e>"] = fb_actions.goto_home_dir,
					-- ["<C-w>"] = fb_actions.goto_cwd,
					-- ["<C-t>"] = fb_actions.change_cwd,
					-- ["<C-f>"] = fb_actions.toggle_browser,
					-- ["<C-h>"] = fb_actions.toggle_hidden,
					-- ["<C-s>"] = fb_actions.toggle_all,
					-- ["<bs>"] = fb_actions.backspace,
				},
				["n"] = {
					["o"] = fb_actions.create,
					["r"] = fb_actions.rename,
					["m"] = fb_actions.move,
					["y"] = fb_actions.copy,
					["d"] = fb_actions.remove,
					["b"] = fb_actions.goto_parent_dir,
					-- ["h"] = fb_actions.goto_home_dir,
					-- ["w"] = fb_actions.goto_cwd,
					-- ["t"] = fb_actions.change_cwd,
					-- ["f"] = fb_actions.toggle_browser,
					-- ["s"] = fb_actions.toggle_all,
				},
			},
		},
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
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mod = "smart_case",
		},
	},
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim", -- add this value
		},

		pickers = {
			previewer = false,
			file_browser = {
				previewer = false,
			},
			buffers = {
				initial_mode = "normal",
			},
			find_files = {
				previewer = false,
			},
		},

		mappings = {
			i = {
				["<Esc>"] = actions.close,
				["<C-q>"] = function(prompt_bufnr)
					local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
					-- local selection = picker:get_selection()
					local results = picker:get_multi_selection() -- Get selected results

					-- Prepare the quickfix list
					local qflist = {}
					for _, entry in ipairs(results) do
						table.insert(qflist, {
							filename = entry.filename,
							lnum = entry.lnum,
							text = entry.text,
						})
					end

					-- Set the quickfix list
					vim.fn.setqflist(qflist)
					-- Optionally, open the quickfix list
					vim.cmd("copen")
				end,
			},
			n = {
				["q"] = actions.close,
				["<C-q>"] = function(prompt_bufnr)
					local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
					local selection = picker:get_selection()
					local results = picker:get_multi_selection() -- Get selected results

					-- Prepare the quickfix list
					local qflist = {}
					for _, entry in ipairs(results) do
						table.insert(qflist, {
							filename = entry.filename,
							lnum = entry.lnum,
							text = entry.text,
						})
					end

					-- Set the quickfix list
					vim.fn.setqflist(qflist)
					-- Optionally, open the quickfix list
					vim.cmd("copen")
				end,
				["<C-r>"] = {
					function(p_bufnr)
						-- send results to quick fix list
						require("telescope.actions").send_to_qflist(p_bufnr)
						local qflist = vim.fn.getqflist()
						local paths = {}
						local hash = {}
						for k in pairs(qflist) do
							local path = vim.fn.bufname(qflist[k]["bufnr"]) -- extract path from quick fix list
							if not hash[path] then -- add to paths table, if not already appeared
								paths[#paths + 1] = path
								hash[path] = true -- remember existing paths
							end
						end
						-- show search scope with message
						vim.notify("find in ...\n  " .. table.concat(paths, "\n  "))
						-- execute live_grep_args with search scope
						require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = paths })
					end,
					type = "action",
					opts = {
						nowait = true,
						silent = true,
						desc = "Live grep on results",
					},
				},
			},
		},
		layout_config = {
			horizontal = {
				preview_cutoff = 1,
				width_padding = 0.04,
				height_padding = 0.01,
				preview_width = 0.6,
				prompt_position = "top",
			},
			vertical = {
				width_padding = 0.05,
				height_padding = 1,
				preview_height = 0.5,
			},
		},
	},
})

-- builtin.find_files({
-- 	previewer = false,
-- 	shorten_path = true,
-- })

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("noice")
