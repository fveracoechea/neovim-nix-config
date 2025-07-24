# 🚀 Neovim Nix Configuration

A modern, feature-rich Neovim configuration built with Nix flakes and managed through Home Manager. This setup provides a complete IDE experience with LSP support, intelligent completion, and a beautiful UI.

## ✨ Features

### 🎨 **Modern UI & Theme**
- **Catppuccin Mocha** theme with transparent background
- **Lualine** status bar with LSP progress
- **Alpha** dashboard for quick project access
- **Noice** enhanced command line and notifications
- **Which-key** popup for keybinding hints

### 🧠 **Intelligent Code Editing**
- **LSP Integration** with 10+ language servers
- **GitHub Copilot** AI-powered code completion
- **Treesitter** syntax highlighting for 20+ languages
- **nvim-cmp** intelligent autocompletion
- **Auto-pairs** and **nvim-surround** for efficient editing

### 🔍 **Powerful Navigation**
- **Telescope** fuzzy finder for files, buffers, and more
- **Yazi** file manager integration
- **Auto-session** for project session management
- **Gitsigns** Git integration with line-by-line changes

### 🛠 **Development Tools**
- **Conform** for code formatting (Prettier, Stylua, Black, etc.)
- **nvim-lint** for real-time linting
- **Refactoring** tools for code improvement
- **CodeSnap** for beautiful code screenshots
- **Todo Comments** highlighting and navigation

### 📦 **Language Support**
- **Web**: TypeScript, JavaScript, HTML, CSS, Vue, Svelte, React
- **Systems**: Nix, Lua, Bash, C, Python
- **Data**: JSON, YAML, Markdown, GraphQL
- **DevOps**: Dockerfile, Nginx configs

## 🏗️ Architecture

```
neovim-nix-config/
├── flake.nix              # Nix flake definition
├── neovim.nix             # Main Neovim configuration
├── lua/
│   ├── options.lua        # Neovim options and settings
│   ├── keymaps.lua        # Key mappings
│   ├── lsp-servers.lua    # LSP server configurations
│   ├── lsp-settings.lua   # LSP-specific settings
│   └── plugins/           # Individual plugin configurations
│       ├── telescope.lua
│       ├── cmp.lua
│       ├── lspconfig.lua
│       └── ...
├── AGENTS.md              # Guidelines for AI coding agents
└── IMPROVEMENTS.md        # Planned enhancements
```

## 🚀 Installation

### Prerequisites
- [Nix](https://nixos.org/download.html) with flakes enabled
- [Home Manager](https://github.com/nix-community/home-manager)

### Quick Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/neovim-nix-config.git
   cd neovim-nix-config
   ```

2. **Add to your Home Manager configuration:**
   ```nix
   # In your home.nix
   imports = [
     ./neovim-nix-config/neovim.nix
   ];
   ```

3. **Or use as a flake input:**
   ```nix
   # In your flake.nix
   inputs = {
     neovim-config.url = "github:yourusername/neovim-nix-config";
   };
   
   # In your home configuration
   imports = [
     inputs.neovim-config.homeManagerModules.default
   ];
   ```

4. **Rebuild your Home Manager configuration:**
   ```bash
   home-manager switch
   ```

## ⚡ Quick Start

### Essential Keybindings

| Key | Action | Description |
|-----|--------|-------------|
| `<Space>` | Leader key | Primary modifier for custom mappings |
| `<C-n>` | File manager | Open Yazi in current working directory |
| `<leader>e` | File explorer | Open Yazi at current file location |
| `<leader>ff` | Find files | Telescope file finder |
| `<leader>fs` | Find string | Live grep in project |
| `<leader>b` | Find buffers | Open buffer list |
| `<leader>lg` | Lazygit | Open Git interface |
| `<C-s>` | Save file | Quick save |

### LSP Features
- `K` - Hover documentation
- `gd` - Go to definition  
- `gr` - Show references
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions

### Development Workflow
1. **Open project**: `cd your-project && nvim`
2. **Find files**: `<leader>ff`
3. **Search code**: `<leader>fs`
4. **Navigate**: Use LSP features (`gd`, `gr`)
5. **Git operations**: `<leader>lg` for Lazygit
6. **Format code**: Automatic on save via Conform

## 🔧 Customization

### Adding New Plugins

1. **Add to `neovim.nix`:**
   ```nix
   # For plugins without configuration
   plain = with pkgs.vimPlugins; [
     your-new-plugin
   ];
   
   # For plugins with configuration
   withConfig = [
     {
       plugin = your-configured-plugin;
       config = lib.fileContents ./lua/plugins/your-plugin.lua;
     }
   ];
   ```

2. **Create plugin configuration:**
   ```bash
   touch lua/plugins/your-plugin.lua
   ```

### Modifying Keybindings
Edit `lua/keymaps.lua` to add or modify key mappings:
```lua
local map = vim.keymap.set
map("n", "<leader>your-key", "<CMD>YourCommand<CR>", { desc = "Your description" })
```

### LSP Configuration
Add new language servers in `lua/lsp-servers.lua`:
```lua
servers = {
  your_language_server = {
    settings = {
      -- Server-specific settings
    },
  },
}
```

## 🛠️ Development

### Building & Testing
```bash
# Check flake syntax
nix flake check

# Build configuration
nix build

# Format Lua code
stylua .

# Update dependencies
nix flake update
```

### Code Style
- **Lua**: 2-space indentation, configured via `.stylua.toml`
- **Nix**: 2-space indentation, descriptive variable names
- **Comments**: Use `##` for section headers, `--` for line comments

## 📋 Requirements

### Nix Packages
All required packages are managed through Nix:
- Language servers (LSP, TypeScript, Lua, etc.)
- Formatters (Prettier, Stylua, Black)
- Linters (ESLint, Pylint, Codespell)
- System tools (xclip, wl-clipboard)

### External Dependencies
- **Git** - For version control features
- **Node.js** - For some language servers (managed by Nix)
- **Python** - For Python development (managed by Nix)

## 🤝 Contributing

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Follow the code style** guidelines in `AGENTS.md`
4. **Test your changes**: `nix flake check`
5. **Submit a pull request**

### Development Workflow
- Use conventional commits
- Run `stylua .` before committing
- Ensure `nix flake check` passes
- Update `IMPROVEMENTS.md` for planned features

## 📚 Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [Nix Manual](https://nixos.org/manual/nix/stable/)
- [Home Manager Options](https://nix-community.github.io/home-manager/options.html)
- [Catppuccin Theme](https://github.com/catppuccin/nvim)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⭐ Acknowledgments

- [NixOS Community](https://nixos.org/) for the amazing package manager
- [Neovim Contributors](https://github.com/neovim/neovim) for the best editor
- [Plugin Authors](lua/plugins/) for their incredible work
- [Catppuccin](https://catppuccin.com/) for the beautiful theme

---

*Built with ❤️ using Nix and Neovim*