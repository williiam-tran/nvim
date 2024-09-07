require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "gopls", "cssls" },
})

require("lazydev").setup({
	opts = {
		library = {
			{ path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities = require("user.lsp.handlers").capabilities

require("lspconfig").lua_ls.setup({
	capabilities = capabilities,
	-- on_init = function(client)
	-- 	client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
	-- 		Lua = {
	-- 			diagnostics = {
	-- 				globals = { "vim" },
	-- 			},
	-- 			runtime = {
	-- 				version = "LuaJIT",
	-- 			},
	-- 			-- Make the server aware of Neovim runtime files
	-- 			workspace = {
	-- 				ignoreDir = { "Downloads", "AppData" },
	-- 				checkThirdParty = false,
	-- 				library = {
	-- 					vim.env.VIMRUNTIME,
	-- 				},
	-- 			},
	-- 		},
	-- 	})
	--
	-- 	client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
	-- 	return true
	-- end,
})

require("lspconfig").gopls.setup({
	on_attach = function(client)
		require("illuminate").on_attach(client)

		-- Set up custom diagnostics
		vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
			-- Customize the diagnostics display
			vim.diagnostic.set_virtual_text(result.uri, result.diagnostics)
			vim.diagnostic.set_signs(result.diagnostics)
		end
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

capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("go").setup({
	lsp_cfg = {
		capabilities = capabilities,
	},
})

local function custom_attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		use_lspsaga = false,
		floating_window = true,
		fix_pos = true,
		hint_enable = true,
		hi_parameter = "Search",
		handler_opts = { "double" },
	})
end

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

if not configs.ahk2 then
	configs.ahk2 = {
		default_config = {
			cmd = {
				"node",
				vim.fn.expand("$HOME/ahk-lsp/server/dist/server.js"),
				"--stdio",
			},
			init_options = {
				locale = "en-us",
				InterpreterPath = "C:/Program Files/AutoHotkey/v2.0.17/AutoHotkey64.exe",
			},
			single_file_support = true,
			flags = { debounce_text_changes = 500 },
			filetypes = { "ahk", "autohotkey", "ah2" },
			root_dir = lspconfig.util.root_pattern("*.ahk"),
			settings = {
				AutoHotkey2 = {
					interpreterPath = "C:/Program Files/AutoHotkey/v2.0.17/AutoHotkey64.exe",
				},
			},
			capabilities = capabilities,
			on_attach = custom_attach,
		},
	}
end

-- Set up the server

lspconfig.ahk2.setup({
	settings = {
		AutoHotkey2 = {
			InterpreterPath = "C:/Program Files/AutoHotkey/v2/AutoHotkey64.exe", -- Adjust this path
		},
	},
})
