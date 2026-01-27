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
    initLua = lib.fileContents ../nvim/init.lua;

    extraPackages = with pkgs;
      lib.optionals pkgs.stdenv.isLinux [
        xclip
        wl-clipboard
      ]
      ++ [
        # nil
        nixd
        biome
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
      cmp-mini-snippets = pkgs.vimUtils.buildVimPlugin {
        name = "cmp-mini-snippets";
        src = fetchFromGitHub {
          owner = "abeldekat";
          repo = "cmp-mini-snippets";
          rev = "582aea215ce2e65b880e0d23585c20863fbb7604";
          hash = "sha256-gSvhxrjz6PZBgqbb4eBAwWEWSdefM4qL3nb75qGPaFA=";
        };
      };
    in
      with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        todo-comments-nvim
        plenary-nvim
        nui-nvim
        lualine-nvim
        nvim-cmp
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        cmp-mini-snippets
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
