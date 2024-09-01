{lib, ...}: {
  # Enable management of XDG base directories
  xdg.enable = lib.mkDefault true;

  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  # };
}
