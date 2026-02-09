# LSP STACK

## OVERVIEW

Mason + nvim-lspconfig + null-ls. Init chain: `init.lua` → `config.lua` + `handlers.lua` + `lsp-format.lua` + `null-ls.lua`.

## INIT FLOW

```
lsp/init.lua
 ├─ lsp/config.lua      → Server setup loop (lua_ls, gopls)
 ├─ handlers.setup()     → Diagnostic signs + config
 ├─ lsp/lsp-format.lua   → (mostly commented out)
 └─ lsp/null-ls.lua      → Go formatters (gofumpt, goimports_reviser, golines)
```

**Note**: `mason.lua` (parent dir) also configures servers — lua_ls, cssls, nil_ls are set up THERE, not here.

## WHERE TO LOOK

| Task | File |
|------|------|
| Add server to auto-install | `../mason.lua` → ensure_installed |
| Configure server with custom settings | `../mason.lua` (inline) or `config.lua` (loop) |
| Change diagnostic display | `handlers.lua` → M.setup() |
| Modify on_attach behavior | `handlers.lua` → M.on_attach() |
| Add Go formatters/linters | `null-ls.lua` |
| Custom LSP server (non-Mason) | See `ahk.lua` as example |

## SHARED EXPORTS (handlers.lua)

```lua
M.on_attach    -- Attaches illuminate, called by all servers
M.capabilities -- cmp_nvim_lsp.default_capabilities(), shared by all servers
M.setup()      -- Configures diagnostic signs and display options
```

**All servers** should use these via:
```lua
lspconfig[server].setup({
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
})
```

## DIAGNOSTIC CONFIG

- Virtual text: **disabled**
- Underline: **disabled**
- Signs: Error (✖), Warn (⚠), Hint (💡), Info (ℹ)
- Update in insert: **enabled**
- Float border: rounded, minimal style

## DEAD FILES

- `hello/world.lua` — placeholder, unused
- `package-lock.json` — leftover from ahk.lua node dependency
- `settings/sumneko_lua.lua` — superseded by inline config in `../mason.lua`
