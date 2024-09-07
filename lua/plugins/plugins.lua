return {
	-- lazy.nvim:
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("telescope").setup({
				-- defaults = {
				-- 	mappings = {
				-- 		i = {
				-- 			["<C-r>"] = {
				-- 				function(p_bufnr)
				-- 					-- send results to quick fix list
				-- 					require("telescope.actions").send_to_qflist(p_bufnr)
				-- 					local qflist = vim.fn.getqflist()
				-- 					local paths = {}
				-- 					local hash = {}
				-- 					for k in pairs(qflist) do
				-- 						local path = vim.fn.bufname(qflist[k]["bufnr"]) -- extract path from quick fix list
				-- 						if not hash[path] then -- add to paths table, if not already appeared
				-- 							paths[#paths + 1] = path
				-- 							hash[path] = true -- remember existing paths
				-- 						end
				-- 					end
				-- 					-- show search scope with message
				-- 					vim.notify("find in ...\n  " .. table.concat(paths, "\n  "))
				-- 					-- execute live_grep_args with search scope
				-- 					require("telescope").extensions.live_grep_args.live_grep_args({
				-- 						search_dirs = paths,
				-- 					})
				-- 				end,
				-- 				type = "action",
				-- 				opts = {
				-- 					nowait = true,
				-- 					silent = true,
				-- 					desc = "Live grep on results",
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
			})
			require("telescope").load_extension("live_grep_args")
		end,
	},
	-- {
	-- 	"mg979/vim-visual-multi",
	-- 	priority = 1000,
	-- 	event = { "VimEnter" },
	-- },
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/lsp_signature.nvim",
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	-- My plugins here
	-- "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	{
		"nvim-lua/plenary.nvim", -- ful lua functions used ny lots of plugins
		-- lazy = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
		lazy = true,
	},

	{
		"wellle/targets.vim",
		priority = 1000,
		event = { "VimEnter" },
	},

	-- vscode
	{
		"vscode-neovim/vscode-neovim",
	},

	{
		"justinmk/vim-sneak",
		event = { "VimEnter" },
	},

	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},

	{
		"https://github.com/chaoren/vim-wordmotion",
		lazy = false,
	},

	"folke/lazydev.nvim",

	"nathom/filetype.nvim",
	-- "akinsho/bufferline.nvim",
	"kyazdani42/nvim-web-devicons",

	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	},

	"BurntSushi/ripgrep",
	"moll/vim-bbye",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"goolord/alpha-nvim",
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"sharkdp/fd",
	-- Colorschemes
	-- {
	-- 	"lunarvim/darkplus.nvim",
	-- 	priority = 1000,
	-- 	event = "BufReadPre",
	-- },
	-- {
	"tomasiser/vim-code-dark",
	-- 	priority = 1000,
	-- 	event = "BufReadPre",
	-- 	config = function()
	-- 		vim.g["codedark_term256"] = 1
	-- 		vim.cmd([[
	--               colorscheme codedark
	-- 		  hi Comment guifg=#dbaf84
	-- 		  hi String guifg=#efa29b
	-- 		  hi! link Sneak Search
	-- 		  hi Search guibg=#658da1
	-- 		  let g:sneak#label = 1
	-- 		  let g:highlightedyank_highlight_in_visual = 0
	-- 		  ]])
	-- 	end,
	-- },

	{
		"stevearc/dressing.nvim",
		opts = {},
	},

	-- color for css.
	"folke/lsp-colors.nvim",
	"chrisbra/colorizer",
	"norcalli/nvim-colorizer.lua",

	{
		"hrsh7th/nvim-cmp", -- The completion plugin
		dependencies = {
			"hrsh7th/cmp-buffer",
			{
				"hrsh7th/cmp-path",
				event = { "InsertEnter", "CmdlineEnter" },
				lazy = false,
			},
			{
				"hrsh7th/cmp-cmdline",
				event = { "InsertEnter", "CmdlineEnter" },
				lazy = false,
			},
			{
				"hrsh7th/cmp-nvim-lsp",
				event = { "InsertEnter", "CmdlineEnter" },
				lazy = false,
			},

			"saadparwaiz1/cmp_luasnip",
			"VonHeikemen/lsp-zero.nvim",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		lazy = false,
	},

	-- snippets

	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	{
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},

	"lukas-reineke/lsp-format.nvim",

	-- "brymer-meneses/grammar-guard.nvim",
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters

	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope-media-files.nvim",
			-- event = "VeryLazy",
			-- lazy = true,
			-- module = "telescope",
			-- config = function()
			-- 	require("telescope").load_extension("media_files")
			-- end,
		},
		-- event = "VeryLazy",
		-- lazy = true,
	},

	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	{
		"folke/noice.nvim",
		commit = "d9328ef",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		-- event = "VeryLazy",
	},

	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		"nvim-treesitter/nvim-treesitter-textobjects",
		"JoosepAlviste/nvim-ts-context-commentstring",
	},

	-- -- coc-nvims
	-- { "neoclide/coc.nvim", branch = "release" },

	-- airline
	-- {
	-- 	"vim-airline/vim-airline",
	-- 	event = "BufReadPre",
	-- },
	-- "vim-airline/vim-airline-themes",

	"ryanoasis/vim-devicons",

	-- {
	-- 	"github/copilot.vim",
	-- 	branch = "release",
	-- },

	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},

	-- "haya14busa/incsearch.vim",
	--
	-- "haya14busa/incsearch-easymotion.vim",

	-- nerdtree
	"tpope/vim-eunuch",

	-- dashboard
	-- "mhinz/vim-startify",

	{
		"easymotion/vim-easymotion",
		dependencies = {
			"haya14busa/incsearch.vim",
			"haya14busa/incsearch-easymotion.vim",
			"haya14busa/incsearch-fuzzy.vim",
		},

		priority = 1200,
		event = { "VimEnter" },
		lazy = false,
	},

	-- Todo plugins
	-- "unblevable/quick-scope", -- highlight the first letter of the word you are searching for
	"tpope/vim-repeat",
	"karb94/neoscroll.nvim",
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	},

	-- tab out of parenthesis
	"abecodes/tabout.nvim",
	{
		"filipdutescu/renamer.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"rcarriga/nvim-notify",
	-- syntax highlighting
	{
		"sheerun/vim-polyglot",
		-- event = { "BufReadPre" },
		lazy = true,
		event = "VeryLazy",
	},

	-- Git plugin for neovim
	-- "tpope/vim-fugitive",

	-- Debugger for neovim
	"mfussenegger/nvim-dap",
	"theHamsta/nvim-dap-virtual-text",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	"leoluz/nvim-dap-go",
	-- "ycm-core/YouCompleteMe",
	--  "puremourning/vimspector"
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- },
}
