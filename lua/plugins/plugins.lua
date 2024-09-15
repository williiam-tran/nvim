return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- set this if you want to always pull the latest change
		opts = {
			-- add any opts here
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		-- build = "make",
		build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup({
				-- event = { "InsertEnter", "LspAttach" },
				-- fix_pairs = true,
			})
		end,
		event = { "InsertEnter", "CmdlineEnter" },
		lazy = false,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot", -- Load on command
		event = "InsertEnter", -- Load when entering insert mode
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
	-- 		{
	-- 			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
	-- 			opts = {},
	-- 		},
	-- 		"nvim-telescope/telescope.nvim", -- Optional: For using slash commands
	-- 	},
	-- 	config = true,
	-- },
	-- {
	-- 	"mrjones2014/legendary.nvim",
	-- 	priority = 10000,
	-- 	lazy = false,
	-- },
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	"gelguy/wilder.nvim",
	{
		"echasnovski/mini.files",
		version = "*",
		dependencies = {
			{ "echasnovski/mini.icons", version = false },
		},
	},
	{
		"rmagatti/goto-preview",
		event = "BufEnter",
		config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
	},
	{
		"olimorris/persisted.nvim",
		lazy = false, -- make sure the plugin is always loaded at startup
		config = true,
	},
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	{
		"rlane/pounce.nvim",
		lazy = false,
	},
	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
	},
	{
		"NeogitOrg/neogit",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	"lewis6991/gitsigns.nvim",
	"chrisgrieser/nvim-various-textobjs",
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	-- {
	-- 	"chipsenkbeil/distant.nvim",
	-- 	branch = "v0.3",
	-- 	config = function()
	-- 		require("distant"):setup({
	-- 			{
	-- 				buffer = {
	-- 					watch = {
	-- 						enabled = true,
	-- 					},
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	lazy = false,
	-- },
	"windwp/nvim-ts-autotag",
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	-- { "ojroques/vim-oscyank", branch = "main" },
	{
		"mikesmithgh/kitty-scrollback.nvim",
		enabled = true,
		lazy = true,
		cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
		event = { "User KittyScrollbackLaunch" },
	},
	-- {
	-- 	"m00qek/baleia.nvim",
	-- 	version = "*",
	-- 	config = function()
	-- 		vim.g.baleia = require("baleia").setup({})
	--
	-- 		-- Command to colorize the current buffer
	-- 		vim.api.nvim_create_user_command("BaleiaColorize", function()
	-- 			vim.g.baleia.once(vim.api.nvim_get_current_buf())
	-- 		end, { bang = true })
	--
	-- 		-- Command to show logs
	-- 		vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
	-- 	end,
	-- },
	{ "Bilal2453/luvit-meta", lazy = true },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	"kiyoon/telescope-insert-path.nvim",
	{ "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("live_grep_args")
		end,
	},
	{
		"mg979/vim-visual-multi",
		priority = 1000,
		event = { "VimEnter" },
	},
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

	{
		"vscode-neovim/vscode-neovim",
	},

	-- {
	-- 	"justinmk/vim-sneak",
	-- 	event = { "VimEnter" },
	-- },

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

	-- "nathom/filetype.nvim",
	"kyazdani42/nvim-web-devicons",
	"BurntSushi/ripgrep",
	-- "ahmedkhalf/project.nvim",
	{
		"goolord/alpha-nvim",
		-- dependencies = { 'echasnovski/mini.icons' },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local startify = require("alpha.themes.startify")
			-- available: devicons, mini, default is mini
			-- if provider not loaded and enabled is true, it will try to use another provider
			startify.file_icons.provider = "devicons"
			require("alpha").setup(startify.config)
		end,
	},
	-- "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
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

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{ -- optional completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
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
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
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
			-- "rcarriga/nvim-notify",
		},
		event = "VeryLazy",
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

	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},

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
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	config = function()
	-- 		require("leap").create_default_mappings()
	-- 	end,
	-- },

	-- tab out of parenthesis
	"abecodes/tabout.nvim",
	{
		"filipdutescu/renamer.nvim",
		branch = "master",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- "rcarriga/nvim-notify",
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
}
