# USER CONFIG MODULES

## OVERVIEW

One file per plugin/feature. Each file configures a single plugin via `require("plugin").setup({})`. Loaded from `init.lua` via `require("user.{name}")`.

## ADDING A NEW MODULE

1. Create `lua/user/{name}.lua`
2. Add `require("user.{name}")` to `init.lua` (inside the correct `if vim.g.vscode` branch)
3. If VSCode-only or VSCode-compatible, add to the `vscode` branch

## MODULE CATEGORIES

| Category | Files | Notes |
|----------|-------|-------|
| **Core** | keymaps, options, lazy, autocmds | Always loaded |
| **Navigation** | pounce, wordmotion, smoothscrolling, harpoon | Motion/jump plugins |
| **Editing** | surround, autopairs, comments, tabout | Text manipulation |
| **Completion** | cmp, copilot | nvim-cmp + AI |
| **LSP** | mason, lsp/ (subdir) | See `lsp/AGENTS.md` |
| **Formatting** | formatter | Conform.nvim |
| **UI** | colorscheme, noice, indentline, illuminate, lualine | Visual/display |
| **Files** | nvimtree, telescope, fzf, project | File navigation/search |
| **Git** | git | Neogit + gitsigns |
| **Session** | persisted | Session save/restore |
| **Terminal** | toggleterm, scrollback | Terminal integration |
| **Language** | treesitter, typescript, go | Language-specific |
| **VSCode** | vscode/options, vscode/smoothscrolling, vscode/treesitter | VSCode-Neovim only |
| **Unused** | codecompanion, avante, copilot, debugger, legendary, remote, renamer, youcompleteme | Not loaded in init.lua |

## CONFIG PATTERNS

**Standard** (most files):
```lua
local ok, plugin = pcall(require, "plugin")
if not ok then return end
plugin.setup({ ... })
```

**Simple** (small configs like comments.lua):
```lua
require("mini.comment").setup({})
```

**Complex** (telescope.lua, keymaps.lua, git.lua):
- Multiple require calls
- Custom functions defined before setup
- Extension loading after setup
- Deferred initialization via `vim.defer_fn()`

## LARGE FILES (>200 lines)

| File | Lines | Why Large |
|------|-------|-----------|
| keymaps.lua | 615 | Full keyboard remapping + text objects + quickfix helpers |
| telescope.lua | 343 | Extensions + custom pickers + URL opener |
| noice.lua | 221 | UI overrides + route configuration |
| cmp.lua | 175 | Sources + mappings + cmdline setup |

## CONVENTIONS (DIFFERS FROM ROOT)

- Global functions use `PascalCase` and are defined in keymaps.lua: `Flush()`, `SetCustomHighlights()`, `ReplaceInQuickfix()`
- Custom `User VeryLast` event fires 100ms after startup (autocmds.lua) — use for deferred highlights
- `Flush()` in autocmds.lua auto-clears `package.loaded` on save for any file under config path — hot reload works automatically
