return {
	-- My plugins here
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
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
		"folke/trouble.nvim",
		lazy = true,
		dependencies = { "ryanoasis/vim-devicons" },
		opts = {
			position = "bottom", -- position of the list can be: bottom, top, left, right
			height = 10, -- height of the trouble list when position is top or bottom
			width = 50, -- width of the list when position is left or right
			icons = true, -- use devicons for filenames
			mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
			severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
			fold_open = "", -- icon used for open folds
			fold_closed = "", -- icon used for closed folds
			group = true, -- group results by file
			padding = true, -- add an extra new line on top of the list
			cycle_results = true, -- cycle item list when reaching beginning or end of list
			action_keys = { -- key mappings for actions in the trouble list
				close = "q", -- close the list
				cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r", -- manually refresh
				jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
				open_split = { "<c-x>" }, -- open buffer in new split
				open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
				open_tab = { "<c-t>" }, -- open buffer in new tab
				jump_close = { "o" }, -- jump to the diagnostic and close the list
				toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
				switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
				toggle_preview = "P", -- toggle auto_preview
				hover = "H", -- opens a small popup with the full multiline message
				preview = "p", -- preview the diagnostic location
				open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
				close_folds = { "zM", "zm" }, -- close all folds
				open_folds = { "zR", "zr" }, -- open all folds
				toggle_fold = { "zA", "za" }, -- toggle fold of current file
				previous = "k", -- previous item
				next = "j", -- next item
				help = "?", -- help menu
			},

			multiline = true, -- render multi-line messages
			indent_lines = true, -- add an indent guide below the fold icons
			win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
			auto_fold = false, -- automatically fold a file trouble list at creation
			auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
			include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
			signs = {
				-- icons / text used for a diagnostic
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		},
	},

	{
		"wellle/targets.vim",
		priority = 1000,
		event = "BufReadPre",
	},

	{
		"justinmk/vim-sneak",
		event = { "BufReadPre" },
	},

	{
		"terrortylor/nvim-comment",
	},

	"folke/neodev.nvim",

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

	"moll/vim-bbye",
	"ahmedkhalf/project.nvim",
	"lewis6991/impatient.nvim",
	"goolord/alpha-nvim",
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"folke/which-key.nvim",

	-- Colorschemes
	-- {
	-- 	"lunarvim/darkplus.nvim",
	-- 	priority = 1000,
	-- 	event = "BufReadPre",
	-- },
	-- {
	-- 	"tomasiser/vim-code-dark",
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
		dir = "user.autocmds.lua",
	},

	-- color for css.
	"folke/lsp-colors.nvim",
	"chrisbra/colorizer",
	"norcalli/nvim-colorizer.lua",

	-- cmp plugns
	"hrsh7th/nvim-cmp", -- The completion plugin
	"hrsh7th/cmp-buffer", -- buffer completions
	"hrsh7th/cmp-path", -- path completions
	"hrsh7th/cmp-cmdline", -- cmdline completions
	"saadparwaiz1/cmp_luasnip", -- snippet completions
	"hrsh7th/cmp-nvim-lsp",

	-- snippets
	{
		"L3MON4D3/LuaSnip", --snippet engine
		lazy = true,
	},

	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	{
		"williamboman/mason.nvim",
		-- event = { "BufReadPre", "BufNewFile" },
	},

	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		-- event = { "BufReadPre", "BufNewFile" },
	},

	"lukas-reineke/lsp-format.nvim",

	--  "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
	"brymer-meneses/grammar-guard.nvim",
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
		-- dependencies = {
		-- 	"nvim-telescope/telescope-media-files.nvim",
		-- 	event = "VeryLazy",
		-- 	lazy = true,
		-- 	module = "telescope",
		-- 	config = function()
		-- 		require("telescope").load_extension("media_files")
		-- 	end,
		-- },
		-- event = "VeryLazy",
		-- lazy = true,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		-- event = "VeryLazy",
		-- lazy = true,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		-- lazy = true,
		-- event = "VeryLazy",
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		-- lazy = true,
		-- event = "VeryLazy",
	},

	-- Git
	-- "lewis6991/gitsigns.nvim",

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
		"github/copilot.vim",
		branch = "release",
	},

	{
		"tpope/vim-surround",
		event = "BufReadPre",
	},

	-- {
	-- 	"haya14busa/incsearch.vim",
	-- 	priority = 1000,
	-- 	event = { "BufReadPre" },
	-- },

	-- nerdtree
	"tpope/vim-eunuch",

	-- notification
	"rcarriga/nvim-notify",

	-- dashboard
	"mhinz/vim-startify",

	{
		"easymotion/vim-easymotion",
		priority = 1200,
		event = { "BufReadPre" },
	},

	-- Todo plugins
	"unblevable/quick-scope", -- highlight the first letter of the word you are searching for
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

	-- syntax highlighting
	{
		"sheerun/vim-polyglot",
		-- event = { "BufReadPre" },
		lazy = true,
		event = "VeryLazy",
	},

	-- Git plugin for neovim
	"tpope/vim-fugitive",

	-- Debugger for neovim
	-- "ycm-core/YouCompleteMe",
	--  "puremourning/vimspector"
}
