# 🚀 Neovim Nix Configuration

Modern, reproducible Neovim IDE powered by Nix flakes + Home Manager: LSP, Treesitter, formatting, linting, UI polish.

## TL;DR

```bash
# Clone
git clone https://github.com/<your-username>/neovim-nix-config.git
cd neovim-nix-config

# Try ephemeral (doesn't touch your home config)
nix run .#nvim .

# Or integrate with Home Manager (flake)
home-manager switch --flake .   # if this repo is your primary flake
```

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

### Prereqs
- Nix (flakes enabled)
- Home Manager
- (Optional) Nerd Font for icons (e.g. JetBrainsMono Nerd Font)

### As Flake Input

```nix
# flake.nix
{
  inputs.neovim-config.url = "github:<your-username>/neovim-nix-config";
  outputs = { self, nixpkgs, neovim-config, ... }: {
    homeManagerModules.my-neovim = neovim-config.homeManagerModules.default;
  };
}
```

Then in your Home Manager config:

```nix
imports = [ self.homeManagerModules.my-neovim ];
```

Apply:

```bash
home-manager switch --flake .
```

### Standalone (inside this repo)

If this repository is your flake:

```bash
home-manager switch --flake .
```

### Ephemeral Run (no install)

```bash
nix run github:<your-username>/neovim-nix-config#nvim .
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

## 🧩 Workflow

1. Open project: `nvim` (from project root)
2. Jump files: `<leader>ff`
3. Search text: `<leader>fs`
4. Navigate code: `gd`, `gr`
5. Stage/commit: `<leader>lg` (Lazygit) or builtin gitsigns
6. Format-on-save via Conform (manual: `:Format`)

## 🔧 Customize

### Add Plugin (Nix layer)

In `configuration/neovim.nix` (lists are split between plain / withConfig):

```nix
withConfig = with pkgs.vimPlugins; [
  {
    plugin = your-configured-plugin;
    config = lib.fileContents ./nvim/lua/plugins/your-plugin.lua;
  }
];
```

Create config file:

```bash
touch nvim/lua/plugins/your-plugin.lua
```

### Keymaps

Edit `nvim/lua/config/keymaps.lua`:

```lua
local map = vim.keymap.set
map("n", "<leader>x", "<CMD>SomeCommand<CR>", { desc = "Do thing" })
```

### New LSP Server

Drop a file in `nvim/lsp/your_server.lua`. Example scaffold:

```lua
return {
  settings = {
    -- server specific
  },
}
```

Or extend logic in `nvim/lua/config/lsp.lua` for generic patterns.

### Copilot

Token not bundled. Enable globally via environment or your own plugin entry (see license/ToS). If omitted, rest works.

## 🛠 Development

```bash
stylua .
nix flake check
nix build
nvim --headless '+quit'   # smoke test
nix flake update          # refresh inputs (optional)
```

Commit policy: small atomic commits (see AGENTS.md).

## 🧪 Quality Gates

- Format: `stylua .`
- Flake sanity: `nix flake check`
- Startup: `nvim --headless '+quit'`
- Repro: `nix build` (derivation builds pinned plugin set)

## 🩹 Troubleshooting

| Symptom | Fix |
|---------|-----|
| Icons missing | Install Nerd Font & set terminal font |
| LSP not starting | Run `:LspInfo`; ensure server package enabled in Nix |
| Treesitter errors | Run `:checkhealth nvim-treesitter`; update grammar pins (tree-sitter.nix) |
| Formatting skipped | Check `:echo &filetype`; ensure Conform has formatter configured |
| Copilot absent | Not enabled by default—add plugin + auth token |

## 📦 Managed Tools

- Language Servers (lua-language-server, tsserver / deno, pyright, jsonls, etc.)
- Formatters (stylua, prettier, black, shfmt)
- Linters (eslint, pylint, codespell)
- Clipboard helpers (xclip / wl-clipboard)

All via Nix: no manual npm/pip installs needed.

## 📸 Screenshots (Optional)

Placeholder: Add screenshots (theme, telescope, diagnostics) here.

## 🤝 Contributing

1. Fork & branch: `git switch -c feat/<topic>`
2. Code / config
3. Run gates (see above)
4. Conventional commit
5. PR with summary & reasoning

## 📚 Resources

- Neovim: https://neovim.io/doc/
- Nix Manual: https://nixos.org/manual/nix/stable/
- Home Manager Options: https://nix-community.github.io/home-manager/options.html
- Catppuccin: https://github.com/catppuccin/nvim

## 📄 License

MIT (see LICENSE)

## ⭐ Acknowledgments

Nix / Neovim communities & plugin authors (see `nvim/lua/plugins/`)

---

Built with ❤️ using Nix & Neovim
