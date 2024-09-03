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

    extraPackages = with pkgs; [
      xclip
      wl-clipboard

      # LSP
      luajitPackages.lua-lsp
      nil
    ];

    plugins = let
      toLuaType = builtins.map (plugin: plugin // {type = "lua";});

      plain = with pkgs.vimPlugins; [
        # Utils
        plenary-nvim
        dressing-nvim
        nvim-web-devicons
        vim-tmux-navigator

        nvim-lspconfig

        # CMP
        nvim-path
        cmp-buffer
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        lsp-file-operations-nvim

        nvim-ts-context-commentstring

        which-key-nvim
        lazygit-nvim

        import_cost-nivm
        lazydev-nvim
      ];

      withConfig = with pkgs.vimPlugins; [
        {
          plugin = alpha;
          config = lib.fileContents ../lua/lua/plugins/alpha.lua;
        }
        {
          plugin = auto-session;
          config = lib.fileContents ../lua/lua/plugins/auto-session.lua;
        }
        {
          plugin = nvim-autopairs;
          config = lib.fileContents ../lua/lua/plugins/autopairs.lua;
        }
        {
          plugin = bufferline-nvim;
          config = lib.fileContents ../lua/lua/plugins/bufferline.lua;
        }
        {
          plugin = catppuccin-nvim;
          config = lib.fileContents ../lua/lua/plugins/catppuccin.lua;
        }
        {
          plugin = nvim-cmp;
          config = lib.fileContents ../lua/lua/plugins/cmp.lua;
        }
        {
          plugin = codesnap-nvim;
          config = lib.fileContents ../lua/lua/plugins/codesnap.lua;
        }
        {
          plugin = comment-nvim;
          config = lib.fileContents ../lua/lua/plugins/comments.lua;
        }
        {
          plugin = conform-nvim;
          config = lib.fileContents ../lua/lua/plugins/conform.lua;
        }
        {
          plugin = hover-nvim;
          config = lib.fileContents ../lua/lua/plugins/hover.lua;
        }
        {
          plugin = indent-blankline-nvim;
          config = lib.fileContents ../lua/lua/plugins/indent-blankline.lua;
        }
        {
          plugin = nvim-lint;
          config = lib.fileContents ../lua/lua/plugins/lint.lua;
        }
      ];
    in
      plain
      ++ (toLuaType withConfig);
  };
}
