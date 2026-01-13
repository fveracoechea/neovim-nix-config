inputs: {
  lib,
  pkgs,
  ...
}: {
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
        nil
        lua-language-server
        deno
        typescript
        typescript-language-server
        vscode-langservers-extracted
        tailwindcss-language-server
        graphql-language-service-cli
        nginx-language-server
        bash-language-server
        stylua
        alejandra
        shfmt
        isort
        black
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
        nvim-treesitter.withAllGrammars
        plenary-nvim
        nui-nvim
        lualine-nvim
        nvim-cmp
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        cmp-minikind
        copilot-lua
        copilot-cmp
        vim-tmux-navigator
        nvim-ts-context-commentstring
        nvim-ts-autotag
        nvim-lsp-file-operations
        trouble-nvim
        mini-nvim
        snacks-nvim
        yazi-nvim
        catppuccin-nvim
        nvim-lspconfig
        tailwind-tools-nvim
        conform-nvim
        nvim-lint
        gitsigns-nvim
        codesnap-nvim
        opencode-nvim
      ];
  };
}
