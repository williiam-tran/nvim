local M = {}

local reload = require("plenary.reload")
local scan = require("plenary.scandir")

function M.reload_config()
	-- List of modules to reload
	local user_dir = vim.fn.stdpath("config") .. "/lua/user"

	local modules = {
		-- "user.keymaps",
		-- "user.treesitter",
		-- "user.treesitter",
	}

	local files = scan.scan_dir(user_dir, { depth = 5, search_pattern = "%.lua$" })
	for _, file in ipairs(files) do
		local module_name = file:gsub(vim.fn.escape(user_dir, "\\") .. "\\", ""):gsub("%.lua$", ""):gsub("\\", ".")
		table.insert(modules, "user." .. module_name)
	end

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
		-- Skip reloading the current module to avoid infinite recursion
		if module ~= "user.reload" then
			pcall(function()
				reload.reload_module(module, false)
				require(module)
			end)
		end
	end

	print("Configuration reloaded!")
end

return M
