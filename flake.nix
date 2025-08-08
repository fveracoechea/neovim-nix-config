{
  description = "Neovim Home Manager configurations";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    import_cost-nvim = {
      url = "github:barrett-ruth/import-cost.nvim";
      flake = false;
    };

    cmp-mini-snippets = {
      url = "https://github.com/abeldekat/cmp-mini-snippets";
      flake = false;
    };

    tree-sitter-nginx = {
      url = "gitlab:joncoole/tree-sitter-nginx";
      flake = false;
    };
  };

  outputs = inputs: {
    homeManagerModules.default = import ./configuration inputs;
  };
}
