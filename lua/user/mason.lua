require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
	-- handlers = {
	-- 	lsp_zero.default_setup,
	-- },
})

require("neodev").setup({
	library = {
		enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
		-- these settings will be used for your Neovim config directory
		runtime = true, -- runtime path
		types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
		plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require("lspconfig").lua_ls.setup({})

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
		-- local path = client.workspace_folders[1].name
		-- if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
		client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},

				runtime = {
					version = "LuaJIT",
				},
				-- Make the server aware of Neovim runtime files
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		})

		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		-- end
		return true
	end,
})
