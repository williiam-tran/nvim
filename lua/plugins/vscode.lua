return {
	"chrisgrieser/nvim-various-textobjs",
	"abecodes/tabout.nvim",
	{
		"rlane/pounce.nvim",
		lazy = false,
	},
	"karb94/neoscroll.nvim",
	"tpope/vim-repeat",

	{
		"wellle/targets.vim",
		priority = 1000,
		event = { "VimEnter" },
	},

	"tpope/vim-surround",
	"nvim-treesitter",
	"nvim-treesitter-textobjects",
	"nvim-ts-context-commentstring",
	"chaoren/vim-wordmotion",
}
