require("conform").setup({
    event = { "LspAttach", "BufReadPost", "BufNewFile" },
    keys = {
        { "<MS-f>", function() require("conform").format({ async = true }) end, },
    },
    formatters_by_ft = {
        lua = { "stylua" },
        go = { "goimports" },
        nix = { "alejandra" },
        -- Conform will run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- Use a sub-list to run only the first available formatter
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
    },
    default_format_opts = {
        lsp_format = "fallback",
    },
    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 5000,
        lsp_fallback = true,
    },
})
