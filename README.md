# Neovim + Nix Flake
Reproducible, minimal-but-powerful IDE setup fully provisioned by Nix + Home Manager: LSP, Treesitter, completion, formatting, linting, cohesive UI.

## ✨ Features (Single Glance)
- UX/UI: Catppuccin Mocha (transparent), animated statusline + winbar via Lualine, rich notifications & status column, dashboard, indent & scope guides, zen/zoom, smooth scroll, minimal glyph icon set.
- Editing Primitives: Treesitter highlighting & incremental selection, smart indentation, surround/pairs/comment, inline diff hunks & navigation, session management, scratch buffers, chunk highlighting.
- LSP & Language Tooling: Auto enable configured servers (TypeScript / Deno, HTML, CSS, JSON, ESLint, TailwindCSS, GraphQL, Relay, Nix, Lua (sumneko), Nginx, Bash). Custom diagnostics symbols + borders.
- Completion & Snippets: nvim-cmp with LSP, buffer, path, Copilot (optional), custom mini.snippets + Tailwind class formatting & icon kind formatting chain.
- Formatting: conform.nvim with per‑ft fallback chain (Prettier | Deno, Stylua, Black + Isort, Alejandra, etc.) format-on-save.
- Linting: nvim-lint (pylint) auto triggers on enter/write/leave insert, manual <leader>ll.
- Navigation & Search: Snacks picker (files, grep, recent, buffers, diagnostics, explorer sidebar) replaces Telescope; Yazi TUI file manager (floating or cwd) + explorer view; word reference jumping; buffer & git pickers.
- Git: Inline diff hunks (mini.diff + gitsigns backend), blame line, browse repo, lazygit integration, file & repo history pickers.
- Tailwind Enhancements: Conceal long class lists, class sorting & navigation, cmp coloring (tailwind-tools).
- Visual Utilities: Code screenshots (codesnap), status notifications history, toggle helpers (numbers, wrap, spell), zen & zoom, bigfile optimizations.
- Pure Nix Provisioning: All plugins, LSP servers, formatters, linters pinned via flake; tree-sitter grammars vendored through nix derivation; zero ad-hoc network downloads at runtime.

## 📦 Plugin Stack
Core/runtime: plenary, nui
UI/Experience: catppuccin, lualine, snacks (dashboard, picker, notifier, indent, scope, zen, etc.), mini (icons, clue, sessions, pairs, surround, comment, diff, snippets)
Editing/Language: nvim-treesitter (+ autotag, context-commentstring), nvim-lspconfig, tailwind-tools, nvim-lsp-file-operations
Completion: nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, cmp-minikind, copilot.lua, copilot-cmp
Files & Navigation: yazi-nvim
Git: gitsigns, snacks git/lazygit helpers
Code Quality: conform, nvim-lint
Utility/Misc: codesnap

## 🗂 Layout
```
neovim-nix-config/
├── flake.nix / flake.lock          # Inputs + outputs
├── configuration/
│   ├── neovim.nix                  # Program + plugins + LSP tools
│   ├── tree-sitter.nix             # Grammar pin set
│   ├── snippets.nix                # Inline snippet definitions
│   └── default.nix                 # Aggregate HM module
├── nvim/
│   ├── init.lua                    # Entry (requires ordered configs)
│   ├── lua/config/                 # options, keymaps, lsp, autocmds
│   ├── lua/plugins/                # per-plugin setup (mini, snacks...)
│   ├── lua/utils/                  # helper utilities
│   └── lsp/                        # server-specific overrides
├── AGENTS.md                       # Dev workflow guide
└── README.md
```

## 🚀 Install
Requirements: Nix (flakes), Home Manager, Nerd Font (icons).

Add input in your flake:
```nix
{
  inputs.neovim-config.url = "github:fveracoechea/neovim-nix-config";
  outputs = { ... }@inputs: { /* ... */ };
}
```
Then import the Home Manager module:
```nix
{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.neovim-config.homeManagerModules.default ];
}
```
Rebuild:
```sh
home-manager switch --flake .
```

## ⌨ Key Highlights
Leader <Space>
- <C-n> Yazi (cwd)
- <C-y> Yazi (file)
- <leader>ff Files  | <leader>fs Grep | <leader>fr Recent | <leader>fa All (hidden)
- <leader>b Buffers | <leader>x Close | <leader>xo Close others
- LSP: K hover | gd def | <leader>lr refs | <leader>li impl | <leader>lt type | <leader>rn rename | <leader>ca actions
- Diagnostics: <leader>sd buffer | <leader>sD all | <leader>Dp / <leader>Dn prev/next
- Git: <leader>gb blame | <leader>gB browse | <leader>gf file log | <leader>gl repo log
- Tailwind: <leader>twc conceal | <leader>tws sort | <leader>twn / <leader>twp next/prev class
- Sessions: <leader>ws write | <leader>wr read | <leader>wd delete
- Diff hunks: ]h / [h navigate
- CodeSnap: Visual select then <leader>cc (clipboard) / <leader>cs (save)
- Toggles: <leader>ul numbers | <leader>uL relative | <leader>uw wrap | <leader>us spell
- Zen: <leader>z toggle | <leader>Z zoom
- Snippets/Completion: <Tab>/<S-Tab> navigate or expand; <C-j>/<C-k> cycle

## ⚙ Customization Notes
- Enable/disable any snacks feature inside `plugins/snacks.lua`.
- Add/override LSP servers: `lua/config/lsp.lua` + `configuration/neovim.nix` (extraPackages).
- Adjust formatters in `plugins/conform.lua`.
- Snippets live in external JSON loaded through mini.snippets (see mini.lua) or Nix snippet module.

## 🧪 Dev / Maintenance
Run formatting & flake checks before committing:
```sh
stylua .
nix flake check
nvim --headless '+quit'
```
Update inputs:
```sh
nix flake update
```

## 📚 References
- Neovim https://neovim.io
- Nix Manual https://nixos.org/manual/nix/stable
- Home Manager https://nix-community.github.io/home-manager
- Catppuccin https://github.com/catppuccin/nvim

