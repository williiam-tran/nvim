require("user.lazy")
require("user.options")

if not vim.g.vscode then
	require("user.noice")
	require("user.cmp")
	require("user.colorscheme")
	require("user.mason")
	require("user.autopairs")
	require("user.autocmds")
	require("user.filetype")
	require("user.formatter")
	require("user.illuminate")
	require("user.indentline")
	require("user.treesitter")
	require("user.nvimtree")
	require("user.telescope")
	require("user.comments")
	require("user.renamer")
	require("user.tabout")
end

require("user.keymaps")
require("user.smoothscrolling")
