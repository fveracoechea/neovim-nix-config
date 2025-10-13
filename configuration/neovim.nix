inputs: {
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    lazygit
    gh
    fzf
    graphql-language-service-cli
  ];

  # Enable management of XDG base directories
  xdg.enable = lib.mkDefault true;

  xdg.configFile."nvim" = {
    recursive = true;
    source = ../nvim;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = lib.fileContents ../nvim/init.lua;

    extraPackages = with pkgs;
      lib.optionals pkgs.stdenv.isLinux [
        xclip
        wl-clipboard
      ]
      ++ [
        ## Language Servers
        nil # Nix LSP
        lua-language-server
        deno # Deno runtime (LSP + fmt)
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
      ];

    plugins = let
      cmp-minikind = pkgs.vimUtils.buildVimPlugin {
        name = "cmp-minikind";
        src = pkgs.fetchFromGitHub {
          owner = "tranzystorekk";
          repo = "cmp-minikind.nvim";
          rev = "935ee02cd415ee218787a8549930a3443f1e127b";
          hash = "sha256-kYZX+JCogqibliL9wIbw8Ya+LZSOoQDVINMUMbFQNVA=";
        };
      };
    in
      with pkgs.vimPlugins; [
        ## Syntax Highlighting
        (nvim-treesitter.withPlugins (import ./tree-sitter.nix {inherit pkgs inputs;}))

        ## Core Dependencies
        plenary-nvim
        nui-nvim

        # Statusline
        lualine-nvim
        lualine-lsp-progress

        ## Completion System
        nvim-cmp
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        cmp-minikind
        copilot-lua
        copilot-cmp

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
      ];
  };
}
