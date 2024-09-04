inputs: {
  lib,
  pkgs,
  ...
}: {
  imports = [
    (import ./overlays.nix {inherit inputs;})
  ];

  home.packages = [pkgs.lazygit];

  # Enable management of XDG base directories
  xdg.enable = lib.mkDefault true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      ${lib.fileContents ../lua/options.lua}
      ${lib.fileContents ../lua/keymaps.lua}
    '';

    extraPackages = with pkgs; [
      # # Tools --
      xclip
      wl-clipboard
      # # LSP --
      nil
      luajitPackages.lua-lsp
      typescript
      typescript-language-server
      vscode-langservers-extracted # html, css, json and eslint
      tailwindcss-language-server
      nodePackages.graphql-language-service-cli
      emmet-language-server
      nginx-language-server
      bash-language-server
      # # Formatters --
      prettierd
      stylua
      isort
      black
      shfmt
      alejandra
      # # Linters --
      pylint
      pyright
      eslint_d
      codespell
    ];

    plugins = let
      toLuaType = builtins.map (plugin: plugin // {type = "lua";});

      plain = with pkgs.vimPlugins; [
        # Utils
        plenary-nvim
        dressing-nvim
        nvim-web-devicons
        vim-tmux-navigator

        # CMP
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        lsp-file-operations-nvim
        lualine-lsp-progress

        # Treesitter
        nvim-ts-context-commentstring
        nvim-ts-autotag

        which-key-nvim
        lazygit-nvim
        nvim-surround
        telescope-fzf-native-nvim

        import_cost-nivm
        lazydev-nvim
      ];

      withConfig = with pkgs.vimPlugins; [
        {
          plugin = alpha;
          config = lib.fileContents ../lua/plugins/alpha.lua;
        }
        {
          plugin = auto-session;
          config = lib.fileContents ../lua/plugins/auto-session.lua;
        }
        {
          plugin = nvim-autopairs;
          config = lib.fileContents ../lua/plugins/autopairs.lua;
        }
        {
          plugin = bufferline-nvim;
          config = lib.fileContents ../lua/plugins/bufferline.lua;
        }
        {
          plugin = catppuccin-nvim;
          config = lib.fileContents ../lua/plugins/catppuccin.lua;
        }
        {
          plugin = nvim-cmp;
          config = lib.fileContents ../lua/plugins/cmp.lua;
        }
        {
          plugin = codesnap-nvim;
          config = lib.fileContents ../lua/plugins/codesnap.lua;
        }
        {
          plugin = comment-nvim;
          config = lib.fileContents ../lua/plugins/comments.lua;
        }
        {
          plugin = conform-nvim;
          config = lib.fileContents ../lua/plugins/conform.lua;
        }
        {
          plugin = hover-nvim;
          config = lib.fileContents ../lua/plugins/hover.lua;
        }
        {
          plugin = indent-blankline-nvim;
          config = lib.fileContents ../lua/plugins/indent-blankline.lua;
        }
        {
          plugin = nvim-lint;
          config = lib.fileContents ../lua/plugins/lint.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = lib.fileContents ../lua/plugins/lspconfig.lua;
        }
        {
          plugin = lualine-nvim;
          config = lib.fileContents ../lua/plugins/lualine.lua;
        }
        {
          plugin = none-ls-nvim;
          config = lib.fileContents ../lua/plugins/none-ls.lua;
        }
        {
          plugin = telescope-nvim;
          config = lib.fileContents ../lua/plugins/telescope.lua;
        }
        {
          plugin = todo-comments-nvim;
          config = lib.fileContents ../lua/plugins/todo-comments.lua;
        }
        {
          plugin = nvim-tree-lua;
          config = lib.fileContents ../lua/plugins/nvim-tree.lua;
        }
        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-javascript
            p.tree-sitter-typescript
            p.tree-sitter-vue
            p.tree-sitter-tsx
            p.tree-sitter-yaml
            p.tree-sitter-html
            p.tree-sitter-css
            p.tree-sitter-prisma
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-svelte
            p.tree-sitter-graphql
            p.tree-sitter-dockerfile
            p.tree-sitter-gitignore
            p.tree-sitter-query
            p.tree-sitter-vimdoc
            p.tree-sitter-c
            p.tree-sitter-make
            p.tree-sitter-cmake
            (pkgs.tree-sitter.buildGrammar {
              language = "nginx";
              version = "unstable-2024-10-04";
              src = inputs.tree-sitter-nginx;
            })
          ]);
          config = lib.fileContents ./lua/plugins/treesitter.lua;
        }
      ];
    in
      plain
      ++ (toLuaType withConfig);
  };
}
