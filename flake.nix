{
  description = "Neovim cofigurations";

  inputs = {
    # NixOS official package sources
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    import-cost-nvim = {
      url = "github:barrett-ruth/import-cost.nvim";
      flake = false;
    };
  };

  outputs = {...} @ inputs: {
    homeManagerModules.neovim = {...} @ args: (import ./modules inputs args);
  };
}
