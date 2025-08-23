# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using Lazy.nvim as the plugin manager. The configuration supports dual environments:
- Full Neovim setup with extensive plugins and LSP integration
- VSCode-Neovim integration with a minimal plugin set

## Architecture

### Plugin Management
- Uses [Lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management
- Main plugin definitions in `lua/plugins/plugins.lua`
- VSCode-specific plugins in `lua/plugins/vscode.lua`
- Conditional loading based on `vim.g.vscode` detection

### Configuration Structure
```
lua/
├── plugins/          # Plugin specifications
├── user/            # User configuration modules
│   ├── lsp/         # LSP configuration
│   └── vscode/      # VSCode-specific configs
```

### Key Components
- **init.lua**: Entry point with conditional module loading
- **user/lazy.lua**: Lazy.nvim setup and configuration
- **user/keymaps.lua**: Custom key mappings (see Critical Notes below)
- **user/formatter.lua**: Conform.nvim formatter configuration
- **user/lsp/**: Complete LSP setup with Mason integration

## Plugin Management Commands

```bash
# Update all plugins
:Lazy update

# Install missing plugins
:Lazy install

# Check plugin status
:Lazy

# Clean unused plugins
:Lazy clean
```

## Formatters

Configured formatters by file type (lua/user/formatter.lua):
- Lua: stylua
- Go: goimports
- Nix: alejandra
- TypeScript/JavaScript: prettier
- JSON: prettier

Format-on-save is enabled with 5-second timeout.

Manual formatting: `<M-f>` (Alt+f)

## LSP Configuration

LSP servers are managed through Mason:
- Mason installs and manages language servers
- Configuration in `lua/user/lsp/`
- Null-ls integration for additional tooling

## Critical Notes

### Non-Standard Key Mappings
This configuration uses **heavily customized key mappings** that deviate from Vim defaults:

**Navigation remapping:**
- `h` → `j` (down)
- `t` → `k` (up)
- `n` → `w` (word forward)
- `k` → `b` (word backward)

**Action remapping:**
- `c` → `i` (insert mode)
- `i` → `c` (change)
- `e` → `d` (delete)
- `l` → `u` (undo)

**Important escape bindings:**
- `z` and `b` → `<Esc>` in visual/operator modes
- `kh`, `jg`, `mg` → Save and exit insert mode

### Plugin-Specific Features
- **Pounce**: Motion plugin mapped to `s` for jumping
- **Harpoon**: Quick file navigation (branch: harpoon2)
- **Telescope**: Fuzzy finder with live grep and file browser extensions
- **Neogit**: Git interface integration

### VSCode Integration
When running in VSCode-Neovim:
- Loads minimal plugin set from `lua/plugins/vscode.lua`
- Includes basic completion, treesitter, and motion plugins
- Custom smooth scrolling and options

## Development Workflow

1. Configuration changes are auto-detected by Lazy.nvim
2. Use `:source %` to reload current file
3. LSP and formatters work automatically on file save
4. Git integration through Neogit and Gitsigns

## Important Files to Understand

- `lua/user/keymaps.lua` - Essential for understanding navigation
- `lua/user/formatter.lua` - Formatting behavior and keybinds  
- `lua/user/lsp/config.lua` - LSP server configurations
- `lua/plugins/plugins.lua` - Complete plugin list and setup