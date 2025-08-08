# AGENTS.md - Neovim Nix Config

## Build/Lint/Test Commands
- Format Lua: `stylua .`
- Check flake: `nix flake check`
- Build config: `nix build`
- Update flake inputs: `nix flake update`
- Test config locally: `home-manager switch --flake .`

## Code Style Guidelines

### Lua
- Use 2-space indentation (configured in .stylua.toml)
- Column width: 120 characters
- Quote style: prefer double quotes with auto-selection
- No call parentheses when not needed
- Local variables at top of function/block: `local map = vim.keymap.set`
- Use descriptive variable names: `js_formatters`, `conform`
- Require modules at top: `require "lsp-servers"`
- Use vim.g for global variables: `vim.g.mapleader = " "`

### Nix
- Use 2-space indentation  
- Place inputs/outputs on separate lines
- Use `lib.fileContents` for external Lua configs
- Structure: plain plugins list + withConfig list
- Comment plugin sources clearly

### Keymaps
- Use descriptive desc field: `{ desc = "Split window vertically" }`
- Group related mappings with comment separators
- Use consistent leader key patterns

### Error Handling
- Use vim.diagnostic.config for LSP diagnostics
- Configure error signs with proper symbols: `[x.ERROR] = "󰅙 "`
- Set up floating window borders for diagnostics

This is a Neovim configuration managed via Nix flakes and Home Manager.