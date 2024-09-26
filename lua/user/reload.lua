local M = {}

local reload = require("plenary.reload")

function M.reload_config()
	-- List of modules to reload
	local modules = {
		"user.keymaps",
		"user.treesitter",
	}

	-- Conditionally add modules
	if not vim.g.vscode then
		local non_vscode_modules = {
			"user.nvimtree",
			"user.telescope",
			"user.pounce",
		}
		vim.list_extend(modules, non_vscode_modules)
	end

	-- Reload each module
	for _, module in ipairs(modules) do
		reload.reload_module(module, false)
		require(module)
	end

	print("Configuration reloaded!")
end

return M
