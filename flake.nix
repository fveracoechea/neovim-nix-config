{
  description = "Neovim Home Manager configurations";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    tree-sitter-nginx = {
      url = "gitlab:joncoole/tree-sitter-nginx";
      flake = false;
    };
  };

  outputs = inputs: {
    homeManagerModules.default = import ./configuration inputs;
  };
}
