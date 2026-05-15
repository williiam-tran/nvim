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

local capabilities = require("user.lsp.handlers").capabilities

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        },
    },
})

capabilities = require("user.lsp.handlers").capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("cssls", {
    capabilities = capabilities,
})

vim.lsp.config("nil_ls", {})

vim.lsp.config("tailwindcss", {
    capabilities = capabilities,
})

vim.lsp.enable({ "lua_ls", "cssls", "nil_ls", "tailwindcss" })

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
