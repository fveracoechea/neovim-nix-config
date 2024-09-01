{
  lib,
  pkgs,
  ...
}: {
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
      toLuaType = builtins.map (p: p // {type = "lua";});

      withConfig = with pkgs.vimPlugins; [
        {
          plugin = auto-session;
          config = lib.fileContents ../lua/lua/plugins/auto-session.lua;
        }
      ];

      plain = with pkgs.vimPlugins; [
        plenary-nvim
        dressing-nvim
        nvim-web-devicons
        vim-tmux-navigator

        nvim-lspconfig
        nvim-cmp
        cpm-nvim-lsp

        alpha
        catppuccin-nvim
        which-key-nvim

        nvim-autopairs
      ];
    in
      plain
      ++ toLuaType withConfig;
  };
}
