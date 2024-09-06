require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "cssls", "tsserver" },
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

require("lspconfig").lua_ls.setup({})

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
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
					},
				},
			},
		})

		client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		return true
	end,
})

capabilities = require("user.lsp.handlers").capabilities

require("lspconfig").gopls.setup({
	on_attach = function(client)
		require("illuminate").on_attach(client)
	end,

	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

--Enable (broadcasting) snippet capability for completion
capabilities = require("user.lsp.handlers").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- require("lspconfig").gopls.setup({
-- 	capabilities = capabilities,
-- })

require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

-- require("lspconfig").tsserver.setup({
-- 	capabilities = capabilities,
-- })
