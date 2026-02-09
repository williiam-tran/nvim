# NEOVIM CONFIG KNOWLEDGE BASE

**Generated:** 2026-02-09
**Commit:** d6f583b
**Branch:** glove80

## OVERVIEW

Personal Neovim configuration. Lua + lazy.nvim. Dual-environment: full Neovim with LSP/completion/treesitter, and minimal VSCode-Neovim mode. 75 files, ~4700 lines of Lua.

## STRUCTURE

```
./
├── init.lua                # Entry point — conditional module loading
├── lua/
│   ├── plugins/            # Lazy.nvim plugin SPECS (declarations only)
│   │   ├── plugins.lua     # Full Neovim plugins (~100 specs)
│   │   ├── vscode.lua      # VSCode-Neovim minimal set
│   │   ├── colorscheme.lua
│   │   └── problems.lua    # Trouble.nvim
│   └── user/               # Plugin CONFIGS (one file per plugin/feature)
│       ├── lazy.lua         # Lazy.nvim bootstrap
│       ├── keymaps.lua      # ⚠️ HEAVILY REMAPPED — read before touching
│       ├── options.lua      # Vim options
│       ├── lsp/             # LSP stack (Mason + lspconfig + null-ls)
│       └── vscode/          # VSCode-specific overrides
├── scripts/                 # BTT/keyboard helper scripts (not Neovim)
├── init_scrollback.lua      # Alt entry point for kitty scrollback
└── CLAUDE.md                # Legacy project docs
```

## WHERE TO LOOK

| Task | Location | Notes |
|------|----------|-------|
| Add a plugin | `lua/plugins/plugins.lua` | Lazy.nvim spec format |
| Configure a plugin | `lua/user/{plugin}.lua` | Then `require()` in init.lua |
| Modify keybindings | `lua/user/keymaps.lua` | READ ANTI-PATTERNS FIRST |
| Add LSP server | `lua/user/mason.lua` | Add to ensure_installed + setup |
| Change formatters | `lua/user/formatter.lua` | Conform.nvim, format-on-save |
| VSCode-only changes | `lua/user/vscode/` + `lua/plugins/vscode.lua` | Loads when `vim.g.vscode` |
| Treesitter languages | `lua/user/treesitter.lua` | ensure_installed list |
| Completion sources | `lua/user/cmp.lua` | nvim-cmp, sources priority |

## INIT FLOW

```
init.lua
 ├─ require("user.lazy")        → bootstrap lazy.nvim, load plugin specs
 ├─ require("user.surround")    → always loaded
 ├─ require("user.keymaps")     → always loaded
 ├─ require("user.options")     → always loaded
 ├─ require("user.wordmotion")  → always loaded
 │
 ├─ if vim.g.vscode:
 │   └─ vscode.options, vscode.smoothscrolling, vscode.treesitter, cmp
 │
 └─ else (full Neovim):
     └─ git, autopairs, autocmds, cmp, mason, formatter, comments,
        noice, illuminate, pounce, persisted, nvimtree, colorscheme,
        scrollback, smoothscrolling, telescope, treesitter, tabout
```

Lazy.nvim defaults: `lazy = true` for Neovim, `lazy = false` for VSCode.

## CONVENTIONS

- **Indentation**: Tabs, 4-space width (`expandtab = true` converts to spaces)
- **Module pattern**: `local M = {} ... return M` for shared modules (see `lsp/handlers.lua`)
- **Config pattern**: Direct `require("plugin").setup({})` — no module wrapper
- **Naming**: `snake_case` locals, `PascalCase` globals (e.g., `SetCustomHighlights`, `ReplaceInQuickfix`)
- **Safety checks**: `local ok, mod = pcall(require, "plugin"); if not ok then return end`
- **Keymap style**: Mixed `vim.keymap.set()` and legacy `vim.api.nvim_set_keymap()` — prefer `vim.keymap.set()` for new code
- **Keymap opts**: `{ noremap = true, silent = true }`
- **Augroup helper**: `vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })`
- **Leader**: Space
- **No config files**: No stylua.toml, .luarc.json, .editorconfig — stylua uses defaults
- **Deferred init**: `vim.defer_fn()` for non-critical setup; custom `User VeryLast` event at 100ms

## ANTI-PATTERNS (THIS PROJECT)

### ⚠️ NON-STANDARD KEY MAPPINGS — CRITICAL

Navigation is **completely remapped**. Do NOT assume Vim defaults:

| Key | Action | Vim Default |
|-----|--------|-------------|
| `h` | Down (j) | Left |
| `t` | Up (k) | Till |
| `n` | Word forward (w) | Next search |
| `k` | Word backward (b) | Up |
| `e` | Delete (d) | End of word |
| `w` | New line below (o) | Word forward |
| `l` | Undo (u) | Right |
| `o` | Word end (spider) | Open line below |
| `s` | Pounce jump | Substitute |
| `.` | Visual mode (v) | Repeat |
| `"` | Repeat (.) | Register |
| `,` | Command mode (:) | Reverse t/f |
| `;` | Telescope commands | Repeat t/f |
| `q` | Save+quit (:wq) | Record macro |
| `Q` | Quit all | Ex mode |

**Escape bindings**: `z` and `b` in visual/operator modes. `kh`, `jg`, `mg` in insert mode (save+exit).

### FORBIDDEN

- Do NOT add keymaps using standard Vim mnemonics without checking `keymaps.lua` for conflicts
- Do NOT use `vim.api.nvim_set_keymap` for new code — use `vim.keymap.set()` instead
- Do NOT assume `n`, `h`, `t`, `k`, `e`, `w`, `o`, `l` do what they normally do in Vim

### KNOWN ISSUES

- `vim.loop` used in several places — deprecated in favor of `vim.uv` (Neovim 0.10+)
- `fileformat = "dos"` in options — may cause issues on Unix systems
- Duplicate Telescope setup in `plugins.lua` (lines 122-129 and 235-249)
- `lsp/hello/world.lua` and `lsp/package-lock.json` are dead files
- Commented-out harpoon, typescript, reload modules in init.lua

## FORMATTERS

| Filetype | Formatter | Via |
|----------|-----------|-----|
| Lua | stylua | Conform |
| Go | goimports + gofumpt + golines | Conform + null-ls |
| Nix | alejandra | Conform |
| TS/JS/JSON | prettier | Conform |
| CSS | LSP (cssls) | lspconfig |

Format-on-save: 5s timeout, LSP fallback. Manual: `<M-f>`.

## LSP SERVERS

| Server | Managed By | Config Location |
|--------|-----------|-----------------|
| lua_ls | Mason | `mason.lua` (custom on_init) |
| gopls | Mason | `lsp/config.lua` |
| cssls | Mason | `mason.lua` |
| eslint | Mason | Mason auto |
| nil_ls | Manual | `mason.lua` |

## COMMANDS

```bash
# Plugin management (inside Neovim)
:Lazy              # Plugin dashboard
:Lazy update       # Update all
:Lazy install      # Install missing

# Mason (inside Neovim)
:Mason             # LSP server dashboard
:MasonInstall X    # Install server X

# Reload after config change
:source %          # Reload current file (auto-flush via autocmd)
```

## NOTES

- `init_scrollback.lua` is an alternative entry point for kitty terminal scrollback — not part of normal Neovim startup
- `scripts/` contains BetterTouchTool and keyboard switching helpers — unrelated to Neovim config
- `nmap.txt` appears to be a keymap reference/scratchpad
- The config originated on Windows (options.lua shell/fileformat settings) and was adapted for macOS
- Noice.nvim is pinned to commit `d9328ef` — intentional version lock
