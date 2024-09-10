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

require("typescript-tools").setup({
	settings = {
		-- spawn additional tsserver instance to calculate diagnostics on it
		separate_diagnostic_server = true,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "insert_leave",
		-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
		-- "remove_unused_imports"|"organize_imports") -- or string "all"
		-- to include all supported code actions
		-- specify commands exposed as code_actions
		expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused_imports", "remove_unused" },
		-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
		-- not exists then standard path resolution strategy is applied
		tsserver_path = nil,
		-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
		-- (see 💅 `styled-components` support section)
		tsserver_plugins = {},
		-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
		-- memory limit in megabytes or "auto"(basically no limit)
		tsserver_max_memory = "auto",
		-- described below
		tsserver_format_options = {},
		tsserver_file_preferences = {},
		-- locale of all tsserver messages, supported locales you can find here:
		-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
		tsserver_locale = "en",
		-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
		complete_function_calls = true,
		include_completions_with_insert_text = true,
		-- CodeLens
		-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
		-- possible values: ("off"|"all"|"implementations_only"|"references_only")
		code_lens = "references_only",
		-- by default code lenses are displayed on all referencable values and for some of you it can
		-- be too much this option reduce count of them by removing member references from lenses
		disable_member_code_lens = true,
		-- JSXCloseTag
		-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
		-- that maybe have a conflict if enable this feature. )
		jsx_close_tag = {
			enable = false,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})

require("nvim-ts-autotag").setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
	-- Also override individual filetype configs, these take priority.
	-- Empty by default, useful if one of the "opts" global settings
	-- doesn't work well in a specific filetype
	per_filetype = {
		["html"] = {
			enable_close = false,
		},
	},
})
