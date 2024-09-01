{
  description = "Neovim cofigurations";

  inputs = {
    # NixOS official package sources
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {...}: {
    homeManagerModules.neovim = import ./modules;
  };
}
