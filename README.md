# 🚀 Neovim configuration (nix flake)
Modern, reproducible Neovim IDE powered by Nix flakes + Home Manager: LSP, Treesitter, formatting, linting, UI polish.

## ✨ Features

### 🎨 UI
- Catppuccin Mocha (transparent)
- Lualine (with LSP progress + diagnostics)
- Noice command-line / messages
- Which-key dynamic keymap hints
- Alpha dashboard (recent projects, shortcuts)

### 🧠 Editing
- 10+ LSP servers (web, nix, lua, python, bash, etc.)
- Treesitter for 20+ grammars
- nvim-cmp completion w/ snippets
- Surround, autopairs, commenting utilities
- Optional: GitHub Copilot (enable token manually)

### 🔍 Navigation
- Telescope fuzzy finding (files, grep, buffers, symbols)
- Yazi TUI file manager integration
- Session management
- Gitsigns inline hunks & blame

### 🛠 Tooling
- Conform format-on-save (Prettier, Stylua, Black, etc.)
- nvim-lint async diagnostics
- Refactoring helpers
- CodeSnap screenshots
- Todo-comments navigation

### 📦 Languages
Web (TS/JS/HTML/CSS/React/Vue/Svelte) · Nix · Lua · Python · Bash · C · JSON · YAML · Markdown · GraphQL · Dockerfile · Nginx

## 🏗️ Layout

```
neovim-nix-config/
├── flake.nix
├── flake.lock
├── configuration/
│   ├── default.nix          # Aggregate module(s)
│   ├── neovim.nix           # Neovim package + plugin wiring
│   ├── snippets.nix         # Mini snippet definitions
│   └── tree-sitter.nix      # Grammar pinning
├── nvim/
│   ├── init.lua
│   ├── lua/
│   │   ├── config/
│   │   │   ├── options.lua
│   │   │   ├── keymaps.lua
│   │   │   ├── lsp.lua
│   │   │   └── autocmds.lua
│   │   ├── plugins/         # Individual plugin configs
│   │   │   ├── cmp.lua
│   │   │   ├── lualine.lua
│   │   │   ├── treesitter.lua
│   │   │   ├── conform.lua
│   │   │   ├── lint.lua
│   │   │   ├── tailwind-tools.lua
│   │   │   └── ...
│   │   └── utils/
│   │       ├── cmp-mini-snippets.lua
│   │       └── lsp-capabilities.lua
│   └── lsp/                 # Per-server overrides
│       ├── ts_ls.lua
│       ├── tailwindcss.lua
│       ├── cssls.lua
│       ├── jsonls.lua
│       ├── lua_ls.lua
│       └── ...
├── AGENTS.md
├── LICENSE
└── README.md
```

## 🚀 Install

### Requirements
- Nix (flakes enabled)
- Home Manager
- (Optional) Nerd Font for icons (e.g. JetBrainsMono Nerd Font)


```nix
# flake.nix
{
  inputs.neovim-config.url = "github:fveracoechea/neovim-nix-config";
  outputs = { ... } @ inputs: {
    # ...
  };
}
```

Then in your Home Manager config:
```nix
imports = [ inputs.neovim-config.homeManagerModules.default ];
```

## ⚡ Keybindings (Essentials)

| Mapping | Action |
|---------|--------|
| <Space> | Leader |
| <C-n>   | Yazi file manager (cwd) |
| <leader>e | Yazi at current file |
| <leader>ff | Find files |
| <leader>fs | Live grep |
| <leader>b  | Buffer list |
| <leader>lg | Lazygit |
| <C-s>      | Save |

LSP: K hover · gd def · gr refs · <leader>rn rename · <leader>ca actions

## 📚 Resources

- Neovim: https://neovim.io/doc/
- Nix Manual: https://nixos.org/manual/nix/stable/
- Home Manager Options: https://nix-community.github.io/home-manager/options.html
- Catppuccin: https://github.com/catppuccin/nvim
