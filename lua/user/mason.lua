require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls" },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- capabilities = require("user.lsp.handlers").capabilities

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
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
					-- ignoreDir = { "Downloads", "AppData" },
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		})
	end,
	--
	-- 	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	-- 	return true
	-- end,
})
