# Neovim + Nix

Reproducible Neovim setup managed entirely by a Nix flake + Home Manager.

## Features
- Catppuccin theme, statusline + winbar (lualine)
- Snacks: dashboard, picker (files/grep/buffers/diagnostics), git helpers, zen, notifier, indent & scope guides
- Mini: sessions, surround, pairs, comment, diff, snippets, icons, key hints
- LSP: TS/Deno, HTML, CSS, JSON, ESLint, Tailwind, GraphQL, Relay, Nix, Lua, Nginx, Bash
- Completion: nvim-cmp (LSP, buffer, path, Copilot opt-in, snippets, tailwind formatting)
- Treesitter highlighting & incremental selection
- Formatting: conform (Prettier/Deno, Stylua, Black+Isort, Alejandra, etc.) on save
- Linting: nvim-lint (pylint)
- File / Nav: Snacks picker + Yazi floating file manager
- Git: diff hunks, blame, browse, lazygit integration
- Extras: Tailwind conceal/sort, code snapshots, quick toggles

## Install
```nix
# flake.nix
{
  inputs.neovim-config.url = "github:fveracoechea/neovim-nix-config";
}
```
```nix
# home-manager
{ inputs, ... }: {
  imports = [ inputs.neovim-config.homeManagerModules.default ];
}
```

## Key Hints
Leader <Space>
Files <leader>ff  Grep <leader>fs  Buffers <leader>b
LSP K hover  gd def  <leader>lr refs  <leader>rn rename  <leader>ca actions
Diag <leader>sd buf  <leader>sD all  Prev/Next <leader>Dp / <leader>Dn
Git <leader>gb blame  <leader>gl log
Yazi <C-n> cwd  <C-y> file
Tailwind <leader>twc conceal  <leader>tws sort
Sessions <leader>ws write  <leader>wr read
Zen <leader>z

## Customize
Edit plugin configs in `nvim/lua/plugins/`.
Add LSP / formatters in `configuration/neovim.nix`.

## Dev
```
stylua .
nix flake check
nvim --headless '+quit'
```
