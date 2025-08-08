inputs: {
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.lazygit pkgs.gh pkgs.fzf];

  # Enable management of XDG base directories
  xdg.enable = lib.mkDefault true;
  xdg.configFile."nvim/lua/lsp-servers.lua".source = ./lua/lsp-servers.lua;
  xdg.configFile."nvim/lua/lsp-settings.lua".source = ./lua/lsp-settings.lua;
  xdg.configFile."nvim/lua/keymaps.lua".source = ./lua/keymaps.lua;
  xdg.configFile."nvim/lua/options.lua".source = ./lua/options.lua;

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
      toLuaType = builtins.map (plugin: plugin // {type = "lua";});

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

      # Plugins that don't require configuration
      plain = with pkgs.vimPlugins; [
        ## Core Dependencies
        plenary-nvim
        nui-nvim
        # Removed nvim-web-devicons - replaced by mini.icons

        ## UI Enhancements
        dressing-nvim
        which-key-nvim

        ## Navigation & Movement
        vim-tmux-navigator
        # Removed nvim-surround - replaced by mini.surround

        ## Treesitter Extensions
        nvim-ts-context-commentstring
        nvim-ts-autotag

        ## LSP & Development
        nvim-lsp-file-operations
        lazydev-nvim
        trouble-nvim

        ## Custom Plugins
        import_cost-nvim
      ];

      # Plugins that require configuration
      withConfig = with pkgs.vimPlugins; [
        ## Mini.nvim - Swiss Army knife plugin collection
        {
          plugin = mini-nvim;
          config = lib.fileContents ./lua/plugins/mini.lua;
        }

        ## Snacks.nvim - Multi-plugin library
        {
          plugin = snacks-nvim;
          config = lib.fileContents ./lua/plugins/snacks.lua;
        }

        ## File Management
        {
          plugin = yazi-nvim;
          config = lib.fileContents ./lua/plugins/yazi.lua;
        }

        ## UI & Theme
        {
          plugin = catppuccin-nvim;
          config = lib.fileContents ./lua/plugins/catppuccin.lua;
        }
        {
          plugin = noice-nvim;
          config = lib.fileContents ./lua/plugins/noice.lua;
        }

        ## AI Integration
        {
          plugin = copilot-lua;
          config = lib.fileContents ./lua/plugins/copilot.lua;
        }

        ## Language Support & LSP
        {
          plugin = nvim-lspconfig;
          config = lib.fileContents ./lua/plugins/lspconfig.lua;
        }
        {
          plugin = hover-nvim;
          config = lib.fileContents ./lua/plugins/hover.lua;
        }
        {
          plugin = tailwind-tools-nvim;
          config = lib.fileContents ./lua/plugins/tailwind-tools.lua;
        }

        ## Code Formatting & Linting
        {
          plugin = conform-nvim;
          config = lib.fileContents ./lua/plugins/conform.lua;
        }
        {
          plugin = nvim-lint;
          config = lib.fileContents ./lua/plugins/lint.lua;
        }
        {
          plugin = none-ls-nvim;
          config = lib.fileContents ./lua/plugins/none-ls.lua;
        }

        ## Code Analysis & Refactoring
        {
          plugin = refactoring-nvim;
          config = lib.fileContents ./lua/plugins/refactoring.lua;
        }

        ## Comments & Documentation
        # Removed comment-nvim - replaced by mini.comment

        ## Git Integration
        {
          plugin = gitsigns-nvim;
          config = lib.fileContents ./lua/plugins/gitsigns.lua;
        }

        ## Screenshots
        {
          plugin = codesnap-nvim;
          config = lib.fileContents ./lua/plugins/codesnap.lua;
        }

        ## Syntax Highlighting
        {
          plugin = nvim-treesitter.withPlugins treeSitterGrammars;
          config = lib.fileContents ./lua/plugins/treesitter.lua;
        }
      ];
    in
      plain
      ++ (toLuaType withConfig);
  };
}
