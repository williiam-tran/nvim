require("user.lazy")
require("user.options")
require("user.keymaps")

if not vim.g.vscode then
	-- require("user.avante")
	require("user.autocmds")
	require("user.noice")
	require("user.cmp")
	require("user.mason")
	require("user.formatter")
	require("user.nvimtree")
	require("user.autopairs")
	require("user.telescope")
	require("user.comments")
	require("user.renamer")
	require("user.go")
	require("user.harpoon")
	require("user.git")
	require("user.toggleterm")
	require("user.persisted")
	require("user.smoothscrolling")
	require("user.illuminate")
	require("user.pounce")
	require("user.typescript")
	require("user.reload")
	require("user.colorscheme")
	require("user.colorizer")
else
	require("user.vscode.options")
	require("user.vscode.smoothscrolling")
end

require("user.treesitter")
require("user.autopairs")
require("user.tabout")

if vim.g.neovide then
	require("user.neovide")
end
