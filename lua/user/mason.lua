require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "cssls", "eslint", "tailwindcss" },
})

require("lazydev").setup({
    opts = {
        library = {
            { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
    },
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

local capabilities = require("user.lsp.handlers").capabilities

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

capabilities = require("user.lsp.handlers").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").cssls.setup({
    capabilities = capabilities,
})

require("lspconfig").nil_ls.setup({})

require("lspconfig").tailwindcss.setup({
    capabilities = capabilities,
})

require("typescript-tools").setup({
    capabilities = capabilities,
    on_attach = require("user.lsp.handlers").on_attach,
    settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = "all",
        complete_function_calls = true,
        include_completions_with_insert_text = true,
        tsserver_file_preferences = {
            includeCompletionsForModuleExports = true,
            includeCompletionsWithInsertText = true,
        },
        jsx_close_tag = {
            enable = true,
            filetypes = { "javascriptreact", "typescriptreact" },
        },
    },
})
