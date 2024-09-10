require("user.lazy")
require("user.options")

if not vim.g.vscode then
	require("user.noice")
	require("user.cmp")
	require("user.mason")
	require("user.autopairs")
	-- require("user.filetype")
	require("user.formatter")
	require("user.illuminate")
	require("user.treesitter")
	require("user.nvimtree")
	require("user.telescope")
	require("user.comments")
	require("user.renamer")
	require("user.tabout")
	require("user.go")
	require("user.harpoon")
	require("user.git")
end

if vim.g.neovide then
	require("user.neovide")
end

require("user.keymaps")
require("user.smoothscrolling")
require("user.autocmds")
