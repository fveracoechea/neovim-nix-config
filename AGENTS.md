# AGENTS.md - Neovim Nix Config

## Build/Lint/Test Commands
- **Format code**: `stylua .` (formats all Lua files)
- **Check flake**: `nix flake check` (validates Nix configuration)
- **Build config**: `nix build` (builds the Neovim configuration)
- **Update dependencies**: `nix flake update` (updates flake inputs)
- **Test locally**: `home-manager switch --flake .` (applies config to current user)
- **Single file format**: `stylua path/to/file.lua`

## Code Style Guidelines

### Lua Configuration
- **Indentation**: 2 spaces (enforced by .stylua.toml)
- **Line length**: 120 characters max
- **Quotes**: Double quotes preferred (`"string"`)
- **Function calls**: No parentheses when possible (`require "module"`)
- **Module imports**: Place at top of file (`require "options"`, `require "keymaps"`)
- **Variables**: Descriptive names, locals at function start (`local map = vim.keymap.set`)
- **Vim globals**: Use `vim.g` for global settings (`vim.g.mapleader = " "`)

### Nix Configuration  
- **Indentation**: 2 spaces consistently
- **Structure**: Separate inputs/outputs on new lines
- **External configs**: Use `lib.fileContents` for Lua files
- **Plugin organization**: Plain plugins list + withConfig list
- **Comments**: Document plugin sources and purposes

### Keymaps
- **Descriptions**: Always include desc field (`{ desc = "Split window vertically" }`)
- **Grouping**: Use comment separators for related mappings
- **Leader keys**: Consistent patterns with space as leader
- **Local variables**: Define `local map = vim.keymap.set` at top

This is a Neovim configuration managed via Nix flakes and Home Manager.