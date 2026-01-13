{
  description = "Neovim Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = inputs: {
    homeManagerModules.default = import ./nix inputs;
  };
}
