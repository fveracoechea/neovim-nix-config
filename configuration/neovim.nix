inputs: {
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.lazygit pkgs.gh pkgs.fzf];

  # Enable management of XDG base directories
  xdg.enable = lib.mkDefault true;
  xdg.configFile."nvim/lua/options.lua".source = ../lua/options.lua;
  xdg.configFile."nvim/lua/keymaps.lua".source = ../lua/keymaps.lua;
  xdg.configFile."nvim/lua/lsp-servers.lua".source = ../lua/lsp-servers.lua;
  xdg.configFile."nvim/lua/lsp-settings.lua".source = ../lua/lsp-settings.lua;
  xdg.configFile."nvim/lua/plugins" = {
    recursive = true;
    source = ../lua/plugins;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig =
      # lua
      ''
        require "options";
        require "keymaps";

        require "plugins.mini";
        require "plugins.snacks";
        require "plugins.yazi";
        require "plugins.catppuccin";
        require "plugins.noice";
        require "plugins.copilot";
        require "plugins.lspconfig";
        require "plugins.hover";
        require "plugins.tailwind-tools";
        require "plugins.conform";
        require "plugins.lint";
        require "plugins.none-ls";
        require "plugins.refactoring";
        require "plugins.gitsigns";
        require "plugins.codesnap";
        require "plugins.treesitter";
      '';

    extraPackages = with pkgs; [
      ## System Tools
      xclip
      wl-clipboard

      ## Language Servers
      nil # Nix LSP
      lua-language-server
      typescript
      typescript-language-server
      vscode-langservers-extracted # HTML, CSS, JSON, ESLint
      tailwindcss-language-server
      graphql-language-service-cli
      nginx-language-server
      bash-language-server

      ## Formatters
      stylua # Lua
      alejandra # Nix
      shfmt # Shell
      isort # Python imports
      black # Python

      ## Linters & Static Analysis
      pylint
      pyright
      eslint_d
      proselint # Prose
      codespell # Spell check
    ];

    plugins = let
      # Custom plugin from external input
      import_cost-nvim = pkgs.vimUtils.buildVimPlugin {
        name = "import_cost-nvim";
        src = inputs.import_cost-nvim;
      };

      # Tree-sitter grammars configuration
      treeSitterGrammars = p: [
        # Core languages
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-c

        # Web technologies
        p.tree-sitter-javascript
        p.tree-sitter-typescript
        p.tree-sitter-tsx
        p.tree-sitter-html
        p.tree-sitter-css
        p.tree-sitter-vue
        p.tree-sitter-svelte
        p.tree-sitter-graphql

        # Data formats
        p.tree-sitter-json
        p.tree-sitter-yaml
        p.tree-sitter-markdown
        p.tree-sitter-markdown-inline

        # Other languages
        p.tree-sitter-python
        p.tree-sitter-prisma
        p.tree-sitter-dockerfile

        # Build systems
        p.tree-sitter-make
        p.tree-sitter-cmake

        # Misc
        p.tree-sitter-gitignore
        p.tree-sitter-query
        p.tree-sitter-vimdoc

        # Custom grammar
        (pkgs.tree-sitter.buildGrammar {
          language = "nginx";
          version = "unstable-2024-10-04";
          src = inputs.tree-sitter-nginx;
        })
      ];
    in
      with pkgs.vimPlugins; [
        ## Core Dependencies
        plenary-nvim
        nui-nvim
        which-key-nvim

        ## Navigation & Movement
        vim-tmux-navigator

        ## Treesitter Extensions
        nvim-ts-context-commentstring
        nvim-ts-autotag

        ## LSP & Development
        nvim-lsp-file-operations
        lazydev-nvim
        trouble-nvim

        ## Plugin Consolidation
        mini-nvim # Swiss Army knife plugin collection
        snacks-nvim # Multi-plugin library

        ## File Management
        yazi-nvim

        ## UI & Theme
        catppuccin-nvim
        noice-nvim

        ## AI Integration
        copilot-lua

        ## Language Support & LSP
        nvim-lspconfig
        hover-nvim
        tailwind-tools-nvim

        ## Code Formatting & Linting
        conform-nvim
        nvim-lint
        none-ls-nvim

        ## Code Analysis & Refactoring
        refactoring-nvim

        ## Git Integration
        gitsigns-nvim

        ## Screenshots
        codesnap-nvim

        ## Syntax Highlighting
        (nvim-treesitter.withPlugins treeSitterGrammars)

        ## Custom Plugins
        import_cost-nvim
      ];
  };
}
