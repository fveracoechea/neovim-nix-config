{
  description = "Neovim Home Manager configurations";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24_05.url = "github:nixos/nixpkgs/release-24.05";

    import_cost-nvim = {
      url = "github:barrett-ruth/import-cost.nvim";
      flake = false;
    };

    lazydev-nvim = {
      url = "github:folke/lazydev.nvim";
      flake = false;
    };

    lsp-file-operations-nvim = {
      url = "github:antosha417/nvim-lsp-file-operations";
      flake = false;
    };

    tree-sitter-nginx = {
      url = "gitlab:joncoole/tree-sitter-nginx";
      flake = false;
    };
  };

  outputs = inputs: {
    homeManagerModules.default = import ./neovim.nix inputs;
  };
}
